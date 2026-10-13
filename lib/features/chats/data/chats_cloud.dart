import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/backend/cloud_backend.dart';
import '../domain/entities/chat_message.dart';
import '../domain/entities/chat_thread.dart';
import '../domain/entities/chat_user.dart';
import 'repositories/mock_chats_repository.dart';

/// Чаты компании в Supabase (таблицы из supabase/update_3.sql).
///
/// Экраны работают с [MockChatsRepository] как с локальным хранилищем:
/// [refresh] заполняет его данными с сервера, Realtime-подписка добавляет
/// новые сообщения сразу, а методы `send*`/`save*` отправляют изменения.
/// Без входа в облако (демо-режим) всё остаётся только на устройстве.
class ChatsCloud extends ChangeNotifier {
  ChatsCloud._();

  static final ChatsCloud instance = ChatsCloud._();

  static const _demoUserId = 'u1';

  RealtimeChannel? _channel;

  /// Чат, который сейчас открыт: его сообщения не считаются непрочитанными.
  String? openChatId;

  bool get isEnabled => CloudBackend.instance.hasSession;

  String get currentUserId => CloudBackend.instance.currentUserId ?? _demoUserId;

  SupabaseClient get _client => Supabase.instance.client;

  /// Загружает чаты и последние сообщения компании.
  Future<void> refresh() async {
    if (!isEnabled) {
      return;
    }
    final me = currentUserId;
    final users = CloudBackend.instance.members
        .map(
          (member) => ChatUser(
            id: member.id,
            fullName: member.fullName.isEmpty ? 'Без имени' : member.fullName,
            role: member.role,
            isOnline: false,
            lastSeen: DateTime.now(),
          ),
        )
        .toList();
    try {
      final chatRows = await _client.from('chats').select().order('last_message_at', ascending: false);
      final chatIds = chatRows.map((row) => row['id'] as String).toList();
      final messageRows = chatIds.isEmpty
          ? <Map<String, dynamic>>[]
          : await _client
              .from('chat_messages')
              .select()
              .inFilter('chat_id', chatIds)
              .order('created_at', ascending: false)
              .limit(1000);
      MockChatsRepository.replaceAll(
        users: users,
        threads: chatRows.map((row) => _threadFromRow(row, me, users)).toList(),
        messages: messageRows.reversed.map((row) => _messageFromRow(row, me)).toList(),
      );
    } on PostgrestException catch (error) {
      // Например, update_3.sql ещё не выполнен: чаты просто остаются пустыми.
      debugPrint('Chats refresh failed: ${error.message}');
      MockChatsRepository.replaceAll(users: users, threads: const [], messages: const []);
      notifyListeners();
      return;
    }
    _subscribe();
    notifyListeners();
  }

  void clear() {
    final channel = _channel;
    _channel = null;
    if (channel != null) {
      _client.removeChannel(channel);
    }
    openChatId = null;
    MockChatsRepository.clearAll();
    notifyListeners();
  }

  void _subscribe() {
    if (_channel != null) {
      return;
    }
    _channel = _client
        .channel('company-chats')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'chat_messages',
          callback: (payload) => _onMessage(payload.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'chats',
          callback: _onChat,
        )
        .subscribe();
  }

  void _onMessage(Map<String, dynamic> row) {
    if (row.isEmpty) {
      return;
    }
    final message = _messageFromRow(row, currentUserId);
    MockChatsRepository.putIncomingMessage(
      message,
      countAsUnread: !message.isMine && message.chatId != openChatId,
    );
    notifyListeners();
  }

  void _onChat(PostgresChangePayload payload) {
    if (payload.eventType == PostgresChangeEvent.delete) {
      final id = payload.oldRecord['id'] as String?;
      if (id != null) {
        MockChatsRepository.removeThread(id);
      }
    } else {
      final row = payload.newRecord;
      final thread = _threadFromRow(row, currentUserId, MockChatsRepository().getUsers());
      if (thread.memberIds.contains(currentUserId)) {
        MockChatsRepository.putThread(thread);
      } else {
        MockChatsRepository.removeThread(thread.id);
      }
    }
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Запись
  // ---------------------------------------------------------------------------

  Future<void> sendMessage(ChatMessage message) async {
    notifyListeners();
    if (!isEnabled) {
      return;
    }
    await _client.from('chat_messages').insert(<String, dynamic>{
      'id': message.id,
      'chat_id': message.chatId,
      'type': message.type.name,
      'text': message.text,
      'media_path': message.imagePath,
      'voice_duration': message.voiceDurationLabel,
    });
  }

  Future<void> createThread(ChatThread thread) async {
    notifyListeners();
    if (!isEnabled) {
      return;
    }
    await _client.from('chats').upsert(<String, dynamic>{
      'id': thread.id,
      'type': thread.type.name,
      'title': thread.title,
      'member_ids': thread.memberIds,
      'last_message': thread.lastMessage,
    });
  }

  /// Сохраняет название и участников. Личные настройки чата не отправляются.
  Future<void> saveThread(ChatThread thread) async {
    notifyListeners();
    if (!isEnabled) {
      return;
    }
    await _client.from('chats').update(<String, dynamic>{
      'title': thread.title,
      'member_ids': thread.memberIds,
    }).eq('id', thread.id);
  }

  Future<void> deleteThread(String chatId) async {
    notifyListeners();
    if (!isEnabled) {
      return;
    }
    await _client.from('chats').delete().eq('id', chatId);
  }

  void markRead(String chatId) {
    final thread = MockChatsRepository.findThread(chatId);
    if (thread != null && thread.unreadCount > 0) {
      MockChatsRepository().updateThread(thread.copyWith(unreadCount: 0));
      notifyListeners();
    }
  }

  // ---------------------------------------------------------------------------
  // Фото и голосовые
  // ---------------------------------------------------------------------------

  /// Загружает файл чата в хранилище. В демо-режиме возвращает `null`.
  Future<String?> uploadMedia({
    required String chatId,
    required Uint8List bytes,
    required String fileExtension,
    required String contentType,
  }) async {
    if (!isEnabled) {
      return null;
    }
    return CloudBackend.instance.uploadPhoto(
      reportId: 'chats/$chatId',
      bytes: bytes,
      fileExtension: fileExtension,
      contentType: contentType,
    );
  }

  /// Адрес для показа или проигрывания файла сообщения.
  Future<String> mediaUrl(String path) async {
    if (isStoragePath(path)) {
      return CloudBackend.instance.photoUrl(path);
    }
    return path;
  }

  /// Путь в хранилище Supabase (а не локальный файл или blob-ссылка).
  bool isStoragePath(String path) {
    return isEnabled && !path.startsWith('/') && !path.contains(':');
  }

  // ---------------------------------------------------------------------------
  // Преобразование строк
  // ---------------------------------------------------------------------------

  static ChatThread _threadFromRow(Map<String, dynamic> row, String me, List<ChatUser> users) {
    final type = row['type'] == 'group' ? ChatThreadType.group : ChatThreadType.private;
    final memberIds = (row['member_ids'] as List?)?.map((id) => '$id').toList() ?? <String>[];
    var title = row['title'] as String? ?? '';
    if (type == ChatThreadType.private) {
      // В личном чате каждый видит имя собеседника.
      final peerId = memberIds.firstWhere((id) => id != me, orElse: () => me);
      for (final user in users) {
        if (user.id == peerId) {
          title = user.fullName;
        }
      }
    }
    return ChatThread(
      id: row['id'] as String,
      type: type,
      title: title,
      memberIds: memberIds,
      adminId: row['admin_id'] as String? ?? '',
      lastMessage: row['last_message'] as String? ?? '',
      lastMessageAt: _date(row['last_message_at']),
      unreadCount: 0,
      isPinned: false,
      isArchived: false,
      isMuted: false,
      hasTyping: false,
    );
  }

  static ChatMessage _messageFromRow(Map<String, dynamic> row, String me) {
    final senderId = row['sender_id'] as String? ?? '';
    return ChatMessage(
      id: row['id'] as String,
      chatId: row['chat_id'] as String? ?? '',
      senderId: senderId,
      text: row['text'] as String? ?? '',
      sentAt: _date(row['created_at']),
      isMine: senderId == me,
      type: ChatMessageType.values.firstWhere(
        (type) => type.name == row['type'],
        orElse: () => ChatMessageType.text,
      ),
      imagePath: row['media_path'] as String?,
      voiceDurationLabel: row['voice_duration'] as String?,
    );
  }

  static DateTime _date(Object? value) {
    return (value is String ? DateTime.tryParse(value)?.toLocal() : null) ?? DateTime.now();
  }
}
