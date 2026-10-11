import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/backend/cloud_backend.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/support/support_contact.dart';
import '../../../projects/data/repositories/mock_project_repository.dart';
import '../../../tasks/data/repositories/mock_task_repository.dart';
import '../../../tasks/domain/entities/construction_task.dart';
import '../../../tasks/domain/enums/task_status.dart';

/// Главный экран: помощник, мои задачи и все разделы на одном экране.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _Section {
  const _Section(this.label, this.icon, this.route, this.color);

  final String label;
  final IconData icon;
  final String route;
  final Color color;
}

class _HomeScreenState extends State<HomeScreen> {
  static const _mainSections = <_Section>[
    _Section('Новая задача', Icons.add_task, AppRoutes.newTask, Color(0xFF2F80ED)),
    _Section('Фотоотчёт', Icons.add_a_photo_outlined, AppRoutes.photoReports, Color(0xFF9B51E0)),
    _Section('Проекты', Icons.apartment_outlined, AppRoutes.projects, Color(0xFF27AE60)),
    _Section('Финансы', Icons.account_balance_wallet_outlined, AppRoutes.finance, Color(0xFFF2994A)),
    _Section('Сотрудники', Icons.groups_2_outlined, AppRoutes.employees, Color(0xFF00A3A3)),
    _Section('Документы', Icons.folder_outlined, AppRoutes.documents, Color(0xFF56CCF2)),
    _Section('Календарь', Icons.event_outlined, AppRoutes.calendar, Color(0xFFEB5757)),
    _Section('Ещё', Icons.apps, '', Color(0xFF828282)),
  ];

  static const _moreSections = <_Section>[
    _Section('Компания', Icons.business_outlined, AppRoutes.company, Color(0xFF2F80ED)),
    _Section('Отчёты', Icons.insights_outlined, AppRoutes.reports, Color(0xFF27AE60)),
    _Section('Чертежи', Icons.architecture_outlined, AppRoutes.drawings, Color(0xFF9B51E0)),
    _Section('Склад', Icons.inventory_2_outlined, AppRoutes.warehouse, Color(0xFFF2994A)),
    _Section('Оборудование', Icons.construction_outlined, AppRoutes.equipment, Color(0xFF00A3A3)),
    _Section('Транспорт', Icons.local_shipping_outlined, AppRoutes.vehicles, Color(0xFF56CCF2)),
    _Section('Уведомления', Icons.notifications_outlined, AppRoutes.notifications, Color(0xFFEB5757)),
    _Section('Поиск', Icons.search, AppRoutes.globalSearch, Color(0xFF828282)),
    _Section('Админ-панель', Icons.admin_panel_settings_outlined, AppRoutes.admin, Color(0xFF2F80ED)),
    _Section('Настройки', Icons.settings_outlined, AppRoutes.settings, Color(0xFF828282)),
  ];

  final _askController = TextEditingController();
  final _taskRepository = const MockTaskRepository();

  CloudBackend get _backend => CloudBackend.instance;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    _askController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    if (!_backend.hasSession) {
      return;
    }
    try {
      await _backend.syncAll();
    } catch (_) {
      // Без сети показываем то, что уже загружено.
    }
    if (mounted) {
      setState(() {});
    }
  }

  String get _myName => _backend.membership?.fullName ?? 'Пользователь 1';

  List<ConstructionTask> _myOpenTasks() {
    final tasks = _taskRepository
        .getTasks()
        .where((ConstructionTask t) =>
            t.status != TaskStatus.completed &&
            (t.assignedEmployee == _myName || t.assignedEmployees.contains(_myName)))
        .toList()
      ..sort((ConstructionTask a, ConstructionTask b) => a.deadline.compareTo(b.deadline));
    return tasks;
  }

  void _ask([String? text]) {
    final query = (text ?? _askController.text).trim();
    _askController.clear();
    FocusScope.of(context).unfocus();
    context.go(
      query.isEmpty ? AppRoutes.assistant : Uri(path: AppRoutes.assistant, queryParameters: <String, String>{'q': query}).toString(),
    );
  }

  Future<void> _toggleDone(ConstructionTask task) async {
    final updated = task.copyWith(status: TaskStatus.completed, progress: 1, updatedAt: DateTime.now());
    _taskRepository.updateTask(updated);
    setState(() {});
    try {
      await _backend.updateTaskStatus(task.id, TaskStatus.completed);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Не сохранилось: $error')));
      }
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('«${task.title}» выполнена ✅')),
      );
    }
  }

  void _openSection(_Section section) {
    if (section.route.isEmpty) {
      _showAllSections();
      return;
    }
    context.go(section.route);
  }

  void _showAllSections() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Все разделы', style: Theme.of(sheetContext).textTheme.titleLarge),
                const SizedBox(height: 12),
                _SectionGrid(
                  sections: _moreSections,
                  onTap: (_Section section) {
                    Navigator.pop(sheetContext);
                    context.go(section.route);
                  },
                ),
                const SizedBox(height: 8),
                const SupportCard(),
              ],
            ),
          ),
        );
      },
    );
  }

  String _greetingWord() {
    final hour = DateTime.now().hour;
    if (hour < 6) {
      return 'Доброй ночи';
    }
    if (hour < 12) {
      return 'Доброе утро';
    }
    if (hour < 18) {
      return 'Добрый день';
    }
    return 'Добрый вечер';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final membership = _backend.membership;
    final firstName = membership == null || membership.fullName.trim().isEmpty
        ? null
        : membership.fullName.trim().split(RegExp(r'\s+')).last;

    final allTasks = _taskRepository.getTasks();
    final now = DateTime.now();
    final openTasks = allTasks.where((ConstructionTask t) => t.status != TaskStatus.completed).toList();
    final overdue = openTasks.where((ConstructionTask t) => t.deadline.isBefore(now)).length;
    final myTasks = _myOpenTasks();
    final projects = const MockProjectRepository().getProjects().length;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        firstName == null ? _greetingWord() : '${_greetingWord()}, $firstName',
                        style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        membership?.companyName.isNotEmpty == true
                            ? membership!.companyName
                            : DateFormat('EEEE, d MMMM', Localizations.localeOf(context).toLanguageTag())
                                .format(now),
                        style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(
                  tooltip: 'Уведомления',
                  onPressed: () => context.go(AppRoutes.notifications),
                  icon: const Icon(Icons.notifications_none),
                ),
                const SizedBox(width: 6),
                IconButton.filledTonal(
                  tooltip: 'Настройки',
                  onPressed: () => context.go(AppRoutes.settings),
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _AssistantCard(controller: _askController, onSubmit: _ask),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: _StatTile(
                    value: '${openTasks.length}',
                    label: 'Открытые задачи',
                    icon: Icons.task_alt,
                    color: colorScheme.primary,
                    onTap: () => context.go(AppRoutes.tasks),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatTile(
                    value: '$overdue',
                    label: 'Просрочено',
                    icon: Icons.schedule,
                    color: overdue > 0 ? colorScheme.error : const Color(0xFF27AE60),
                    onTap: () => _ask('Просроченные задачи'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatTile(
                    value: '$projects',
                    label: 'Проекты',
                    icon: Icons.apartment_outlined,
                    color: const Color(0xFF27AE60),
                    onTap: () => context.go(AppRoutes.projects),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text('Мои задачи', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(width: 8),
                if (myTasks.isNotEmpty)
                  Badge(label: Text('${myTasks.length}')),
                const Spacer(),
                TextButton(onPressed: () => context.go(AppRoutes.tasks), child: const Text('Все')),
              ],
            ),
            if (myTasks.isEmpty)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.celebration_outlined),
                  title: const Text('Задач на вас нет'),
                  subtitle: const Text('Поставьте задачу команде через помощника'),
                  onTap: () => _ask('Поставь задачу '),
                ),
              )
            else
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: myTasks.take(4).map((ConstructionTask task) {
                    final late = task.deadline.isBefore(now);
                    return ListTile(
                      leading: IconButton(
                        tooltip: 'Выполнено',
                        icon: const Icon(Icons.radio_button_unchecked),
                        onPressed: () => _toggleDone(task),
                      ),
                      title: Text(task.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                      subtitle: Text(
                        'до ${DateFormat('d MMM', Localizations.localeOf(context).toLanguageTag()).format(task.deadline)}'
                        '${task.project.isEmpty ? '' : ' · ${task.project}'}',
                        style: TextStyle(color: late ? colorScheme.error : null),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.go('${AppRoutes.tasks}/${task.id}'),
                    );
                  }).toList(growable: false),
                ),
              ),
            const SizedBox(height: 20),
            Text('Разделы', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            _SectionGrid(sections: _mainSections, onTap: _openSection),
          ],
        ),
      ),
    );
  }
}

class _AssistantCard extends StatelessWidget {
  const _AssistantCard({required this.controller, required this.onSubmit});

  final TextEditingController controller;
  final void Function([String? text]) onSubmit;

  static const _chips = <String>['Мои задачи', 'Поставь задачу ', 'Просроченные задачи', 'Сотрудники'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[colorScheme.primary, colorScheme.tertiary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.auto_awesome, color: colorScheme.onPrimary),
              const SizedBox(width: 8),
              Text(
                'Помощник',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Напишите, что сделать: поставлю задачу, покажу, кто чем занят',
            style: TextStyle(color: colorScheme.onPrimary.withValues(alpha: 0.85)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            textInputAction: TextInputAction.send,
            textCapitalization: TextCapitalization.sentences,
            onSubmitted: (_) => onSubmit(),
            decoration: InputDecoration(
              hintText: 'Поставь задачу Иванову: ...',
              filled: true,
              fillColor: colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                tooltip: 'Спросить',
                onPressed: onSubmit,
                icon: Icon(Icons.arrow_forward, color: colorScheme.primary),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _chips
                .map(
                  (String chip) => ActionChip(
                    label: Text(chip.trim()),
                    backgroundColor: colorScheme.onPrimary.withValues(alpha: 0.15),
                    side: BorderSide.none,
                    labelStyle: TextStyle(color: colorScheme.onPrimary),
                    onPressed: () {
                      if (chip.endsWith(' ')) {
                        controller
                          ..text = chip
                          ..selection = TextSelection.collapsed(offset: chip.length);
                      } else {
                        onSubmit(chip);
                      }
                    },
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 8),
              Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionGrid extends StatelessWidget {
  const _SectionGrid({required this.sections, required this.onTap});

  final List<_Section> sections;
  final ValueChanged<_Section> onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final columns = constraints.maxWidth >= 600 ? 6 : 4;
        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
          childAspectRatio: 0.82,
          children: sections
              .map(
                (_Section section) => InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => onTap(section),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: section.color.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(section.icon, color: section.color),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        section.label,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}
