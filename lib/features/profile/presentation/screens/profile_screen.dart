import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../../../core/localization/locale_scope.dart';
import '../../../../core/theme/theme_mode_scope.dart';
import '../../../chats/data/repositories/mock_chats_repository.dart';
import '../../../employees/data/repositories/mock_employee_repository.dart';
import '../../../tasks/data/repositories/mock_task_repository.dart';
import '../../../tasks/domain/enums/task_status.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const _pushNotificationsKey = 'structra.push_notifications_enabled';
  static const _securityLockKey = 'structra.security_lock_enabled';

  bool _notificationsEnabled = true;
  bool _securityEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadStatusFlags();
  }

  Future<void> _loadStatusFlags() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) {
      return;
    }

    setState(() {
      _notificationsEnabled = prefs.getBool(_pushNotificationsKey) ?? true;
      _securityEnabled = prefs.getBool(_securityLockKey) ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final localeController = LocaleScope.of(context);
    final themeController = ThemeModeScope.of(context);
    final selectedLanguageCode = localeController.locale.languageCode;
    final tasks = const MockTaskRepository().getTasks();
    final employees = const MockEmployeeRepository().getEmployees();
    final chats = const MockChatsRepository();
    final totalTasks = tasks.length;
    final completedTasks = tasks.where((task) => task.status == TaskStatus.completed).length;
    final onlineEmployees = employees.where((employee) => employee.isOnline).length;
    final projectsCount = tasks.map((task) => task.project).toSet().length;
    final activeChats = chats.getThreads().length;
    final latestTaskTitle = tasks.isEmpty ? '—' : tasks.first.title;
    final latestTaskStatus = tasks.isEmpty ? '—' : tasks.first.status.name;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 140,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0xFF0E4B7A),
                          Color(0xFF0F9D8E),
                          Color(0xFFF2C14E),
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: FilledButton.tonalIcon(
                          onPressed: () => context.go(AppRoutes.admin),
                          icon: const Icon(Icons.admin_panel_settings_outlined),
                          label: Text(l10n.adminTitle),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.appTitle,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.profileHeadline,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.profileDescription,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.profileAchievementsTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            _ProfileAchievementList(
              items: <_ProfileAchievementItem>[
                _ProfileAchievementItem(
                  icon: Icons.task_alt_outlined,
                  title: l10n.tasksTitle,
                  subtitle: '$totalTasks ${l10n.tasksTitle.toLowerCase()}',
                ),
                _ProfileAchievementItem(
                  icon: Icons.check_circle_outline,
                  title: l10n.statCompletedTasks,
                  subtitle: '$completedTasks ${l10n.statCompletedTasks.toLowerCase()}',
                ),
                _ProfileAchievementItem(
                  icon: Icons.groups_2_outlined,
                  title: l10n.statEmployeesOnline,
                  subtitle: '$onlineEmployees ${l10n.employeesTitle.toLowerCase()}',
                ),
                _ProfileAchievementItem(
                  icon: Icons.event_note_outlined,
                  title: l10n.profileRecentActivityTitle,
                  subtitle: '$latestTaskTitle · $latestTaskStatus',
                ),
                _ProfileAchievementItem(
                  icon: Icons.business_outlined,
                  title: l10n.projectsTitle,
                  subtitle: '$projectsCount ${l10n.projectsTitle.toLowerCase()}',
                ),
                _ProfileAchievementItem(
                  icon: Icons.chat_bubble_outline,
                  title: l10n.chatsTitle,
                  subtitle: '$activeChats ${l10n.chatsTitle.toLowerCase()}',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      l10n.languageSectionTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(l10n.languageSectionSubtitle),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: selectedLanguageCode,
                      decoration: InputDecoration(
                        labelText: l10n.languageSelectLabel,
                      ),
                      items: <DropdownMenuItem<String>>[
                        DropdownMenuItem<String>(
                          value: 'ru',
                          child: Text(l10n.languageRussian),
                        ),
                        DropdownMenuItem<String>(
                          value: 'kk',
                          child: Text(l10n.languageKazakh),
                        ),
                        DropdownMenuItem<String>(
                          value: 'en',
                          child: Text(l10n.languageEnglish),
                        ),
                      ],
                      onChanged: (String? value) {
                        if (value == null) {
                          return;
                        }
                        localeController.setLocale(Locale(value));
                      },
                    ),
                    const SizedBox(height: 12),
                    FilledButton.tonalIcon(
                      onPressed: () {
                        context.go(AppRoutes.settings);
                      },
                      icon: const Icon(Icons.settings_outlined),
                      label: Text(l10n.settingsTitle),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.business_outlined),
                    title: Text(l10n.companyTitle),
                    subtitle: Text(l10n.appTitle),
                    onTap: () => context.go(AppRoutes.company),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: Text(l10n.notificationsTitle),
                    onTap: () => context.go(AppRoutes.notifications),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.folder_outlined),
                    title: Text(l10n.documentsTitle),
                    onTap: () => context.go(AppRoutes.documents),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.apartment_outlined),
                    title: Text(l10n.adminTitle),
                    onTap: () => context.go(AppRoutes.admin),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.photo_library_outlined),
                    title: Text(l10n.photoReportsTitle),
                    onTap: () => context.go(AppRoutes.photoReports),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(Icons.color_lens_outlined),
                title: Text(l10n.settingsTheme),
                subtitle: Text(_themeModeLabel(context, themeController.themeMode)),
                onTap: () => context.go(AppRoutes.settings),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.notifications_active_outlined),
                    title: Text(l10n.profileNotificationStatus),
                    subtitle: Text(
                      _notificationsEnabled
                          ? l10n.profileNotificationEnabled
                          : l10n.profileNotificationDisabled,
                    ),
                    onTap: () => context.go(AppRoutes.settings),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.security_outlined),
                    title: Text(l10n.profileSecurityStatus),
                    subtitle: Text(
                      _securityEnabled
                          ? l10n.profileSecurityEnabled
                          : l10n.profileSecurityDisabled,
                    ),
                    onTap: () => context.go(AppRoutes.settings),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(l10n.profileAboutTitle),
                    subtitle: Text(l10n.appTitle),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.verified_outlined),
                    title: Text(l10n.profileVersionTitle),
                    subtitle: Text(l10n.profileVersionValue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _themeModeLabel(BuildContext context, ThemeMode mode) {
    final l10n = context.l10n;
    switch (mode) {
      case ThemeMode.light:
        return l10n.settingsThemeLight;
      case ThemeMode.dark:
        return l10n.settingsThemeDark;
      case ThemeMode.system:
        return l10n.settingsThemeSystem;
    }
  }
}

class _ProfileAchievementList extends StatelessWidget {
  const _ProfileAchievementList({required this.items});

  final List<_ProfileAchievementItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(item.icon),
                ),
                title: Text(item.title),
                subtitle: Text(item.subtitle),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _ProfileAchievementItem {
  const _ProfileAchievementItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}
