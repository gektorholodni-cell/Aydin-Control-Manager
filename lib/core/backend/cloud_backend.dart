import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/photo_reports/data/datasources/mock_photo_reports_data.dart';
import '../../features/photo_reports/domain/entities/photo_report.dart';
import '../../features/projects/data/datasources/mock_projects_data.dart';
import '../../features/projects/domain/entities/construction_project.dart';
import '../../features/tasks/data/datasources/mock_tasks_data.dart';
import '../../features/tasks/domain/entities/construction_task.dart';
import '../../features/tasks/domain/enums/task_status.dart';
import '../../features/chats/data/chats_cloud.dart';
import 'backend_config.dart';
import 'cloud_mappers.dart';

/// Компания и профиль вошедшего пользователя.
class CompanyMembership {
  const CompanyMembership({
    required this.companyId,
    required this.companyName,
    required this.inviteCode,
    required this.fullName,
    required this.role,
  });

  final String companyId;
  final String companyName;
  final String inviteCode;
  final String fullName;
  final String role;
}

/// Сотрудник компании.
class CompanyMember {
  const CompanyMember({
    required this.id,
    required this.fullName,
    required this.role,
    this.phone = '',
  });

  final String id;
  final String fullName;
  final String role;
  final String phone;
}

/// Результат попытки входа.
enum SignInResult { signedIn, invalidCredentials, emailNotConfirmed }

/// Результат регистрации.
enum SignUpResult { signedIn, confirmationEmailSent }

/// Связь приложения с Supabase: вход, данные компании, фотографии.
///
/// Экраны по-прежнему читают данные из локальных списков
/// (`mockProjects`, `mockTasks`, `mockPhotoReports`). В облачном режиме
/// [syncAll] заполняет эти списки данными компании с сервера, а методы
/// `save*` отправляют изменения обратно.
class CloudBackend {
  CloudBackend._();

  static final CloudBackend instance = CloudBackend._();

  static const photoBucket = 'photo-reports';

  bool _initialized = false;
  CompanyMembership? _membership;
  List<CompanyMember> _members = const <CompanyMember>[];

  /// Облачный режим включён (ключи заданы и клиент инициализирован).
  bool get isEnabled => _initialized;

  CompanyMembership? get membership => _membership;

  /// Сотрудники компании (загружаются в [syncAll]).
  List<CompanyMember> get members => _members;

  SupabaseClient get _client => Supabase.instance.client;

  bool get hasSession => isEnabled && _client.auth.currentSession != null;

  String? get currentEmail => isEnabled ? _client.auth.currentUser?.email : null;

  String? get currentUserId => isEnabled ? _client.auth.currentUser?.id : null;

  Future<void> initialize() async {
    if (_initialized || !BackendConfig.isCloudConfigured) {
      return;
    }
    await Supabase.initialize(
      url: BackendConfig.supabaseUrl,
      publishableKey: BackendConfig.supabaseKey,
    );
    _initialized = true;
  }

  // -------------------------------------------------------------------------
  // Вход и регистрация
  // -------------------------------------------------------------------------

  Future<SignInResult> signIn(String email, String password) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
      return SignInResult.signedIn;
    } on AuthException catch (error) {
      if (error.code == 'email_not_confirmed') {
        return SignInResult.emailNotConfirmed;
      }
      if (error.code == 'invalid_credentials' ||
          (error.code == null && error.statusCode == '400')) {
        return SignInResult.invalidCredentials;
      }
      rethrow;
    }
  }

  Future<SignUpResult> signUp(String email, String password) async {
    final response = await _client.auth.signUp(email: email, password: password);
    return response.session == null
        ? SignUpResult.confirmationEmailSent
        : SignUpResult.signedIn;
  }

  Future<void> resetPassword(String email) {
    return _client.auth.resetPasswordForEmail(email);
  }

  Future<void> signOut() async {
    _membership = null;
    _clearLocalData();
    if (isEnabled) {
      await _client.auth.signOut();
    }
  }

  // -------------------------------------------------------------------------
  // Компания
  // -------------------------------------------------------------------------

  /// Загружает компанию пользователя. `null` — пользователь ещё не
  /// создал компанию и не присоединился к существующей.
  Future<CompanyMembership?> loadMembership() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      _membership = null;
      return null;
    }
    final row = await _client
        .from('profiles')
        .select('full_name, role, companies(id, name, invite_code)')
        .eq('id', userId)
        .maybeSingle();
    _membership = row == null ? null : membershipFromRow(row);
    return _membership;
  }

  Future<CompanyMembership?> createCompany({
    required String companyName,
    required String fullName,
    required String role,
  }) async {
    await _client.rpc<dynamic>('create_company', params: <String, dynamic>{
      'p_company_name': companyName,
      'p_full_name': fullName,
      'p_role': role,
    });
    return loadMembership();
  }

  Future<CompanyMembership?> joinCompany({
    required String inviteCode,
    required String fullName,
    required String role,
  }) async {
    await _client.rpc<dynamic>('join_company', params: <String, dynamic>{
      'p_invite_code': inviteCode,
      'p_full_name': fullName,
      'p_role': role,
    });
    return loadMembership();
  }

  // -------------------------------------------------------------------------
  // Синхронизация данных
  // -------------------------------------------------------------------------

  /// Загружает проекты, задачи и фотоотчёты компании в локальные списки.
  Future<void> syncAll() async {
    if (!hasSession) {
      return;
    }
    final results = await Future.wait(<Future<List<Map<String, dynamic>>>>[
      _client.from('projects').select().order('created_at', ascending: false),
      _client.from('tasks').select().order('created_at', ascending: false),
      _client.from('photo_reports').select().order('created_at', ascending: false),
      _loadMemberRows(),
    ]);

    _members = results[3].map(memberFromRow).toList(growable: false);

    mockProjects
      ..clear()
      ..addAll(results[0].map(projectFromRow));
    mockTasks
      ..clear()
      ..addAll(results[1].map(taskFromRow));
    mockPhotoReports
      ..clear()
      ..addAll(results[2].map(photoReportFromRow));

    try {
      await ChatsCloud.instance.refresh();
    } catch (error) {
      // Чаты не должны ломать загрузку проектов и задач.
      debugPrint('Chats refresh failed: $error');
    }
  }

  /// Сотрудники компании. Колонка phone появляется в update_2.sql;
  /// если её ещё нет, загружаем список без телефонов.
  Future<List<Map<String, dynamic>>> _loadMemberRows() async {
    try {
      return await _client.from('profiles').select('id, full_name, role, phone').order('full_name');
    } on PostgrestException catch (error) {
      if (error.code != '42703') {
        rethrow;
      }
      return _client.from('profiles').select('id, full_name, role').order('full_name');
    }
  }

    /// Сохраняет телефон текущего пользователя, чтобы коллеги могли позвонить.
  Future<void> updateMyPhone(String phone) async {
    final userId = currentUserId;
    if (!hasSession || userId == null) {
      return;
    }
    await _client.from('profiles').update(<String, dynamic>{'phone': phone.trim()}).eq('id', userId);
    _members = _members
        .map(
          (member) => member.id == userId
              ? CompanyMember(id: member.id, fullName: member.fullName, role: member.role, phone: phone.trim())
              : member,
        )
        .toList(growable: false);
  }

  CompanyMember? memberById(String id) {
    for (final member in _members) {
      if (member.id == id) {
        return member;
      }
    }
    return null;
  }

  void _clearLocalData() {
    _members = const <CompanyMember>[];
    mockProjects.clear();
    mockTasks.clear();
    mockPhotoReports.clear();
    ChatsCloud.instance.clear();
  }

  Future<void> saveProject(ConstructionProject project) async {
    if (!hasSession) {
      return;
    }
    await _client.from('projects').upsert(projectToRow(project));
  }

  Future<void> saveTask(ConstructionTask task) async {
    if (!hasSession) {
      return;
    }
    await _client.from('tasks').upsert(taskToRow(task));
  }

  Future<void> deleteTask(String taskId) async {
    if (!hasSession) {
      return;
    }
    await _client.from('tasks').delete().eq('id', taskId);
  }

  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    if (!hasSession) {
      return;
    }
    await _client.from('tasks').update(<String, dynamic>{
      'status': status.name,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', taskId);
  }

  Future<void> savePhotoReport(PhotoReport report) async {
    if (!hasSession) {
      return;
    }
    await _client.from('photo_reports').upsert(photoReportToRow(report));
  }

  // -------------------------------------------------------------------------
  // Фотографии
  // -------------------------------------------------------------------------

  /// Загружает файл (фото или голосовое) в хранилище и возвращает его путь.
  Future<String> uploadPhoto({
    required String reportId,
    required Uint8List bytes,
    required String fileExtension,
    String? contentType,
  }) async {
    final companyId = _membership?.companyId;
    if (companyId == null) {
      throw StateError('No company membership');
    }
    final ext = fileExtension.isEmpty ? 'jpg' : fileExtension.toLowerCase();
    final path = '$companyId/$reportId/${DateTime.now().microsecondsSinceEpoch}.$ext';
    await _client.storage.from(photoBucket).uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(
            contentType: contentType ?? (ext == 'png' ? 'image/png' : 'image/jpeg'),
          ),
        );
    return path;
  }

  Future<void> deletePhoto(String path) async {
    if (!hasSession) {
      return;
    }
    await _client.storage.from(photoBucket).remove(<String>[path]);
  }

  /// Временная ссылка на фото (на 1 час) для показа в приложении.
  Future<String> photoUrl(String path) {
    return _client.storage.from(photoBucket).createSignedUrl(path, 3600);
  }
}
