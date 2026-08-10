import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../../core/localization/locale_scope.dart';
import '../../../../core/theme/theme_mode_scope.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const _pushNotificationsKey = 'structra.push_notifications_enabled';
  static const _chatNotificationsKey = 'structra.chat_notifications_enabled';
  static const _taskNotificationsKey = 'structra.task_notifications_enabled';
  static const _financeNotificationsKey = 'structra.finance_notifications_enabled';
  static const _securityLockKey = 'structra.security_lock_enabled';
  static const _pinEnabledKey = 'structra.security_pin_enabled';
  static const _biometricEnabledKey = 'structra.security_biometric_enabled';
  static const _autoLockEnabledKey = 'structra.security_auto_lock_enabled';
  static const _privacyModeKey = 'structra.privacy_mode_enabled';
  static const _analyticsEnabledKey = 'structra.analytics_enabled';
  static const _highContrastKey = 'structra.high_contrast_enabled';
  static const _reduceMotionKey = 'structra.reduce_motion_enabled';
  static const _dataSaverKey = 'structra.data_saver_enabled';
  static const _dateFormatKey = 'structra.date_format';
  static const _timeFormatKey = 'structra.time_format';
  static const _backupSnapshotKey = 'structra.settings_backup_snapshot';
  static const _backupSnapshotAtKey = 'structra.settings_backup_snapshot_at';

  bool _pushNotificationsEnabled = true;
  bool _chatNotificationsEnabled = true;
  bool _taskNotificationsEnabled = true;
  bool _financeNotificationsEnabled = true;
  bool _securityLockEnabled = true;
  bool _pinEnabled = false;
  bool _biometricEnabled = false;
  bool _autoLockEnabled = true;
  bool _privacyModeEnabled = false;
  bool _analyticsEnabled = true;
  bool _highContrastEnabled = false;
  bool _reduceMotionEnabled = false;
  bool _dataSaverEnabled = false;
  String _dateFormat = 'dmy';
  String _timeFormat = '24h';
  DateTime? _backupSavedAt;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFlags();
  }

  Future<void> _loadFlags() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) {
      return;
    }

    setState(() {
      _pushNotificationsEnabled = prefs.getBool(_pushNotificationsKey) ?? true;
      _chatNotificationsEnabled = prefs.getBool(_chatNotificationsKey) ?? true;
      _taskNotificationsEnabled = prefs.getBool(_taskNotificationsKey) ?? true;
      _financeNotificationsEnabled = prefs.getBool(_financeNotificationsKey) ?? true;
      _securityLockEnabled = prefs.getBool(_securityLockKey) ?? true;
      _pinEnabled = prefs.getBool(_pinEnabledKey) ?? false;
      _biometricEnabled = prefs.getBool(_biometricEnabledKey) ?? false;
      _autoLockEnabled = prefs.getBool(_autoLockEnabledKey) ?? true;
      _privacyModeEnabled = prefs.getBool(_privacyModeKey) ?? false;
      _analyticsEnabled = prefs.getBool(_analyticsEnabledKey) ?? true;
      _highContrastEnabled = prefs.getBool(_highContrastKey) ?? false;
      _reduceMotionEnabled = prefs.getBool(_reduceMotionKey) ?? false;
      _dataSaverEnabled = prefs.getBool(_dataSaverKey) ?? false;
      _dateFormat = prefs.getString(_dateFormatKey) ?? 'dmy';
      _timeFormat = prefs.getString(_timeFormatKey) ?? '24h';
      final backupTimestamp = prefs.getString(_backupSnapshotAtKey);
      _backupSavedAt = backupTimestamp == null ? null : DateTime.tryParse(backupTimestamp);
      _isLoading = false;
    });
  }

  Future<void> _setBoolPreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _setStringPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  String _settingsSnapshot() {
    return <String>[
      'pushNotifications=$_pushNotificationsEnabled',
      'chatNotifications=$_chatNotificationsEnabled',
      'taskNotifications=$_taskNotificationsEnabled',
      'financeNotifications=$_financeNotificationsEnabled',
      'securityLock=$_securityLockEnabled',
      'pin=$_pinEnabled',
      'biometric=$_biometricEnabled',
      'autoLock=$_autoLockEnabled',
      'privacyMode=$_privacyModeEnabled',
      'analytics=$_analyticsEnabled',
      'highContrast=$_highContrastEnabled',
      'reduceMotion=$_reduceMotionEnabled',
      'dataSaver=$_dataSaverEnabled',
      'dateFormat=$_dateFormat',
      'timeFormat=$_timeFormat',
    ].join('\n');
  }

  Future<void> _showInfoSheet(BuildContext context, String title, String body) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(body),
              const SizedBox(height: 14),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: Text(context.l10n.commonBackToChat),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showChangePasswordDialog(BuildContext context) async {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final messenger = ScaffoldMessenger.of(context);
    final changed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(context.l10n.settingsChangePassword),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: context.l10n.commonPassword),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: context.l10n.commonPassword),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: context.l10n.commonPassword),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(context.l10n.commonBackToChat),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(context.l10n.settingsChangePassword),
            ),
          ],
        );
      },
    );

    if (changed == true && mounted) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Локальный пароль обновлен')),
      );
    }
  }

  Future<void> _resetLocalSettings(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_pushNotificationsKey, true);
    await prefs.setBool(_chatNotificationsKey, true);
    await prefs.setBool(_taskNotificationsKey, true);
    await prefs.setBool(_financeNotificationsKey, true);
    await prefs.setBool(_securityLockKey, true);
    await prefs.setBool(_pinEnabledKey, false);
    await prefs.setBool(_biometricEnabledKey, false);
    await prefs.setBool(_autoLockEnabledKey, true);
    await prefs.setBool(_privacyModeKey, false);
    await prefs.setBool(_analyticsEnabledKey, true);
    await prefs.setBool(_highContrastKey, false);
    await prefs.setBool(_reduceMotionKey, false);
    await prefs.setBool(_dataSaverKey, false);
    await prefs.setString(_dateFormatKey, 'dmy');
    await prefs.setString(_timeFormatKey, '24h');
    if (!mounted) {
      return;
    }
    await _loadFlags();
    messenger.showSnackBar(
      const SnackBar(content: Text('Локальные настройки сброшены')),
    );
  }

  Future<void> _copySettingsSnapshot(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: _settingsSnapshot()));
    if (!mounted) {
      return;
    }
    messenger.showSnackBar(
      const SnackBar(content: Text('Снимок настроек скопирован')),
    );
  }

  Future<void> _saveBackupSnapshot(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final now = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_backupSnapshotKey, _settingsSnapshot());
    await prefs.setString(_backupSnapshotAtKey, now.toIso8601String());
    if (!mounted) {
      return;
    }
    setState(() {
      _backupSavedAt = now;
    });
    messenger.showSnackBar(
      const SnackBar(content: Text('Резервная копия сохранена локально')),
    );
  }

  String _backupSubtitle(BuildContext context) {
    if (_backupSavedAt == null) {
      return context.l10n.settingsBackupPlaceholder;
    }

    final locale = Localizations.localeOf(context).toLanguageTag();
    return 'Последняя копия: ${DateFormat.yMd(locale).add_Hm().format(_backupSavedAt!)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeController = ThemeModeScope.of(context);
    final localeController = LocaleScope.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: <Widget>[
                Text(
                  l10n.settingsHeadline,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(l10n.settingsSubtitle),
                const SizedBox(height: 14),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.settingsGeneralSection,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: localeController.locale.languageCode,
                          decoration: InputDecoration(labelText: l10n.languageSelectLabel),
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
                            if (value != null) {
                              localeController.setLocale(Locale(value));
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          initialValue: _dateFormat,
                          decoration: InputDecoration(labelText: l10n.settingsDateFormat),
                          items: <DropdownMenuItem<String>>[
                            DropdownMenuItem<String>(
                              value: 'dmy',
                              child: Text(l10n.settingsDateFormatDmy),
                            ),
                            DropdownMenuItem<String>(
                              value: 'mdy',
                              child: Text(l10n.settingsDateFormatMdy),
                            ),
                            DropdownMenuItem<String>(
                              value: 'ymd',
                              child: Text(l10n.settingsDateFormatYmd),
                            ),
                          ],
                          onChanged: (String? value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _dateFormat = value;
                            });
                            _setStringPreference(_dateFormatKey, value);
                          },
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          initialValue: _timeFormat,
                          decoration: InputDecoration(labelText: l10n.settingsTimeFormat),
                          items: <DropdownMenuItem<String>>[
                            DropdownMenuItem<String>(
                              value: '24h',
                              child: Text(l10n.settingsTimeFormat24),
                            ),
                            DropdownMenuItem<String>(
                              value: '12h',
                              child: Text(l10n.settingsTimeFormat12),
                            ),
                          ],
                          onChanged: (String? value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _timeFormat = value;
                            });
                            _setStringPreference(_timeFormatKey, value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.settingsAppearanceSection,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        SegmentedButton<ThemeMode>(
                          segments: <ButtonSegment<ThemeMode>>[
                            ButtonSegment<ThemeMode>(
                              value: ThemeMode.light,
                              label: Text(l10n.settingsThemeLight),
                              icon: const Icon(Icons.light_mode_outlined),
                            ),
                            ButtonSegment<ThemeMode>(
                              value: ThemeMode.dark,
                              label: Text(l10n.settingsThemeDark),
                              icon: const Icon(Icons.dark_mode_outlined),
                            ),
                            ButtonSegment<ThemeMode>(
                              value: ThemeMode.system,
                              label: Text(l10n.settingsThemeSystem),
                              icon: const Icon(Icons.phone_android_outlined),
                            ),
                          ],
                          selected: <ThemeMode>{themeController.themeMode},
                          onSelectionChanged: (Set<ThemeMode> selection) {
                            themeController.setThemeMode(selection.first);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Column(
                    children: <Widget>[
                      SwitchListTile.adaptive(
                        value: _pushNotificationsEnabled,
                        title: Text(l10n.settingsPushNotifications),
                        onChanged: (bool value) {
                          setState(() {
                            _pushNotificationsEnabled = value;
                          });
                          _setBoolPreference(_pushNotificationsKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile.adaptive(
                        value: _chatNotificationsEnabled,
                        title: Text(l10n.settingsChatNotifications),
                        onChanged: (bool value) {
                          setState(() {
                            _chatNotificationsEnabled = value;
                          });
                          _setBoolPreference(_chatNotificationsKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile.adaptive(
                        value: _taskNotificationsEnabled,
                        title: Text(l10n.settingsTaskNotifications),
                        onChanged: (bool value) {
                          setState(() {
                            _taskNotificationsEnabled = value;
                          });
                          _setBoolPreference(_taskNotificationsKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile.adaptive(
                        value: _financeNotificationsEnabled,
                        title: Text(l10n.settingsFinanceNotifications),
                        onChanged: (bool value) {
                          setState(() {
                            _financeNotificationsEnabled = value;
                          });
                          _setBoolPreference(_financeNotificationsKey, value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Column(
                    children: <Widget>[
                      SwitchListTile.adaptive(
                        value: _securityLockEnabled,
                        title: Text(l10n.settingsSecurity),
                        subtitle: Text(l10n.settingsSecuritySubtitle),
                        onChanged: (bool value) {
                          setState(() {
                            _securityLockEnabled = value;
                          });
                          _setBoolPreference(_securityLockKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile.adaptive(
                        value: _pinEnabled,
                        title: Text(l10n.settingsPinCode),
                        onChanged: (bool value) {
                          setState(() {
                            _pinEnabled = value;
                          });
                          _setBoolPreference(_pinEnabledKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile.adaptive(
                        value: _biometricEnabled,
                        title: Text(l10n.settingsBiometric),
                        onChanged: (bool value) {
                          setState(() {
                            _biometricEnabled = value;
                          });
                          _setBoolPreference(_biometricEnabledKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile.adaptive(
                        value: _autoLockEnabled,
                        title: Text(l10n.settingsAutoLock),
                        onChanged: (bool value) {
                          setState(() {
                            _autoLockEnabled = value;
                          });
                          _setBoolPreference(_autoLockEnabledKey, value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Column(
                    children: <Widget>[
                      SwitchListTile.adaptive(
                        value: _privacyModeEnabled,
                        title: Text(l10n.settingsPrivacyMode),
                        subtitle: Text(l10n.settingsPrivacyModeSubtitle),
                        onChanged: (bool value) {
                          setState(() {
                            _privacyModeEnabled = value;
                          });
                          _setBoolPreference(_privacyModeKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile.adaptive(
                        value: _analyticsEnabled,
                        title: Text(l10n.settingsAnalytics),
                        subtitle: Text(l10n.settingsAnalyticsSubtitle),
                        onChanged: (bool value) {
                          setState(() {
                            _analyticsEnabled = value;
                          });
                          _setBoolPreference(_analyticsEnabledKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.password_outlined),
                        title: Text(l10n.settingsChangePassword),
                        onTap: () => _showChangePasswordDialog(context),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.cached_outlined),
                        title: Text(l10n.settingsCache),
                        onTap: () => _resetLocalSettings(context),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.sd_storage_outlined),
                        title: Text(l10n.settingsStorage),
                        onTap: () => _showInfoSheet(
                          context,
                          l10n.settingsStorage,
                          _settingsSnapshot(),
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.file_download_outlined),
                        title: Text(l10n.settingsExportData),
                        onTap: () => _copySettingsSnapshot(context),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.backup_outlined),
                        title: Text(l10n.settingsBackup),
                        subtitle: Text(_backupSubtitle(context)),
                        onTap: () => _saveBackupSnapshot(context),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: Text(l10n.settingsAboutApp),
                        onTap: () => _showInfoSheet(
                          context,
                          l10n.settingsAboutApp,
                          'Aydin Control Manager\n\n${_settingsSnapshot()}',
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip_outlined),
                        title: Text(l10n.settingsPrivacyPolicy),
                        onTap: () => _showInfoSheet(
                          context,
                          l10n.settingsPrivacyPolicy,
                          'Данные хранятся локально в приложении. Сетевой обмен не требуется для базовых функций.',
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.description_outlined),
                        title: Text(l10n.settingsTerms),
                        onTap: () => _showInfoSheet(
                          context,
                          l10n.settingsTerms,
                          'Использование приложения ограничено локальным рабочим потоком и данными этого устройства.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Column(
                    children: <Widget>[
                      SwitchListTile.adaptive(
                        value: _highContrastEnabled,
                        title: Text(l10n.settingsAccessibilityHighContrast),
                        onChanged: (bool value) {
                          setState(() {
                            _highContrastEnabled = value;
                          });
                          _setBoolPreference(_highContrastKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile.adaptive(
                        value: _reduceMotionEnabled,
                        title: Text(l10n.settingsAccessibilityReduceMotion),
                        onChanged: (bool value) {
                          setState(() {
                            _reduceMotionEnabled = value;
                          });
                          _setBoolPreference(_reduceMotionKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile.adaptive(
                        value: _dataSaverEnabled,
                        title: Text(l10n.settingsDataSaver),
                        onChanged: (bool value) {
                          setState(() {
                            _dataSaverEnabled = value;
                          });
                          _setBoolPreference(_dataSaverKey, value);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.help_center_outlined),
                        title: Text(l10n.settingsHelpCenter),
                        onTap: () => _showInfoSheet(
                          context,
                          l10n.settingsHelpCenter,
                          'Откройте нужный раздел приложения или обратитесь к локальным данным проекта для проверки состояния.',
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.support_agent_outlined),
                        title: Text(l10n.settingsContactSupport),
                        onTap: () => _showInfoSheet(
                          context,
                          l10n.settingsContactSupport,
                          'Поддержка пока работает как локальная справка. Опишите проблему в чатах или задачах проекта.',
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.feedback_outlined),
                        title: Text(l10n.settingsSendFeedback),
                        onTap: () => _showInfoSheet(
                          context,
                          l10n.settingsSendFeedback,
                          'Отправьте отзыв через рабочий чат или сохраните замечание в задаче для команды.',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
