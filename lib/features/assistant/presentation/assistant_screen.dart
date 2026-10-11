import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/backend/cloud_backend.dart';
import '../../../core/constants/app_routes.dart';
import '../../../shared/support/support_contact.dart';
import '../../projects/data/repositories/mock_project_repository.dart';
import '../../tasks/data/repositories/mock_task_repository.dart';
import '../../tasks/domain/entities/construction_task.dart';
import '../../tasks/domain/enums/task_priority.dart';
import '../../tasks/domain/enums/task_status.dart';
import '../domain/assistant_parser.dart';

/// Помощник: ставит и показывает задачи по обычным текстовым командам.
class AssistantScreen extends StatefulWidget {
  const AssistantScreen({this.initialText, super.key});

  /// Команда, которую нужно сразу выполнить (например, с главного экрана).
  final String? initialText;

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _ChatEntry {
  _ChatEntry.user(this.text, {this.photo})
      : fromUser = true,
        tasks = const <ConstructionTask>[],
        actions = const <_EntryAction>[];

  _ChatEntry.bot(
    this.text, {
    this.tasks = const <ConstructionTask>[],
    this.actions = const <_EntryAction>[],
  })  : fromUser = false,
        photo = null;

  final bool fromUser;
  final String text;
  final Uint8List? photo;
  final List<ConstructionTask> tasks;
  final List<_EntryAction> actions;
}

class _EntryAction {
  const _EntryAction(this.label, this.icon, this.onPressed);

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
}

class _PendingPhoto {
  const _PendingPhoto(this.bytes, this.extension);

  final Uint8List bytes;
  final String extension;
}

class _AssistantScreenState extends State<AssistantScreen> {
  static const _suggestions = <String>[
    'Мои задачи',
    'Поставь задачу ',
    'Просроченные задачи',
    'Проекты',
    'Сотрудники',
    'Что ты умеешь?',
  ];

  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _imagePicker = ImagePicker();
  final _taskRepository = const MockTaskRepository();
  final List<_ChatEntry> _entries = <_ChatEntry>[];

  _PendingPhoto? _photo;
  bool _busy = false;

  CloudBackend get _backend => CloudBackend.instance;

  String get _myName => _backend.membership?.fullName ?? 'Пользователь 1';

  @override
  void initState() {
    super.initState();
    _entries.add(_ChatEntry.bot(_greeting()));
    final initial = widget.initialText?.trim();
    if (initial != null && initial.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _send(initial));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _greeting() {
    final name = _backend.membership?.fullName.split(' ').last;
    final hello = name == null || name.isEmpty ? 'Здравствуйте!' : 'Здравствуйте, $name!';
    return '$hello Я помощник Structra. Напишите, что сделать, например:\n'
        '• «Поставь задачу Иванову: проверить вентиляцию до пятницы»\n'
        '• «Какие задачи у Иванова?»\n'
        '• прикрепите фото и напишите «в задачи для Иванова»';
  }

  // ---------------------------------------------------------------------------
  // Данные для разбора команд
  // ---------------------------------------------------------------------------

  List<String> _employeeNames() {
    final names = <String>{
      ..._backend.members.map((CompanyMember member) => member.fullName),
      ..._taskRepository
          .getTasks()
          .expand((ConstructionTask task) => task.assignedEmployees),
    }..removeWhere((String name) => name.trim().isEmpty);
    return names.toList(growable: false);
  }

  List<String> _projectNames() {
    return const MockProjectRepository()
        .getProjects()
        .map((project) => project.name)
        .where((String name) => name.isNotEmpty)
        .toList(growable: false);
  }

  // ---------------------------------------------------------------------------
  // Отправка и выполнение команд
  // ---------------------------------------------------------------------------

  Future<void> _send([String? preset]) async {
    final text = (preset ?? _controller.text).trim();
    final photo = _photo;
    if ((text.isEmpty && photo == null) || _busy) {
      return;
    }
    setState(() {
      _entries.add(_ChatEntry.user(text.isEmpty ? 'Фото' : text, photo: photo?.bytes));
      _controller.clear();
      _photo = null;
      _busy = true;
    });
    _scrollToEnd();

    _ChatEntry answer;
    try {
      if (_backend.hasSession) {
        await _backend.syncAll();
      }
      final parser = AssistantParser(employees: _employeeNames(), projects: _projectNames());
      final intent = parser.parse(text, hasPhoto: photo != null);
      answer = await _execute(intent, photo);
    } catch (error) {
      answer = _ChatEntry.bot('Не получилось выполнить: $error');
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _entries.add(answer);
      _busy = false;
    });
    _scrollToEnd();
  }

  Future<_ChatEntry> _execute(AssistantIntent intent, _PendingPhoto? photo) async {
    switch (intent) {
      case CreateTasksIntent():
        return _createTasks(intent, photo);
      case ListTasksIntent():
        return _listTasks(intent);
      case CompleteTaskIntent():
        return _completeTask(intent);
      case ListProjectsIntent():
        return _listProjects();
      case ListEmployeesIntent():
        return _listEmployees();
      case SupportIntent():
        return _ChatEntry.bot(
          'Техподдержка Structra: ${SupportContact.phoneDisplay}.',
          actions: const <_EntryAction>[
            _EntryAction('Позвонить', Icons.call, SupportContact.call),
            _EntryAction('WhatsApp', Icons.chat_outlined, SupportContact.whatsApp),
          ],
        );
      case HelpIntent():
        return _ChatEntry.bot(_helpText());
      case UnknownIntent():
        return _ChatEntry.bot(
          'Я пока не понял. Я умею ставить и показывать задачи. Попробуйте так:\n'
          '• «Поставь задачу Иванову: заказать арматуру завтра»\n'
          '• «Мои задачи» или «Задачи Иванова»',
        );
    }
  }

  Future<_ChatEntry> _createTasks(CreateTasksIntent intent, _PendingPhoto? photo) async {
    if (intent.titles.isEmpty) {
      return _ChatEntry.bot(
        'Что нужно сделать? Напишите задачу после двоеточия, например:\n'
        '«Поставь задачу ${intent.assignee ?? 'Иванову'}: проверить вентиляцию до пятницы»',
      );
    }

    final now = DateTime.now();
    final deadline = intent.deadline ?? DateTime(now.year, now.month, now.day, 18).add(const Duration(days: 3));
    final assignee = intent.assignee;
    final created = <ConstructionTask>[];

    for (var i = 0; i < intent.titles.length; i++) {
      final id = 'tsk-${now.microsecondsSinceEpoch}-$i';
      final photos = <String>[];
      if (photo != null) {
        photos.add(await _storePhoto(id, photo));
      }
      final task = ConstructionTask(
        id: id,
        title: intent.titles[i],
        description: 'Поставлено через помощника: $_myName',
        priority: intent.priority,
        status: TaskStatus.notStarted,
        assignedEmployeeId: assignee == null ? 'unassigned' : 'name-$assignee',
        assignedEmployee: assignee ?? 'Не назначено',
        assignedEmployees: assignee == null ? <String>[] : <String>[assignee],
        projectId: intent.project ?? '',
        project: intent.project ?? '',
        deadline: deadline,
        startDate: now,
        progress: 0,
        estimatedCost: 0,
        updatedAt: now,
        comments: <String>[],
        activityHistory: <String>[],
        beforePhotos: photos,
        afterPhotos: <String>[],
        documents: <String>[],
      );
      await _backend.saveTask(task);
      _taskRepository.addTask(task);
      created.add(task);
    }

    final count = created.length;
    final who = assignee == null ? 'без исполнителя' : 'для $assignee';
    final buffer = StringBuffer('Готово! ${_plural(count, 'Поставил задачу', 'Поставил $count задачи', 'Поставил $count задач')} $who')
      ..write(', срок ${_formatDate(deadline)}');
    if (intent.priority != TaskPriority.medium) {
      buffer.write(', ${intent.priority == TaskPriority.critical ? 'срочно' : 'важно'}');
    }
    if (photo != null) {
      buffer.write('. Фото прикреплено');
    }
    buffer.write('.');
    if (assignee == null) {
      buffer.write('\nИсполнителя я не нашёл. Укажите его так: «для Иванова».');
    }

    return _ChatEntry.bot(
      buffer.toString(),
      tasks: created,
      actions: <_EntryAction>[
        _EntryAction('Отменить', Icons.undo, () => _undo(created)),
      ],
    );
  }

  Future<String> _storePhoto(String taskId, _PendingPhoto photo) async {
    if (_backend.hasSession) {
      return _backend.uploadPhoto(
        reportId: 'tasks/$taskId',
        bytes: photo.bytes,
        fileExtension: photo.extension,
      );
    }
    return 'photo_${DateTime.now().millisecondsSinceEpoch}.${photo.extension}';
  }

  Future<void> _undo(List<ConstructionTask> tasks) async {
    try {
      for (final task in tasks) {
        await _backend.deleteTask(task.id);
        _taskRepository.removeTask(task.id);
      }
      if (mounted) {
        setState(() => _entries.add(_ChatEntry.bot('Отменил: задачи удалены.')));
        _scrollToEnd();
      }
    } catch (error) {
      if (mounted) {
        setState(() => _entries.add(_ChatEntry.bot('Не удалось отменить: $error')));
      }
    }
  }

  _ChatEntry _listTasks(ListTasksIntent intent) {
    final name = intent.assignee ?? _myName;
    final now = DateTime.now();
    var tasks = _taskRepository.getTasks().where((ConstructionTask task) {
      if (task.status == TaskStatus.completed) {
        return false;
      }
      if (intent.onlyOverdue && intent.assignee == null) {
        return task.deadline.isBefore(now);
      }
      return task.assignedEmployees.contains(name) || task.assignedEmployee == name;
    }).toList();
    if (intent.onlyOverdue) {
      tasks = tasks.where((ConstructionTask task) => task.deadline.isBefore(now)).toList();
    }
    tasks.sort((ConstructionTask a, ConstructionTask b) => a.deadline.compareTo(b.deadline));

    final whose = intent.onlyOverdue && intent.assignee == null
        ? 'в компании'
        : intent.assignee == null
            ? 'у вас'
            : 'у $name';
    if (tasks.isEmpty) {
      return _ChatEntry.bot(
        intent.onlyOverdue ? 'Просроченных задач $whose нет 👍' : 'Открытых задач $whose нет.',
      );
    }
    final overdueCount = tasks.where((ConstructionTask t) => t.deadline.isBefore(now)).length;
    final label = intent.onlyOverdue ? 'Просроченные задачи' : 'Открытые задачи';
    final suffix = !intent.onlyOverdue && overdueCount > 0 ? ', из них просрочено: $overdueCount' : '';
    return _ChatEntry.bot('$label $whose: ${tasks.length}$suffix.', tasks: tasks);
  }

  Future<_ChatEntry> _completeTask(CompleteTaskIntent intent) async {
    final words = intent.query.split(' ').where((String w) => w.length >= 3).toList();
    ConstructionTask? best;
    var bestScore = 0;
    for (final task in _taskRepository.getTasks()) {
      if (task.status == TaskStatus.completed) {
        continue;
      }
      final title = task.title.toLowerCase().replaceAll('ё', 'е');
      final score = words.where((String w) => title.contains(w.substring(0, w.length > 5 ? w.length - 2 : w.length))).length;
      if (score > bestScore) {
        bestScore = score;
        best = task;
      }
    }
    if (best == null) {
      return _ChatEntry.bot('Не нашёл такую открытую задачу. Напишите её название точнее.');
    }
    final updated = best.copyWith(status: TaskStatus.completed, progress: 1, updatedAt: DateTime.now());
    await _backend.updateTaskStatus(best.id, TaskStatus.completed);
    _taskRepository.updateTask(updated);
    return _ChatEntry.bot('Отметил выполненной: «${best.title}» ✅', tasks: <ConstructionTask>[updated]);
  }

  _ChatEntry _listProjects() {
    final projects = const MockProjectRepository().getProjects();
    if (projects.isEmpty) {
      return _ChatEntry.bot(
        'Проектов пока нет.',
        actions: <_EntryAction>[
          _EntryAction('Создать проект', Icons.add_business_outlined, () => context.go(AppRoutes.newProject)),
        ],
      );
    }
    final lines = projects.map((project) {
      final open = _taskRepository
          .getTasks()
          .where((ConstructionTask t) => t.project == project.name && t.status != TaskStatus.completed)
          .length;
      return '• ${project.name}: ${(project.progress * 100).round()}%, открытых задач: $open';
    }).join('\n');
    return _ChatEntry.bot('Проекты (${projects.length}):\n$lines');
  }

  _ChatEntry _listEmployees() {
    final members = _backend.members;
    final invite = _backend.membership?.inviteCode;
    if (members.isEmpty) {
      return _ChatEntry.bot(
        invite == null
            ? 'Сотрудников пока нет.'
            : 'Сотрудников пока нет. Пригласите их кодом $invite: пусть зарегистрируются и выберут «Присоединиться».',
      );
    }
    final tasks = _taskRepository.getTasks();
    final lines = members.map((CompanyMember m) {
      final open = tasks
          .where((ConstructionTask t) => t.assignedEmployee == m.fullName && t.status != TaskStatus.completed)
          .length;
      return '• ${m.fullName}: открытых задач $open';
    }).join('\n');
    final hint = invite == null ? '' : '\n\nКод приглашения новых сотрудников: $invite';
    return _ChatEntry.bot('Сотрудники (${members.length}):\n$lines$hint');
  }

  String _helpText() {
    return 'Вот что я умею:\n'
        '• Ставить задачи: «Поставь задачу Иванову: заказать бетон завтра»\n'
        '• Несколько сразу: «Задачи для Иванова: замер; закупка; фото фасада»\n'
        '• Фото в задачу: прикрепите фото 📎 и напишите «в задачи для Иванова»\n'
        '• Показывать задачи: «Мои задачи», «Задачи Иванова», «Просроченные»\n'
        '• Закрывать задачи: «Выполнил замер труб»\n'
        '• «Проекты», «Сотрудники», «Техподдержка»\n\n'
        'Сроки понимаю так: сегодня, завтра, в пятницу, через 3 дня, до 15.10. '
        'Слово «срочно» делает задачу срочной. Можно диктовать голосом через микрофон на клавиатуре.';
  }

  // ---------------------------------------------------------------------------
  // Фото
  // ---------------------------------------------------------------------------

  Future<void> _pickPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Сделать фото'),
                onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Выбрать из галереи'),
                onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
    if (source == null) {
      return;
    }
    final file = await _imagePicker.pickImage(source: source, maxWidth: 1920, imageQuality: 80);
    if (file == null) {
      return;
    }
    final dot = file.name.lastIndexOf('.');
    final bytes = await file.readAsBytes();
    if (!mounted) {
      return;
    }
    setState(() {
      _photo = _PendingPhoto(bytes, dot == -1 ? 'jpg' : file.name.substring(dot + 1));
    });
  }

  // ---------------------------------------------------------------------------
  // Вспомогательное
  // ---------------------------------------------------------------------------

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 200,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  static String _plural(int n, String one, String few, String many) {
    final mod10 = n % 10;
    final mod100 = n % 100;
    if (mod10 == 1 && mod100 != 11) {
      return one;
    }
    if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
      return few;
    }
    return many;
  }

  String _formatDate(DateTime date) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat('d MMMM', locale).format(date);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.auto_awesome),
            SizedBox(width: 8),
            Text('Помощник'),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              itemCount: _entries.length + (_busy ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index == _entries.length) {
                  return const _TypingBubble();
                }
                return _EntryView(entry: _entries[index], formatDate: _formatDate);
              },
            ),
          ),
          if (_entries.length <= 1)
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _suggestions.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (BuildContext context, int index) {
                  final suggestion = _suggestions[index];
                  return ActionChip(
                    label: Text(suggestion.trim()),
                    onPressed: () {
                      if (suggestion.endsWith(' ')) {
                        _controller
                          ..text = suggestion
                          ..selection = TextSelection.collapsed(offset: suggestion.length);
                      } else {
                        _send(suggestion);
                      }
                    },
                  );
                },
              ),
            ),
          if (_photo != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(_photo!.bytes, width: 56, height: 56, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(child: Text('Фото прикреплено. Напишите, кому его отправить.')),
                  IconButton(
                    onPressed: () => setState(() => _photo = null),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    tooltip: 'Прикрепить фото',
                    onPressed: _busy ? null : _pickPhoto,
                    icon: const Icon(Icons.attach_file),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: 'Например: задачи Иванова',
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHigh,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton.filled(
                    tooltip: 'Отправить',
                    onPressed: _busy ? null : _send,
                    icon: const Icon(Icons.arrow_upward),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryView extends StatelessWidget {
  const _EntryView({required this.entry, required this.formatDate});

  final _ChatEntry entry;
  final String Function(DateTime) formatDate;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final fromUser = entry.fromUser;

    return Align(
      alignment: fromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.86),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: fromUser ? colorScheme.primary : colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: Radius.circular(fromUser ? 18 : 4),
              bottomRight: Radius.circular(fromUser ? 4 : 18),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (entry.photo != null) ...<Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(entry.photo!, height: 160, fit: BoxFit.cover),
                ),
                const SizedBox(height: 8),
              ],
              Text(
                entry.text,
                style: TextStyle(color: fromUser ? colorScheme.onPrimary : colorScheme.onSurface),
              ),
              for (final task in entry.tasks.take(20))
                _TaskTile(task: task, formatDate: formatDate),
              if (entry.actions.isNotEmpty) ...<Widget>[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: entry.actions
                      .map(
                        (_EntryAction action) => OutlinedButton.icon(
                          onPressed: action.onPressed,
                          icon: Icon(action.icon, size: 18),
                          label: Text(action.label),
                        ),
                      )
                      .toList(growable: false),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.task, required this.formatDate});

  final ConstructionTask task;
  final String Function(DateTime) formatDate;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final overdue = task.status != TaskStatus.completed && task.deadline.isBefore(DateTime.now());
    final urgent = task.priority == TaskPriority.critical || task.priority == TaskPriority.high;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.go('${AppRoutes.tasks}/${task.id}'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  task.status == TaskStatus.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: task.status == TaskStatus.completed ? Colors.green : colorScheme.outline,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(task.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(
                        <String>[
                          task.assignedEmployee,
                          'до ${formatDate(task.deadline)}',
                          if (task.project.isNotEmpty) task.project,
                        ].join(' · '),
                        style: TextStyle(
                          fontSize: 12,
                          color: overdue ? colorScheme.error : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (urgent) Icon(Icons.priority_high, color: colorScheme.error, size: 18),
                if (task.beforePhotos.isNotEmpty)
                  Icon(Icons.photo_outlined, size: 18, color: colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const SizedBox(
          width: 28,
          height: 12,
          child: LinearProgressIndicator(),
        ),
      ),
    );
  }
}
