import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ru, this message translates to:
  /// **'Aydin Control Manager'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get navHome;

  /// No description provided for @navChats.
  ///
  /// In ru, this message translates to:
  /// **'Чаты'**
  String get navChats;

  /// No description provided for @navTasks.
  ///
  /// In ru, this message translates to:
  /// **'Задачи'**
  String get navTasks;

  /// No description provided for @navFinance.
  ///
  /// In ru, this message translates to:
  /// **'Финансы'**
  String get navFinance;

  /// No description provided for @navProfile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get navProfile;

  /// No description provided for @homeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Панель управления'**
  String get homeTitle;

  /// No description provided for @homeGreeting.
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать в ACM'**
  String get homeGreeting;

  /// No description provided for @homeOverviewSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Ключевые показатели строительства и прогресс в реальном времени.'**
  String get homeOverviewSubtitle;

  /// No description provided for @quickStatisticsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Быстрая статистика'**
  String get quickStatisticsTitle;

  /// No description provided for @quickActionsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Быстрые действия'**
  String get quickActionsTitle;

  /// No description provided for @recentActivityTitle.
  ///
  /// In ru, this message translates to:
  /// **'Последняя активность'**
  String get recentActivityTitle;

  /// No description provided for @recentActivitySubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Обновления с площадки и события команды.'**
  String get recentActivitySubtitle;

  /// No description provided for @actionOpenChats.
  ///
  /// In ru, this message translates to:
  /// **'Открыть чаты'**
  String get actionOpenChats;

  /// No description provided for @actionViewTasks.
  ///
  /// In ru, this message translates to:
  /// **'Открыть задачи'**
  String get actionViewTasks;

  /// No description provided for @actionFinance.
  ///
  /// In ru, this message translates to:
  /// **'Финансы'**
  String get actionFinance;

  /// No description provided for @actionEmployees.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники'**
  String get actionEmployees;

  /// No description provided for @actionProjects.
  ///
  /// In ru, this message translates to:
  /// **'Проекты'**
  String get actionProjects;

  /// No description provided for @actionReports.
  ///
  /// In ru, this message translates to:
  /// **'Отчеты'**
  String get actionReports;

  /// No description provided for @actionAdminPanel.
  ///
  /// In ru, this message translates to:
  /// **'Панель администратора'**
  String get actionAdminPanel;

  /// No description provided for @reportsPlaceholderInfo.
  ///
  /// In ru, this message translates to:
  /// **'Модуль отчетов будет включен на следующем этапе.'**
  String get reportsPlaceholderInfo;

  /// No description provided for @statActiveTasks.
  ///
  /// In ru, this message translates to:
  /// **'Активные задачи'**
  String get statActiveTasks;

  /// No description provided for @statEmployeesOnline.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники онлайн'**
  String get statEmployeesOnline;

  /// No description provided for @statUnreadMessages.
  ///
  /// In ru, this message translates to:
  /// **'Непрочитанные сообщения'**
  String get statUnreadMessages;

  /// No description provided for @statBudgetRemaining.
  ///
  /// In ru, this message translates to:
  /// **'Остаток бюджета'**
  String get statBudgetRemaining;

  /// No description provided for @currentProjectTitle.
  ///
  /// In ru, this message translates to:
  /// **'Текущий проект'**
  String get currentProjectTitle;

  /// No description provided for @currentProjectProgress.
  ///
  /// In ru, this message translates to:
  /// **'Прогресс: {value}'**
  String currentProjectProgress(String value);

  /// No description provided for @activityConcreteTitle.
  ///
  /// In ru, this message translates to:
  /// **'Заливка бетона завершена'**
  String get activityConcreteTitle;

  /// No description provided for @activityConcreteDetail.
  ///
  /// In ru, this message translates to:
  /// **'Башня А, уровень 18 завершен раньше графика.'**
  String get activityConcreteDetail;

  /// No description provided for @activitySafetyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Проверка безопасности отправлена'**
  String get activitySafetyTitle;

  /// No description provided for @activitySafetyDetail.
  ///
  /// In ru, this message translates to:
  /// **'Ежедневный EHS-чеклист подтвержден прорабом.'**
  String get activitySafetyDetail;

  /// No description provided for @activityProcurementTitle.
  ///
  /// In ru, this message translates to:
  /// **'Обновление снабжения'**
  String get activityProcurementTitle;

  /// No description provided for @activityProcurementDetail.
  ///
  /// In ru, this message translates to:
  /// **'Партия стальных балок №47 в пути на объект.'**
  String get activityProcurementDetail;

  /// No description provided for @activityClientTitle.
  ///
  /// In ru, this message translates to:
  /// **'Получен комментарий заказчика'**
  String get activityClientTitle;

  /// No description provided for @activityClientDetail.
  ///
  /// In ru, this message translates to:
  /// **'К обсуждению проекта добавлены новые правки планировки.'**
  String get activityClientDetail;

  /// No description provided for @chatsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Чаты'**
  String get chatsTitle;

  /// No description provided for @chatsPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Здесь будут рабочие переписки команды, проектные каналы и вложения по контексту.'**
  String get chatsPlaceholder;

  /// No description provided for @chatsPrivateTab.
  ///
  /// In ru, this message translates to:
  /// **'Личные'**
  String get chatsPrivateTab;

  /// No description provided for @chatsGroupTab.
  ///
  /// In ru, this message translates to:
  /// **'Группы'**
  String get chatsGroupTab;

  /// No description provided for @chatsTypingPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Печатает...'**
  String get chatsTypingPlaceholder;

  /// No description provided for @chatsVoicePlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Голосовое сообщение'**
  String get chatsVoicePlaceholder;

  /// No description provided for @chatsVoiceStart.
  ///
  /// In ru, this message translates to:
  /// **'Начать запись'**
  String get chatsVoiceStart;

  /// No description provided for @chatsVoiceStopAndSend.
  ///
  /// In ru, this message translates to:
  /// **'Остановить и отправить'**
  String get chatsVoiceStopAndSend;

  /// No description provided for @chatsVoicePlaceholderButton.
  ///
  /// In ru, this message translates to:
  /// **'Голос'**
  String get chatsVoicePlaceholderButton;

  /// No description provided for @chatsAttachmentPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка вложений будет доступна в следующей итерации.'**
  String get chatsAttachmentPlaceholder;

  /// No description provided for @chatsAttachmentPlaceholderButton.
  ///
  /// In ru, this message translates to:
  /// **'Вложить'**
  String get chatsAttachmentPlaceholderButton;

  /// No description provided for @financeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Финансы'**
  String get financeTitle;

  /// No description provided for @financePlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'В этот модуль будут добавлены бюджетный контроль, согласования и аналитика затрат.'**
  String get financePlaceholder;

  /// No description provided for @financeHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Центр финансового контроля'**
  String get financeHeadline;

  /// No description provided for @financeSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Автоматически отслеживайте личные и проектные расходы, доходы и остаток бюджета.'**
  String get financeSubtitle;

  /// No description provided for @financePersonalExpenses.
  ///
  /// In ru, this message translates to:
  /// **'Личные расходы'**
  String get financePersonalExpenses;

  /// No description provided for @financeProjectExpenses.
  ///
  /// In ru, this message translates to:
  /// **'Проектные расходы'**
  String get financeProjectExpenses;

  /// No description provided for @financeIncome.
  ///
  /// In ru, this message translates to:
  /// **'Доход'**
  String get financeIncome;

  /// No description provided for @financeRemainingBudget.
  ///
  /// In ru, this message translates to:
  /// **'Остаток бюджета'**
  String get financeRemainingBudget;

  /// No description provided for @financeChartsPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Графики'**
  String get financeChartsPlaceholder;

  /// No description provided for @financeChartsPlaceholderDescription.
  ///
  /// In ru, this message translates to:
  /// **'Здесь будут графики cashflow, burn-rate и отклонений.'**
  String get financeChartsPlaceholderDescription;

  /// No description provided for @financeExpenseHistory.
  ///
  /// In ru, this message translates to:
  /// **'История расходов'**
  String get financeExpenseHistory;

  /// No description provided for @companyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Управление компанией'**
  String get companyTitle;

  /// No description provided for @companyContacts.
  ///
  /// In ru, this message translates to:
  /// **'Контакты компании'**
  String get companyContacts;

  /// No description provided for @companyNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Компания не найдена'**
  String get companyNotFound;

  /// No description provided for @documentsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Документы'**
  String get documentsTitle;

  /// No description provided for @documentsHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Управление документами'**
  String get documentsHeadline;

  /// No description provided for @documentsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Организуйте папки, категории и последние файлы проекта.'**
  String get documentsSubtitle;

  /// No description provided for @documentsFolders.
  ///
  /// In ru, this message translates to:
  /// **'Папки'**
  String get documentsFolders;

  /// No description provided for @documentsRecent.
  ///
  /// In ru, this message translates to:
  /// **'Последние документы'**
  String get documentsRecent;

  /// No description provided for @documentsPdfPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Предпросмотр PDF'**
  String get documentsPdfPlaceholder;

  /// No description provided for @documentsDwgPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Предпросмотр DWG'**
  String get documentsDwgPlaceholder;

  /// No description provided for @documentsExcelPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Предпросмотр Excel'**
  String get documentsExcelPlaceholder;

  /// No description provided for @documentsOpenPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Открытие документов будет доступно после подключения backend.'**
  String get documentsOpenPlaceholder;

  /// No description provided for @photoReportsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Фотоотчеты'**
  String get photoReportsTitle;

  /// No description provided for @photoReportsHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Фотоотчеты с объекта'**
  String get photoReportsHeadline;

  /// No description provided for @photoReportsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Отслеживайте альбомы с фото до/после по сотрудникам и проектам.'**
  String get photoReportsSubtitle;

  /// No description provided for @photoReportsDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата'**
  String get photoReportsDate;

  /// No description provided for @notificationsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get notificationsTitle;

  /// No description provided for @notificationsCenter.
  ///
  /// In ru, this message translates to:
  /// **'Центр уведомлений'**
  String get notificationsCenter;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Напоминания по задачам, обновления проектов и финансовые алерты в одном месте.'**
  String get notificationsSubtitle;

  /// No description provided for @notificationsTaskReminders.
  ///
  /// In ru, this message translates to:
  /// **'Напоминание по задаче'**
  String get notificationsTaskReminders;

  /// No description provided for @notificationsProjectUpdates.
  ///
  /// In ru, this message translates to:
  /// **'Обновление проекта'**
  String get notificationsProjectUpdates;

  /// No description provided for @notificationsFinanceAlerts.
  ///
  /// In ru, this message translates to:
  /// **'Финансовый алерт'**
  String get notificationsFinanceAlerts;

  /// No description provided for @notificationsEmployeeAlerts.
  ///
  /// In ru, this message translates to:
  /// **'Алерт по сотрудникам'**
  String get notificationsEmployeeAlerts;

  /// No description provided for @notificationsSystemAlerts.
  ///
  /// In ru, this message translates to:
  /// **'Системное уведомление'**
  String get notificationsSystemAlerts;

  /// No description provided for @profileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profileTitle;

  /// No description provided for @profileHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Настройки профиля'**
  String get profileHeadline;

  /// No description provided for @profileDescription.
  ///
  /// In ru, this message translates to:
  /// **'Управляйте личными параметрами и языком интерфейса.'**
  String get profileDescription;

  /// No description provided for @profileManagerName.
  ///
  /// In ru, this message translates to:
  /// **'Aruzhan Tolegen'**
  String get profileManagerName;

  /// No description provided for @languageSectionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Язык приложения'**
  String get languageSectionTitle;

  /// No description provided for @languageSectionSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Выберите язык. Изменения применяются сразу.'**
  String get languageSectionSubtitle;

  /// No description provided for @languageSelectLabel.
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get languageSelectLabel;

  /// No description provided for @languageRussian.
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get languageRussian;

  /// No description provided for @languageKazakh.
  ///
  /// In ru, this message translates to:
  /// **'Казахский'**
  String get languageKazakh;

  /// No description provided for @languageEnglish.
  ///
  /// In ru, this message translates to:
  /// **'Английский'**
  String get languageEnglish;

  /// No description provided for @splashTagline.
  ///
  /// In ru, this message translates to:
  /// **'Корпоративное управление строительством'**
  String get splashTagline;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In ru, this message translates to:
  /// **'С возвращением'**
  String get loginWelcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Войдите, чтобы продолжить работу в ACM.'**
  String get loginSubtitle;

  /// No description provided for @loginSideTitle.
  ///
  /// In ru, this message translates to:
  /// **'Единый центр управления стройкой'**
  String get loginSideTitle;

  /// No description provided for @loginSideSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Планируйте проекты, координируйте команды и контролируйте бюджет в одном месте.'**
  String get loginSideSubtitle;

  /// No description provided for @commonEmail.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get commonEmail;

  /// No description provided for @commonPhone.
  ///
  /// In ru, this message translates to:
  /// **'Телефон'**
  String get commonPhone;

  /// No description provided for @commonPassword.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get commonPassword;

  /// No description provided for @loginRememberMe.
  ///
  /// In ru, this message translates to:
  /// **'Запомнить меня'**
  String get loginRememberMe;

  /// No description provided for @loginForgotPassword.
  ///
  /// In ru, this message translates to:
  /// **'Забыли пароль?'**
  String get loginForgotPassword;

  /// No description provided for @loginForgotPasswordInfo.
  ///
  /// In ru, this message translates to:
  /// **'Восстановление пароля будет доступно в следующем релизе.'**
  String get loginForgotPasswordInfo;

  /// No description provided for @loginRoleLabel.
  ///
  /// In ru, this message translates to:
  /// **'Роль'**
  String get loginRoleLabel;

  /// No description provided for @loginButton.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginButton;

  /// No description provided for @settingsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settingsTitle;

  /// No description provided for @settingsHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Настройки приложения'**
  String get settingsHeadline;

  /// No description provided for @settingsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Управляйте внешним видом, языком, уведомлениями и безопасностью.'**
  String get settingsSubtitle;

  /// No description provided for @settingsTheme.
  ///
  /// In ru, this message translates to:
  /// **'Тема'**
  String get settingsTheme;

  /// No description provided for @settingsThemeLight.
  ///
  /// In ru, this message translates to:
  /// **'Светлая'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In ru, this message translates to:
  /// **'Темная'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In ru, this message translates to:
  /// **'Системная'**
  String get settingsThemeSystem;

  /// No description provided for @settingsNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Разрешить напоминания по задачам, обновлениям проектов и финансовым алертам.'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @settingsSecurity.
  ///
  /// In ru, this message translates to:
  /// **'Безопасность'**
  String get settingsSecurity;

  /// No description provided for @settingsSecuritySubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Требовать локальную проверку безопасности для чувствительных действий.'**
  String get settingsSecuritySubtitle;

  /// No description provided for @employeesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники'**
  String get employeesTitle;

  /// No description provided for @employeesHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Управление сотрудниками'**
  String get employeesHeadline;

  /// No description provided for @employeesSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Контролируйте доступность команды, роли и назначения по проектам.'**
  String get employeesSubtitle;

  /// No description provided for @employeesNoResults.
  ///
  /// In ru, this message translates to:
  /// **'По выбранным условиям сотрудники не найдены'**
  String get employeesNoResults;

  /// No description provided for @employeesSearchHint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск сотрудников по имени, телефону или проекту'**
  String get employeesSearchHint;

  /// No description provided for @employeeDetailsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Данные сотрудника'**
  String get employeeDetailsTitle;

  /// No description provided for @employeeNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудник не найден'**
  String get employeeNotFound;

  /// No description provided for @employeeContactReady.
  ///
  /// In ru, this message translates to:
  /// **'Действие связи для {name} готово.'**
  String employeeContactReady(String name);

  /// No description provided for @employeeTaskSummaryTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сводка по задачам'**
  String get employeeTaskSummaryTitle;

  /// No description provided for @employeeAssignedTasks.
  ///
  /// In ru, this message translates to:
  /// **'Назначенные задачи'**
  String get employeeAssignedTasks;

  /// No description provided for @employeeCompletedTasks.
  ///
  /// In ru, this message translates to:
  /// **'Выполненные задачи'**
  String get employeeCompletedTasks;

  /// No description provided for @employeePersonalNotes.
  ///
  /// In ru, this message translates to:
  /// **'Личные заметки'**
  String get employeePersonalNotes;

  /// No description provided for @statusOnline.
  ///
  /// In ru, this message translates to:
  /// **'Онлайн'**
  String get statusOnline;

  /// No description provided for @statusOffline.
  ///
  /// In ru, this message translates to:
  /// **'Оффлайн'**
  String get statusOffline;

  /// No description provided for @filterRoleLabel.
  ///
  /// In ru, this message translates to:
  /// **'Роль'**
  String get filterRoleLabel;

  /// No description provided for @filterAllRoles.
  ///
  /// In ru, this message translates to:
  /// **'Все роли'**
  String get filterAllRoles;

  /// No description provided for @filterSortByLabel.
  ///
  /// In ru, this message translates to:
  /// **'Сортировка'**
  String get filterSortByLabel;

  /// No description provided for @sortOnlineFirst.
  ///
  /// In ru, this message translates to:
  /// **'Сначала онлайн'**
  String get sortOnlineFirst;

  /// No description provided for @sortAlphabetically.
  ///
  /// In ru, this message translates to:
  /// **'По алфавиту'**
  String get sortAlphabetically;

  /// No description provided for @sortByPosition.
  ///
  /// In ru, this message translates to:
  /// **'По должности'**
  String get sortByPosition;

  /// No description provided for @roleDirector.
  ///
  /// In ru, this message translates to:
  /// **'Директор'**
  String get roleDirector;

  /// No description provided for @roleProjectManager.
  ///
  /// In ru, this message translates to:
  /// **'Менеджер проекта'**
  String get roleProjectManager;

  /// No description provided for @roleSiteEngineer.
  ///
  /// In ru, this message translates to:
  /// **'Инженер участка'**
  String get roleSiteEngineer;

  /// No description provided for @roleForeman.
  ///
  /// In ru, this message translates to:
  /// **'Прораб'**
  String get roleForeman;

  /// No description provided for @roleSurveyor.
  ///
  /// In ru, this message translates to:
  /// **'Геодезист'**
  String get roleSurveyor;

  /// No description provided for @roleSafetyEngineer.
  ///
  /// In ru, this message translates to:
  /// **'Инженер по безопасности'**
  String get roleSafetyEngineer;

  /// No description provided for @roleAccountant.
  ///
  /// In ru, this message translates to:
  /// **'Бухгалтер'**
  String get roleAccountant;

  /// No description provided for @roleStorekeeper.
  ///
  /// In ru, this message translates to:
  /// **'Кладовщик'**
  String get roleStorekeeper;

  /// No description provided for @roleWorker.
  ///
  /// In ru, this message translates to:
  /// **'Рабочий'**
  String get roleWorker;

  /// No description provided for @projectsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Проекты'**
  String get projectsTitle;

  /// No description provided for @projectsHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Строительные проекты'**
  String get projectsHeadline;

  /// No description provided for @projectsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Отслеживайте состояние проекта, бюджет, сроки и прогресс на площадке.'**
  String get projectsSubtitle;

  /// No description provided for @projectDetailsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Детали проекта'**
  String get projectDetailsTitle;

  /// No description provided for @projectNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Проект не найден'**
  String get projectNotFound;

  /// No description provided for @newProjectTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новый проект'**
  String get newProjectTitle;

  /// No description provided for @newProjectHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Создание проекта'**
  String get newProjectHeadline;

  /// No description provided for @newProjectSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Задайте объем, сроки и бюджет для запуска рабочего пространства проекта.'**
  String get newProjectSubtitle;

  /// No description provided for @projectFieldName.
  ///
  /// In ru, this message translates to:
  /// **'Название проекта'**
  String get projectFieldName;

  /// No description provided for @projectFieldClient.
  ///
  /// In ru, this message translates to:
  /// **'Заказчик'**
  String get projectFieldClient;

  /// No description provided for @projectFieldAddress.
  ///
  /// In ru, this message translates to:
  /// **'Адрес'**
  String get projectFieldAddress;

  /// No description provided for @projectCreateButton.
  ///
  /// In ru, this message translates to:
  /// **'Создать проект'**
  String get projectCreateButton;

  /// No description provided for @projectSelectDatesError.
  ///
  /// In ru, this message translates to:
  /// **'Выберите даты начала и завершения.'**
  String get projectSelectDatesError;

  /// No description provided for @projectEndDateError.
  ///
  /// In ru, this message translates to:
  /// **'Дата завершения должна быть позже даты начала.'**
  String get projectEndDateError;

  /// No description provided for @projectBudgetValidationError.
  ///
  /// In ru, this message translates to:
  /// **'Введите корректную сумму бюджета.'**
  String get projectBudgetValidationError;

  /// No description provided for @projectCreatedLocalInfo.
  ///
  /// In ru, this message translates to:
  /// **'Черновик проекта создан локально (mock-поток).'**
  String get projectCreatedLocalInfo;

  /// No description provided for @projectInformationTitle.
  ///
  /// In ru, this message translates to:
  /// **'Информация о проекте'**
  String get projectInformationTitle;

  /// No description provided for @projectProgressStageTitle.
  ///
  /// In ru, this message translates to:
  /// **'Прогресс и текущий этап'**
  String get projectProgressStageTitle;

  /// No description provided for @projectCompletedValue.
  ///
  /// In ru, this message translates to:
  /// **'Выполнено: {value}'**
  String projectCompletedValue(String value);

  /// No description provided for @projectCurrentStage.
  ///
  /// In ru, this message translates to:
  /// **'Текущий этап'**
  String get projectCurrentStage;

  /// No description provided for @projectWeatherActivityTitle.
  ///
  /// In ru, this message translates to:
  /// **'Погода и последняя активность'**
  String get projectWeatherActivityTitle;

  /// No description provided for @projectStatusPlanning.
  ///
  /// In ru, this message translates to:
  /// **'Планирование'**
  String get projectStatusPlanning;

  /// No description provided for @projectStatusOnTrack.
  ///
  /// In ru, this message translates to:
  /// **'По плану'**
  String get projectStatusOnTrack;

  /// No description provided for @projectStatusAtRisk.
  ///
  /// In ru, this message translates to:
  /// **'Под риском'**
  String get projectStatusAtRisk;

  /// No description provided for @projectStatusDelayed.
  ///
  /// In ru, this message translates to:
  /// **'С задержкой'**
  String get projectStatusDelayed;

  /// No description provided for @projectStatusCompleted.
  ///
  /// In ru, this message translates to:
  /// **'Завершен'**
  String get projectStatusCompleted;

  /// No description provided for @tabOverview.
  ///
  /// In ru, this message translates to:
  /// **'Обзор'**
  String get tabOverview;

  /// No description provided for @tabTasks.
  ///
  /// In ru, this message translates to:
  /// **'Задачи'**
  String get tabTasks;

  /// No description provided for @tabEmployees.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники'**
  String get tabEmployees;

  /// No description provided for @tabDocuments.
  ///
  /// In ru, this message translates to:
  /// **'Документы'**
  String get tabDocuments;

  /// No description provided for @tabPhotos.
  ///
  /// In ru, this message translates to:
  /// **'Фото'**
  String get tabPhotos;

  /// No description provided for @tabFinance.
  ///
  /// In ru, this message translates to:
  /// **'Финансы'**
  String get tabFinance;

  /// No description provided for @projectTabTasksPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'План задач, зависимости и ключевые этапы проекта.'**
  String get projectTabTasksPlaceholder;

  /// No description provided for @projectTabEmployeesPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Назначенная команда и распределение ресурсов по объекту.'**
  String get projectTabEmployeesPlaceholder;

  /// No description provided for @projectTabDocumentsPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Договоры, разрешения и проектные файлы по объекту.'**
  String get projectTabDocumentsPlaceholder;

  /// No description provided for @projectTabPhotosPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Лента фото прогресса с площадки.'**
  String get projectTabPhotosPlaceholder;

  /// No description provided for @projectTabFinancePlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Контроль затрат, счета и графики оплат по проекту.'**
  String get projectTabFinancePlaceholder;

  /// No description provided for @tasksTitle.
  ///
  /// In ru, this message translates to:
  /// **'Задачи'**
  String get tasksTitle;

  /// No description provided for @tasksHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Управление задачами'**
  String get tasksHeadline;

  /// No description provided for @tasksSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Планируйте, назначайте и контролируйте выполнение строительных задач.'**
  String get tasksSubtitle;

  /// No description provided for @tasksNoResults.
  ///
  /// In ru, this message translates to:
  /// **'По выбранным фильтрам задачи не найдены'**
  String get tasksNoResults;

  /// No description provided for @newTaskTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новая задача'**
  String get newTaskTitle;

  /// No description provided for @newTaskHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Создание задачи'**
  String get newTaskHeadline;

  /// No description provided for @newTaskSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Задайте объем, ответственного, стоимость и сроки.'**
  String get newTaskSubtitle;

  /// No description provided for @taskAssignEmployee.
  ///
  /// In ru, this message translates to:
  /// **'Назначить сотрудника'**
  String get taskAssignEmployee;

  /// No description provided for @taskEstimatedCost.
  ///
  /// In ru, this message translates to:
  /// **'Оценочная стоимость'**
  String get taskEstimatedCost;

  /// No description provided for @taskCreateButton.
  ///
  /// In ru, this message translates to:
  /// **'Создать задачу'**
  String get taskCreateButton;

  /// No description provided for @taskSelectDatesError.
  ///
  /// In ru, this message translates to:
  /// **'Выберите дату начала и дедлайн.'**
  String get taskSelectDatesError;

  /// No description provided for @taskDeadlineAfterStartError.
  ///
  /// In ru, this message translates to:
  /// **'Дедлайн должен быть позже даты начала.'**
  String get taskDeadlineAfterStartError;

  /// No description provided for @taskCostValidationError.
  ///
  /// In ru, this message translates to:
  /// **'Введите корректную стоимость.'**
  String get taskCostValidationError;

  /// No description provided for @taskCreatedLocalInfo.
  ///
  /// In ru, this message translates to:
  /// **'Задача создана локально (mock-поток).'**
  String get taskCreatedLocalInfo;

  /// No description provided for @taskAttachPhotos.
  ///
  /// In ru, this message translates to:
  /// **'Прикрепить фото'**
  String get taskAttachPhotos;

  /// No description provided for @taskAttachPhotosPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Откройте фотоотчеты для добавления снимков по задаче.'**
  String get taskAttachPhotosPlaceholder;

  /// No description provided for @taskAttachDocuments.
  ///
  /// In ru, this message translates to:
  /// **'Прикрепить документы'**
  String get taskAttachDocuments;

  /// No description provided for @taskAttachDocumentsPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Перейдите в документы, чтобы добавить чертежи и файлы.'**
  String get taskAttachDocumentsPlaceholder;

  /// No description provided for @taskAttachButton.
  ///
  /// In ru, this message translates to:
  /// **'Прикрепить'**
  String get taskAttachButton;

  /// No description provided for @taskAttachmentInfoAction.
  ///
  /// In ru, this message translates to:
  /// **'Раздел {title} открыт локально.'**
  String taskAttachmentInfoAction(String title);

  /// No description provided for @taskDetailsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Детали задачи'**
  String get taskDetailsTitle;

  /// No description provided for @taskNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Задача не найдена'**
  String get taskNotFound;

  /// No description provided for @taskDeadlineValue.
  ///
  /// In ru, this message translates to:
  /// **'Дедлайн: {date}'**
  String taskDeadlineValue(String date);

  /// No description provided for @taskFullDescription.
  ///
  /// In ru, this message translates to:
  /// **'Полное описание'**
  String get taskFullDescription;

  /// No description provided for @taskAssignedEmployees.
  ///
  /// In ru, this message translates to:
  /// **'Назначенные сотрудники'**
  String get taskAssignedEmployees;

  /// No description provided for @taskComments.
  ///
  /// In ru, this message translates to:
  /// **'Комментарии'**
  String get taskComments;

  /// No description provided for @taskActivityHistory.
  ///
  /// In ru, this message translates to:
  /// **'История активности'**
  String get taskActivityHistory;

  /// No description provided for @taskBeforePhotos.
  ///
  /// In ru, this message translates to:
  /// **'Фото до'**
  String get taskBeforePhotos;

  /// No description provided for @taskAfterPhotos.
  ///
  /// In ru, this message translates to:
  /// **'Фото после'**
  String get taskAfterPhotos;

  /// No description provided for @taskChangeStatus.
  ///
  /// In ru, this message translates to:
  /// **'Изменить статус'**
  String get taskChangeStatus;

  /// No description provided for @taskStatusChangedLocal.
  ///
  /// In ru, this message translates to:
  /// **'Статус изменен на {status} (локальный mock).'**
  String taskStatusChangedLocal(String status);

  /// No description provided for @taskPriorityLow.
  ///
  /// In ru, this message translates to:
  /// **'Низкий'**
  String get taskPriorityLow;

  /// No description provided for @taskPriorityMedium.
  ///
  /// In ru, this message translates to:
  /// **'Средний'**
  String get taskPriorityMedium;

  /// No description provided for @taskPriorityHigh.
  ///
  /// In ru, this message translates to:
  /// **'Высокий'**
  String get taskPriorityHigh;

  /// No description provided for @taskPriorityCritical.
  ///
  /// In ru, this message translates to:
  /// **'Критический'**
  String get taskPriorityCritical;

  /// No description provided for @taskStatusNotStarted.
  ///
  /// In ru, this message translates to:
  /// **'Не начата'**
  String get taskStatusNotStarted;

  /// No description provided for @taskStatusInProgress.
  ///
  /// In ru, this message translates to:
  /// **'В работе'**
  String get taskStatusInProgress;

  /// No description provided for @taskStatusWaiting.
  ///
  /// In ru, this message translates to:
  /// **'Ожидание'**
  String get taskStatusWaiting;

  /// No description provided for @taskStatusCompleted.
  ///
  /// In ru, this message translates to:
  /// **'Завершена'**
  String get taskStatusCompleted;

  /// No description provided for @filterAllProjects.
  ///
  /// In ru, this message translates to:
  /// **'Все проекты'**
  String get filterAllProjects;

  /// No description provided for @filterAllEmployees.
  ///
  /// In ru, this message translates to:
  /// **'Все сотрудники'**
  String get filterAllEmployees;

  /// No description provided for @filterAllStatuses.
  ///
  /// In ru, this message translates to:
  /// **'Все статусы'**
  String get filterAllStatuses;

  /// No description provided for @filterAllPriorities.
  ///
  /// In ru, this message translates to:
  /// **'Все приоритеты'**
  String get filterAllPriorities;

  /// No description provided for @filterSortLabel.
  ///
  /// In ru, this message translates to:
  /// **'Сортировка'**
  String get filterSortLabel;

  /// No description provided for @sortRecentlyUpdated.
  ///
  /// In ru, this message translates to:
  /// **'Недавно обновленные'**
  String get sortRecentlyUpdated;

  /// No description provided for @commonTitle.
  ///
  /// In ru, this message translates to:
  /// **'Название'**
  String get commonTitle;

  /// No description provided for @commonDescription.
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get commonDescription;

  /// No description provided for @commonProject.
  ///
  /// In ru, this message translates to:
  /// **'Проект'**
  String get commonProject;

  /// No description provided for @commonEmployee.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудник'**
  String get commonEmployee;

  /// No description provided for @commonStatus.
  ///
  /// In ru, this message translates to:
  /// **'Статус'**
  String get commonStatus;

  /// No description provided for @commonPriority.
  ///
  /// In ru, this message translates to:
  /// **'Приоритет'**
  String get commonPriority;

  /// No description provided for @commonDeadline.
  ///
  /// In ru, this message translates to:
  /// **'Дедлайн'**
  String get commonDeadline;

  /// No description provided for @commonStartDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата начала'**
  String get commonStartDate;

  /// No description provided for @commonEndDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата окончания'**
  String get commonEndDate;

  /// No description provided for @commonSelectDate.
  ///
  /// In ru, this message translates to:
  /// **'Выберите дату'**
  String get commonSelectDate;

  /// No description provided for @commonBudget.
  ///
  /// In ru, this message translates to:
  /// **'Бюджет'**
  String get commonBudget;

  /// No description provided for @commonEmployees.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники'**
  String get commonEmployees;

  /// No description provided for @commonRemainingBudget.
  ///
  /// In ru, this message translates to:
  /// **'Остаток бюджета'**
  String get commonRemainingBudget;

  /// No description provided for @commonTimeline.
  ///
  /// In ru, this message translates to:
  /// **'Сроки'**
  String get commonTimeline;

  /// No description provided for @commonWeather.
  ///
  /// In ru, this message translates to:
  /// **'Погода'**
  String get commonWeather;

  /// No description provided for @commonLastActivity.
  ///
  /// In ru, this message translates to:
  /// **'Последняя активность'**
  String get commonLastActivity;

  /// No description provided for @commonRecentUpdates.
  ///
  /// In ru, this message translates to:
  /// **'Последние обновления'**
  String get commonRecentUpdates;

  /// No description provided for @commonContact.
  ///
  /// In ru, this message translates to:
  /// **'Связаться'**
  String get commonContact;

  /// No description provided for @commonProgress.
  ///
  /// In ru, this message translates to:
  /// **'Прогресс'**
  String get commonProgress;

  /// No description provided for @commonProgressValue.
  ///
  /// In ru, this message translates to:
  /// **'Прогресс: {value}'**
  String commonProgressValue(String value);

  /// No description provided for @commonNoItemsYet.
  ///
  /// In ru, this message translates to:
  /// **'Пока нет данных.'**
  String get commonNoItemsYet;

  /// No description provided for @taskEstimatedCostValue.
  ///
  /// In ru, this message translates to:
  /// **'Оценочная стоимость: {cost}'**
  String taskEstimatedCostValue(String cost);

  /// No description provided for @chatsSearchLabel.
  ///
  /// In ru, this message translates to:
  /// **'Поиск чатов и пользователей'**
  String get chatsSearchLabel;

  /// No description provided for @chatsNoResults.
  ///
  /// In ru, this message translates to:
  /// **'Чаты не найдены'**
  String get chatsNoResults;

  /// No description provided for @chatsEmojiPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Смайлики и стикеры'**
  String get chatsEmojiPlaceholder;

  /// No description provided for @chatsImagePlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Отправка изображений будет доступна в следующей итерации.'**
  String get chatsImagePlaceholder;

  /// No description provided for @chatsCreateDirectPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Создание личного чата будет доступно в следующей итерации.'**
  String get chatsCreateDirectPlaceholder;

  /// No description provided for @chatCreateDirectTitle.
  ///
  /// In ru, this message translates to:
  /// **'Личный чат'**
  String get chatCreateDirectTitle;

  /// No description provided for @chatCreateGroupTitle.
  ///
  /// In ru, this message translates to:
  /// **'Создать группу'**
  String get chatCreateGroupTitle;

  /// No description provided for @chatCreateGroupButton.
  ///
  /// In ru, this message translates to:
  /// **'Новая группа'**
  String get chatCreateGroupButton;

  /// No description provided for @chatGroupCreatedPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Группа создана в локальном mock-режиме.'**
  String get chatGroupCreatedPlaceholder;

  /// No description provided for @chatGroupNameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название группы'**
  String get chatGroupNameLabel;

  /// No description provided for @chatSearchUsersLabel.
  ///
  /// In ru, this message translates to:
  /// **'Поиск участников'**
  String get chatSearchUsersLabel;

  /// No description provided for @chatAddMembersTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавить участников'**
  String get chatAddMembersTitle;

  /// No description provided for @chatAddMember.
  ///
  /// In ru, this message translates to:
  /// **'Добавить'**
  String get chatAddMember;

  /// No description provided for @chatRemoveMember.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get chatRemoveMember;

  /// No description provided for @chatGroupAdmin.
  ///
  /// In ru, this message translates to:
  /// **'Администратор группы'**
  String get chatGroupAdmin;

  /// No description provided for @chatInfoTitle.
  ///
  /// In ru, this message translates to:
  /// **'Информация о чате'**
  String get chatInfoTitle;

  /// No description provided for @chatMessageInputPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Введите сообщение'**
  String get chatMessageInputPlaceholder;

  /// No description provided for @chatSharedMediaPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Общие медиа'**
  String get chatSharedMediaPlaceholder;

  /// No description provided for @chatSharedMediaDescription.
  ///
  /// In ru, this message translates to:
  /// **'Фото и файлы появятся после интеграции backend.'**
  String get chatSharedMediaDescription;

  /// No description provided for @chatReactionsPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Реакции и ответы'**
  String get chatReactionsPlaceholder;

  /// No description provided for @chatReactionsDescription.
  ///
  /// In ru, this message translates to:
  /// **'Сводка реакций будет доступна в следующем спринте.'**
  String get chatReactionsDescription;

  /// No description provided for @chatPin.
  ///
  /// In ru, this message translates to:
  /// **'Закрепить чат'**
  String get chatPin;

  /// No description provided for @chatUnpin.
  ///
  /// In ru, this message translates to:
  /// **'Открепить чат'**
  String get chatUnpin;

  /// No description provided for @chatArchive.
  ///
  /// In ru, this message translates to:
  /// **'Архивировать чат'**
  String get chatArchive;

  /// No description provided for @chatUnarchive.
  ///
  /// In ru, this message translates to:
  /// **'Разархивировать чат'**
  String get chatUnarchive;

  /// No description provided for @chatMuteNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Отключить уведомления'**
  String get chatMuteNotifications;

  /// No description provided for @chatUnmute.
  ///
  /// In ru, this message translates to:
  /// **'Включить уведомления'**
  String get chatUnmute;

  /// No description provided for @chatDelete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить чат'**
  String get chatDelete;

  /// No description provided for @chatDeletePlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Удаление чата потребует подтверждения на backend.'**
  String get chatDeletePlaceholder;

  /// No description provided for @chatMarkRead.
  ///
  /// In ru, this message translates to:
  /// **'Отметить как прочитанный'**
  String get chatMarkRead;

  /// No description provided for @chatNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Чат не найден'**
  String get chatNotFound;

  /// No description provided for @chatMembersTitle.
  ///
  /// In ru, this message translates to:
  /// **'Участники'**
  String get chatMembersTitle;

  /// No description provided for @chatMembersCount.
  ///
  /// In ru, this message translates to:
  /// **'Участники: {count}'**
  String chatMembersCount(int count);

  /// No description provided for @chatLastSeen.
  ///
  /// In ru, this message translates to:
  /// **'Был(а) в сети: {value}'**
  String chatLastSeen(String value);

  /// No description provided for @chatShowArchived.
  ///
  /// In ru, this message translates to:
  /// **'Показать архив'**
  String get chatShowArchived;

  /// No description provided for @chatHideArchived.
  ///
  /// In ru, this message translates to:
  /// **'Скрыть архив'**
  String get chatHideArchived;

  /// No description provided for @commonBackToChat.
  ///
  /// In ru, this message translates to:
  /// **'Назад в чат'**
  String get commonBackToChat;

  /// No description provided for @settingsGeneralSection.
  ///
  /// In ru, this message translates to:
  /// **'Общие'**
  String get settingsGeneralSection;

  /// No description provided for @settingsAppearanceSection.
  ///
  /// In ru, this message translates to:
  /// **'Внешний вид'**
  String get settingsAppearanceSection;

  /// No description provided for @settingsNotificationsSection.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get settingsNotificationsSection;

  /// No description provided for @settingsSecuritySection.
  ///
  /// In ru, this message translates to:
  /// **'Безопасность'**
  String get settingsSecuritySection;

  /// No description provided for @settingsApplicationSection.
  ///
  /// In ru, this message translates to:
  /// **'Приложение'**
  String get settingsApplicationSection;

  /// No description provided for @settingsSupportSection.
  ///
  /// In ru, this message translates to:
  /// **'Поддержка'**
  String get settingsSupportSection;

  /// No description provided for @settingsDateFormat.
  ///
  /// In ru, this message translates to:
  /// **'Формат даты'**
  String get settingsDateFormat;

  /// No description provided for @settingsTimeFormat.
  ///
  /// In ru, this message translates to:
  /// **'Формат времени'**
  String get settingsTimeFormat;

  /// No description provided for @settingsDateFormatDmy.
  ///
  /// In ru, this message translates to:
  /// **'DD.MM.YYYY'**
  String get settingsDateFormatDmy;

  /// No description provided for @settingsDateFormatMdy.
  ///
  /// In ru, this message translates to:
  /// **'MM/DD/YYYY'**
  String get settingsDateFormatMdy;

  /// No description provided for @settingsDateFormatYmd.
  ///
  /// In ru, this message translates to:
  /// **'YYYY-MM-DD'**
  String get settingsDateFormatYmd;

  /// No description provided for @settingsTimeFormat24.
  ///
  /// In ru, this message translates to:
  /// **'24-часовой'**
  String get settingsTimeFormat24;

  /// No description provided for @settingsTimeFormat12.
  ///
  /// In ru, this message translates to:
  /// **'12-часовой'**
  String get settingsTimeFormat12;

  /// No description provided for @settingsPushNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Push-уведомления'**
  String get settingsPushNotifications;

  /// No description provided for @settingsChatNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления чатов'**
  String get settingsChatNotifications;

  /// No description provided for @settingsTaskNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления задач'**
  String get settingsTaskNotifications;

  /// No description provided for @settingsFinanceNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Финансовые уведомления'**
  String get settingsFinanceNotifications;

  /// No description provided for @settingsPinCode.
  ///
  /// In ru, this message translates to:
  /// **'PIN-код'**
  String get settingsPinCode;

  /// No description provided for @settingsBiometric.
  ///
  /// In ru, this message translates to:
  /// **'Биометрия'**
  String get settingsBiometric;

  /// No description provided for @settingsAutoLock.
  ///
  /// In ru, this message translates to:
  /// **'Автоблокировка'**
  String get settingsAutoLock;

  /// No description provided for @settingsChangePassword.
  ///
  /// In ru, this message translates to:
  /// **'Сменить пароль'**
  String get settingsChangePassword;

  /// No description provided for @settingsSecurityPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Смена пароля будет доступна после интеграции сервиса идентификации.'**
  String get settingsSecurityPlaceholder;

  /// No description provided for @settingsCache.
  ///
  /// In ru, this message translates to:
  /// **'Очистить кэш'**
  String get settingsCache;

  /// No description provided for @settingsStorage.
  ///
  /// In ru, this message translates to:
  /// **'Использование хранилища'**
  String get settingsStorage;

  /// No description provided for @settingsPrivacyMode.
  ///
  /// In ru, this message translates to:
  /// **'Режим приватности'**
  String get settingsPrivacyMode;

  /// No description provided for @settingsPrivacyModeSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Скрывать чувствительные значения в списках и карточках.'**
  String get settingsPrivacyModeSubtitle;

  /// No description provided for @settingsAnalytics.
  ///
  /// In ru, this message translates to:
  /// **'Анонимная аналитика'**
  String get settingsAnalytics;

  /// No description provided for @settingsAnalyticsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Помогать улучшать продукт с помощью анонимной телеметрии.'**
  String get settingsAnalyticsSubtitle;

  /// No description provided for @settingsAccessibilityHighContrast.
  ///
  /// In ru, this message translates to:
  /// **'Высокая контрастность'**
  String get settingsAccessibilityHighContrast;

  /// No description provided for @settingsAccessibilityReduceMotion.
  ///
  /// In ru, this message translates to:
  /// **'Уменьшить анимацию'**
  String get settingsAccessibilityReduceMotion;

  /// No description provided for @settingsDataSaver.
  ///
  /// In ru, this message translates to:
  /// **'Экономия трафика'**
  String get settingsDataSaver;

  /// No description provided for @settingsBackup.
  ///
  /// In ru, this message translates to:
  /// **'Резервное копирование'**
  String get settingsBackup;

  /// No description provided for @settingsBackupPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Резервное копирование и восстановление будут добавлены позже.'**
  String get settingsBackupPlaceholder;

  /// No description provided for @settingsExportData.
  ///
  /// In ru, this message translates to:
  /// **'Экспорт данных'**
  String get settingsExportData;

  /// No description provided for @settingsAboutApp.
  ///
  /// In ru, this message translates to:
  /// **'О приложении'**
  String get settingsAboutApp;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In ru, this message translates to:
  /// **'Политика конфиденциальности'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsTerms.
  ///
  /// In ru, this message translates to:
  /// **'Условия использования'**
  String get settingsTerms;

  /// No description provided for @settingsHelpCenter.
  ///
  /// In ru, this message translates to:
  /// **'Центр помощи'**
  String get settingsHelpCenter;

  /// No description provided for @settingsContactSupport.
  ///
  /// In ru, this message translates to:
  /// **'Связаться с поддержкой'**
  String get settingsContactSupport;

  /// No description provided for @settingsSendFeedback.
  ///
  /// In ru, this message translates to:
  /// **'Отправить отзыв'**
  String get settingsSendFeedback;

  /// No description provided for @settingsActionPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Действие будет доступно на следующем этапе интеграции.'**
  String get settingsActionPlaceholder;

  /// No description provided for @profileRoleLabel.
  ///
  /// In ru, this message translates to:
  /// **'Роль'**
  String get profileRoleLabel;

  /// No description provided for @profilePositionLabel.
  ///
  /// In ru, this message translates to:
  /// **'Должность'**
  String get profilePositionLabel;

  /// No description provided for @profileDepartmentLabel.
  ///
  /// In ru, this message translates to:
  /// **'Отдел'**
  String get profileDepartmentLabel;

  /// No description provided for @profileCompanyLabel.
  ///
  /// In ru, this message translates to:
  /// **'Компания'**
  String get profileCompanyLabel;

  /// No description provided for @profileCoverPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Заглушка обложки профиля'**
  String get profileCoverPlaceholder;

  /// No description provided for @profileStatsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Статистика'**
  String get profileStatsTitle;

  /// No description provided for @profileAchievementsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Достижения'**
  String get profileAchievementsTitle;

  /// No description provided for @profileAchievementsPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Заглушка витрины достижений.'**
  String get profileAchievementsPlaceholder;

  /// No description provided for @profileRecentActivityTitle.
  ///
  /// In ru, this message translates to:
  /// **'Последняя активность'**
  String get profileRecentActivityTitle;

  /// No description provided for @profileRecentActivityPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Заглушка последней активности профиля.'**
  String get profileRecentActivityPlaceholder;

  /// No description provided for @profileNotificationStatus.
  ///
  /// In ru, this message translates to:
  /// **'Статус уведомлений'**
  String get profileNotificationStatus;

  /// No description provided for @profileSecurityStatus.
  ///
  /// In ru, this message translates to:
  /// **'Статус безопасности'**
  String get profileSecurityStatus;

  /// No description provided for @profileAboutTitle.
  ///
  /// In ru, this message translates to:
  /// **'О приложении'**
  String get profileAboutTitle;

  /// No description provided for @profileVersionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Версия'**
  String get profileVersionTitle;

  /// No description provided for @profileVersionValue.
  ///
  /// In ru, this message translates to:
  /// **'1.0.0-enterprise'**
  String get profileVersionValue;

  /// No description provided for @profileNotificationEnabled.
  ///
  /// In ru, this message translates to:
  /// **'Включено'**
  String get profileNotificationEnabled;

  /// No description provided for @profileNotificationDisabled.
  ///
  /// In ru, this message translates to:
  /// **'Выключено'**
  String get profileNotificationDisabled;

  /// No description provided for @profileSecurityEnabled.
  ///
  /// In ru, this message translates to:
  /// **'Локальная защита включена'**
  String get profileSecurityEnabled;

  /// No description provided for @profileSecurityDisabled.
  ///
  /// In ru, this message translates to:
  /// **'Локальная защита выключена'**
  String get profileSecurityDisabled;

  /// No description provided for @profileAboutDescription.
  ///
  /// In ru, this message translates to:
  /// **'ACM объединяет управление проектами, задачами, коммуникацией и финансами для строительных команд.'**
  String get profileAboutDescription;

  /// No description provided for @statProjects.
  ///
  /// In ru, this message translates to:
  /// **'Проекты'**
  String get statProjects;

  /// No description provided for @statEmployees.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники'**
  String get statEmployees;

  /// No description provided for @statTasksToday.
  ///
  /// In ru, this message translates to:
  /// **'Задачи на сегодня'**
  String get statTasksToday;

  /// No description provided for @statCompletedTasks.
  ///
  /// In ru, this message translates to:
  /// **'Выполненные задачи'**
  String get statCompletedTasks;

  /// No description provided for @statPendingTasks.
  ///
  /// In ru, this message translates to:
  /// **'Ожидающие задачи'**
  String get statPendingTasks;

  /// No description provided for @statOverdueTasks.
  ///
  /// In ru, this message translates to:
  /// **'Просроченные задачи'**
  String get statOverdueTasks;

  /// No description provided for @statProjectProgress.
  ///
  /// In ru, this message translates to:
  /// **'Прогресс проекта'**
  String get statProjectProgress;

  /// No description provided for @statExpenses.
  ///
  /// In ru, this message translates to:
  /// **'Расходы'**
  String get statExpenses;

  /// No description provided for @statIncome.
  ///
  /// In ru, this message translates to:
  /// **'Доход'**
  String get statIncome;

  /// No description provided for @statMonthlyExpenses.
  ///
  /// In ru, this message translates to:
  /// **'Расходы за месяц'**
  String get statMonthlyExpenses;

  /// No description provided for @statMonthlyIncome.
  ///
  /// In ru, this message translates to:
  /// **'Доход за месяц'**
  String get statMonthlyIncome;

  /// No description provided for @tabChat.
  ///
  /// In ru, this message translates to:
  /// **'Чат'**
  String get tabChat;

  /// No description provided for @tabReports.
  ///
  /// In ru, this message translates to:
  /// **'Отчеты'**
  String get tabReports;

  /// No description provided for @projectTabChatPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Лента проектной коммуникации и обсуждений.'**
  String get projectTabChatPlaceholder;

  /// No description provided for @projectTabReportsPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Проектные отчеты, инспекции и сводки для руководства.'**
  String get projectTabReportsPlaceholder;

  /// No description provided for @taskStatusInspection.
  ///
  /// In ru, this message translates to:
  /// **'Инспекция'**
  String get taskStatusInspection;

  /// No description provided for @tasksListMode.
  ///
  /// In ru, this message translates to:
  /// **'Список'**
  String get tasksListMode;

  /// No description provided for @tasksKanbanMode.
  ///
  /// In ru, this message translates to:
  /// **'Kanban'**
  String get tasksKanbanMode;

  /// No description provided for @kanbanDropTasksHere.
  ///
  /// In ru, this message translates to:
  /// **'Перетащите задачу сюда'**
  String get kanbanDropTasksHere;

  /// No description provided for @kanbanReleaseToMove.
  ///
  /// In ru, this message translates to:
  /// **'Отпустите, чтобы переместить задачу'**
  String get kanbanReleaseToMove;

  /// No description provided for @kanbanPlanned.
  ///
  /// In ru, this message translates to:
  /// **'Запланировано'**
  String get kanbanPlanned;

  /// No description provided for @kanbanInProgress.
  ///
  /// In ru, this message translates to:
  /// **'В работе'**
  String get kanbanInProgress;

  /// No description provided for @kanbanWaiting.
  ///
  /// In ru, this message translates to:
  /// **'Ожидание'**
  String get kanbanWaiting;

  /// No description provided for @kanbanInspection.
  ///
  /// In ru, this message translates to:
  /// **'Инспекция'**
  String get kanbanInspection;

  /// No description provided for @kanbanCompleted.
  ///
  /// In ru, this message translates to:
  /// **'Завершено'**
  String get kanbanCompleted;

  /// No description provided for @reportsModuleTitle.
  ///
  /// In ru, this message translates to:
  /// **'Строительные отчеты'**
  String get reportsModuleTitle;

  /// No description provided for @reportsModuleHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Центр проектной отчетности'**
  String get reportsModuleHeadline;

  /// No description provided for @reportsModuleSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Контролируйте эффективность, качество, безопасность и бюджет в одном окне.'**
  String get reportsModuleSubtitle;

  /// No description provided for @reportsWeeklyProgress.
  ///
  /// In ru, this message translates to:
  /// **'Еженедельный прогресс'**
  String get reportsWeeklyProgress;

  /// No description provided for @reportsSafetyChecks.
  ///
  /// In ru, this message translates to:
  /// **'Проверки безопасности'**
  String get reportsSafetyChecks;

  /// No description provided for @reportsBudgetDeviation.
  ///
  /// In ru, this message translates to:
  /// **'Отклонение бюджета'**
  String get reportsBudgetDeviation;

  /// No description provided for @reportsQualityScore.
  ///
  /// In ru, this message translates to:
  /// **'Оценка качества'**
  String get reportsQualityScore;

  /// No description provided for @reportsChartsPlaceholderTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сводка по графикам'**
  String get reportsChartsPlaceholderTitle;

  /// No description provided for @reportsChartsPlaceholderSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'S-кривая, производительность и тренды качества по проектам.'**
  String get reportsChartsPlaceholderSubtitle;

  /// No description provided for @reportsExportPlaceholderTitle.
  ///
  /// In ru, this message translates to:
  /// **'Экспорт отчетов'**
  String get reportsExportPlaceholderTitle;

  /// No description provided for @reportsExportPlaceholderSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'PDF/XLS экспорт выбранного диапазона и проекта.'**
  String get reportsExportPlaceholderSubtitle;

  /// No description provided for @globalSearchTitle.
  ///
  /// In ru, this message translates to:
  /// **'Глобальный поиск'**
  String get globalSearchTitle;

  /// No description provided for @globalSearchHint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск по проектам, сотрудникам, задачам, чатам и документам'**
  String get globalSearchHint;

  /// No description provided for @globalSearchStartTyping.
  ///
  /// In ru, this message translates to:
  /// **'Начните ввод для поиска'**
  String get globalSearchStartTyping;

  /// No description provided for @globalSearchNoResults.
  ///
  /// In ru, this message translates to:
  /// **'Ничего не найдено'**
  String get globalSearchNoResults;

  /// No description provided for @globalSearchPhotosCount.
  ///
  /// In ru, this message translates to:
  /// **'Фото: {count}'**
  String globalSearchPhotosCount(int count);

  /// No description provided for @dashboardWidgetsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Операционные виджеты'**
  String get dashboardWidgetsTitle;

  /// No description provided for @dashboardWeatherTitle.
  ///
  /// In ru, this message translates to:
  /// **'Текущая погода'**
  String get dashboardWeatherTitle;

  /// No description provided for @dashboardWeatherPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Заглушка погоды'**
  String get dashboardWeatherPlaceholder;

  /// No description provided for @dashboardTodayTasksTitle.
  ///
  /// In ru, this message translates to:
  /// **'Задачи на сегодня'**
  String get dashboardTodayTasksTitle;

  /// No description provided for @dashboardRecentMessagesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Последние сообщения'**
  String get dashboardRecentMessagesTitle;

  /// No description provided for @dashboardRecentExpensesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Последние расходы'**
  String get dashboardRecentExpensesTitle;

  /// No description provided for @dashboardProjectProgressTitle.
  ///
  /// In ru, this message translates to:
  /// **'Прогресс проекта'**
  String get dashboardProjectProgressTitle;

  /// No description provided for @dashboardEmployeesOnlineTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники онлайн'**
  String get dashboardEmployeesOnlineTitle;

  /// No description provided for @dashboardChartsPlaceholderTitle.
  ///
  /// In ru, this message translates to:
  /// **'Графики'**
  String get dashboardChartsPlaceholderTitle;

  /// No description provided for @dashboardChartsPlaceholderSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Заглушка графиков S-кривой и прогресса'**
  String get dashboardChartsPlaceholderSubtitle;

  /// No description provided for @dashboardQuickActionsHint.
  ///
  /// In ru, this message translates to:
  /// **'Быстрый переход к ключевым модулям'**
  String get dashboardQuickActionsHint;

  /// No description provided for @photoReportsCreateAlbum.
  ///
  /// In ru, this message translates to:
  /// **'Создать альбом'**
  String get photoReportsCreateAlbum;

  /// No description provided for @photoReportsDescriptionPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Заглушка описания фотоотчета'**
  String get photoReportsDescriptionPlaceholder;

  /// No description provided for @photoReportsLocationPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Заглушка локации'**
  String get photoReportsLocationPlaceholder;

  /// No description provided for @photoReportsAddPhotoPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Добавление фото на этом этапе работает в режиме заглушки.'**
  String get photoReportsAddPhotoPlaceholder;

  /// No description provided for @photoReportsTaskLabel.
  ///
  /// In ru, this message translates to:
  /// **'Задача'**
  String get photoReportsTaskLabel;

  /// No description provided for @photoReportsTimeLabel.
  ///
  /// In ru, this message translates to:
  /// **'Время'**
  String get photoReportsTimeLabel;

  /// No description provided for @photoReportsLocationLabel.
  ///
  /// In ru, this message translates to:
  /// **'Локация'**
  String get photoReportsLocationLabel;

  /// No description provided for @photoReportsAddBefore.
  ///
  /// In ru, this message translates to:
  /// **'Добавить до'**
  String get photoReportsAddBefore;

  /// No description provided for @photoReportsAddAfter.
  ///
  /// In ru, this message translates to:
  /// **'Добавить после'**
  String get photoReportsAddAfter;

  /// No description provided for @photoReportsDeleteBefore.
  ///
  /// In ru, this message translates to:
  /// **'Удалить до'**
  String get photoReportsDeleteBefore;

  /// No description provided for @photoReportsDeleteAfter.
  ///
  /// In ru, this message translates to:
  /// **'Удалить после'**
  String get photoReportsDeleteAfter;

  /// No description provided for @photoReportsPreviewTitle.
  ///
  /// In ru, this message translates to:
  /// **'Предпросмотр фото'**
  String get photoReportsPreviewTitle;

  /// No description provided for @documentsCategoryLabel.
  ///
  /// In ru, this message translates to:
  /// **'Категория'**
  String get documentsCategoryLabel;

  /// No description provided for @documentsDateLabel.
  ///
  /// In ru, this message translates to:
  /// **'Дата'**
  String get documentsDateLabel;

  /// No description provided for @documentsAuthorLabel.
  ///
  /// In ru, this message translates to:
  /// **'Автор'**
  String get documentsAuthorLabel;

  /// No description provided for @documentsSizeLabel.
  ///
  /// In ru, this message translates to:
  /// **'Размер'**
  String get documentsSizeLabel;

  /// No description provided for @documentsVersionLabel.
  ///
  /// In ru, this message translates to:
  /// **'Версия'**
  String get documentsVersionLabel;

  /// No description provided for @financeExpensesLabel.
  ///
  /// In ru, this message translates to:
  /// **'Расходы'**
  String get financeExpensesLabel;

  /// No description provided for @financeNetLabel.
  ///
  /// In ru, this message translates to:
  /// **'Чистый результат'**
  String get financeNetLabel;

  /// No description provided for @financeCategoriesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Структура по категориям'**
  String get financeCategoriesTitle;

  /// No description provided for @financeMonthlySummaryTitle.
  ///
  /// In ru, this message translates to:
  /// **'Итоги месяца'**
  String get financeMonthlySummaryTitle;

  /// No description provided for @financeFuelLabel.
  ///
  /// In ru, this message translates to:
  /// **'Топливо'**
  String get financeFuelLabel;

  /// No description provided for @financeEquipmentLabel.
  ///
  /// In ru, this message translates to:
  /// **'Оборудование'**
  String get financeEquipmentLabel;

  /// No description provided for @financeMaterialsLabel.
  ///
  /// In ru, this message translates to:
  /// **'Материалы'**
  String get financeMaterialsLabel;

  /// No description provided for @financeWorkersLabel.
  ///
  /// In ru, this message translates to:
  /// **'Рабочие'**
  String get financeWorkersLabel;

  /// No description provided for @financeTransportLabel.
  ///
  /// In ru, this message translates to:
  /// **'Транспорт'**
  String get financeTransportLabel;

  /// No description provided for @financeOtherLabel.
  ///
  /// In ru, this message translates to:
  /// **'Другое'**
  String get financeOtherLabel;

  /// No description provided for @employeeAssignedProjectsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Назначенные проекты'**
  String get employeeAssignedProjectsTitle;

  /// No description provided for @employeeAssignedTasksTitle.
  ///
  /// In ru, this message translates to:
  /// **'Назначенные задачи'**
  String get employeeAssignedTasksTitle;

  /// No description provided for @employeeCompletedTasksTitle.
  ///
  /// In ru, this message translates to:
  /// **'Выполненные задачи'**
  String get employeeCompletedTasksTitle;

  /// No description provided for @employeePerformanceTitle.
  ///
  /// In ru, this message translates to:
  /// **'Производительность'**
  String get employeePerformanceTitle;

  /// No description provided for @employeeAttendancePlaceholderTitle.
  ///
  /// In ru, this message translates to:
  /// **'Активные задачи'**
  String get employeeAttendancePlaceholderTitle;

  /// No description provided for @employeeAttendancePlaceholderSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Текущая рабочая загрузка по сотруднику.'**
  String get employeeAttendancePlaceholderSubtitle;

  /// No description provided for @employeeWorkingHoursPlaceholderTitle.
  ///
  /// In ru, this message translates to:
  /// **'Рабочие часы'**
  String get employeeWorkingHoursPlaceholderTitle;

  /// No description provided for @employeeWorkingHoursPlaceholderSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Заглушка интеграции учета рабочего времени.'**
  String get employeeWorkingHoursPlaceholderSubtitle;

  /// No description provided for @adminTitle.
  ///
  /// In ru, this message translates to:
  /// **'Администрирование'**
  String get adminTitle;

  /// No description provided for @adminTabOverview.
  ///
  /// In ru, this message translates to:
  /// **'Обзор'**
  String get adminTabOverview;

  /// No description provided for @adminTabCompany.
  ///
  /// In ru, this message translates to:
  /// **'Компания'**
  String get adminTabCompany;

  /// No description provided for @adminTabRbac.
  ///
  /// In ru, this message translates to:
  /// **'RBAC'**
  String get adminTabRbac;

  /// No description provided for @adminTabManagement.
  ///
  /// In ru, this message translates to:
  /// **'Управление'**
  String get adminTabManagement;

  /// No description provided for @adminTabActivity.
  ///
  /// In ru, this message translates to:
  /// **'Активность'**
  String get adminTabActivity;

  /// No description provided for @adminOverviewHeadline.
  ///
  /// In ru, this message translates to:
  /// **'Корпоративная админ-панель'**
  String get adminOverviewHeadline;

  /// No description provided for @adminOverviewSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Управляйте компаниями, ролями, проектами, отделами и контролем соответствия.'**
  String get adminOverviewSubtitle;

  /// No description provided for @adminDepartmentsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Отделы'**
  String get adminDepartmentsTitle;

  /// No description provided for @adminTeamsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Команды'**
  String get adminTeamsTitle;

  /// No description provided for @adminRolesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Роли'**
  String get adminRolesTitle;

  /// No description provided for @adminOrganizationStructure.
  ///
  /// In ru, this message translates to:
  /// **'Оргструктура'**
  String get adminOrganizationStructure;

  /// No description provided for @adminCompanySettingsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройки компании'**
  String get adminCompanySettingsTitle;

  /// No description provided for @adminCompanyLogo.
  ///
  /// In ru, this message translates to:
  /// **'Логотип компании'**
  String get adminCompanyLogo;

  /// No description provided for @adminCompanyName.
  ///
  /// In ru, this message translates to:
  /// **'Название компании'**
  String get adminCompanyName;

  /// No description provided for @adminCompanyBin.
  ///
  /// In ru, this message translates to:
  /// **'BIN'**
  String get adminCompanyBin;

  /// No description provided for @adminCompanyWebsite.
  ///
  /// In ru, this message translates to:
  /// **'Веб-сайт'**
  String get adminCompanyWebsite;

  /// No description provided for @adminCompanyWorkingHours.
  ///
  /// In ru, this message translates to:
  /// **'Рабочие часы'**
  String get adminCompanyWorkingHours;

  /// No description provided for @adminCompanyTimezone.
  ///
  /// In ru, this message translates to:
  /// **'Часовой пояс'**
  String get adminCompanyTimezone;

  /// No description provided for @adminCompanyCurrency.
  ///
  /// In ru, this message translates to:
  /// **'Валюта'**
  String get adminCompanyCurrency;

  /// No description provided for @adminCompanyMeasurement.
  ///
  /// In ru, this message translates to:
  /// **'Система измерений'**
  String get adminCompanyMeasurement;

  /// No description provided for @adminSuspendCompany.
  ///
  /// In ru, this message translates to:
  /// **'Приостановить компанию'**
  String get adminSuspendCompany;

  /// No description provided for @adminSuspendCompanySubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Временно ограничить все операции компании.'**
  String get adminSuspendCompanySubtitle;

  /// No description provided for @adminCreateCompany.
  ///
  /// In ru, this message translates to:
  /// **'Создать компанию'**
  String get adminCreateCompany;

  /// No description provided for @adminEditCompany.
  ///
  /// In ru, this message translates to:
  /// **'Изменить компанию'**
  String get adminEditCompany;

  /// No description provided for @adminDeleteCompany.
  ///
  /// In ru, this message translates to:
  /// **'Удалить компанию'**
  String get adminDeleteCompany;

  /// No description provided for @adminActionCompanyCreated.
  ///
  /// In ru, this message translates to:
  /// **'Компания создана (mock).'**
  String get adminActionCompanyCreated;

  /// No description provided for @adminActionCompanyUpdated.
  ///
  /// In ru, this message translates to:
  /// **'Компания обновлена (mock).'**
  String get adminActionCompanyUpdated;

  /// No description provided for @adminActionCompanyDeleted.
  ///
  /// In ru, this message translates to:
  /// **'Компания удалена (mock).'**
  String get adminActionCompanyDeleted;

  /// No description provided for @adminRbacTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ролевой доступ'**
  String get adminRbacTitle;

  /// No description provided for @adminRbacSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройте права для каждой корпоративной роли.'**
  String get adminRbacSubtitle;

  /// No description provided for @adminResetPermissions.
  ///
  /// In ru, this message translates to:
  /// **'Сбросить права'**
  String get adminResetPermissions;

  /// No description provided for @adminSavePermissions.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить права'**
  String get adminSavePermissions;

  /// No description provided for @adminActionRoleReset.
  ///
  /// In ru, this message translates to:
  /// **'Права роли сброшены к шаблону.'**
  String get adminActionRoleReset;

  /// No description provided for @adminActionRoleSaved.
  ///
  /// In ru, this message translates to:
  /// **'Права роли сохранены (mock).'**
  String get adminActionRoleSaved;

  /// No description provided for @adminCreateProjects.
  ///
  /// In ru, this message translates to:
  /// **'Создать проекты'**
  String get adminCreateProjects;

  /// No description provided for @adminCreateProjectsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Создавайте и запускайте новые рабочие пространства проектов.'**
  String get adminCreateProjectsSubtitle;

  /// No description provided for @adminArchiveProjects.
  ///
  /// In ru, this message translates to:
  /// **'Архивировать проекты'**
  String get adminArchiveProjects;

  /// No description provided for @adminArchiveProjectsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Переносите завершенные проекты в архив.'**
  String get adminArchiveProjectsSubtitle;

  /// No description provided for @adminActionProjectCreated.
  ///
  /// In ru, this message translates to:
  /// **'Проект создан (mock).'**
  String get adminActionProjectCreated;

  /// No description provided for @adminManagementModules.
  ///
  /// In ru, this message translates to:
  /// **'Управляющие модули'**
  String get adminManagementModules;

  /// No description provided for @adminOpen.
  ///
  /// In ru, this message translates to:
  /// **'Открыть'**
  String get adminOpen;

  /// No description provided for @adminActionOpened.
  ///
  /// In ru, this message translates to:
  /// **'открыто'**
  String get adminActionOpened;

  /// No description provided for @adminActivityTitle.
  ///
  /// In ru, this message translates to:
  /// **'История активности'**
  String get adminActivityTitle;

  /// No description provided for @adminActivitySubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Отслеживайте все критичные операции в корпоративных модулях.'**
  String get adminActivitySubtitle;

  /// No description provided for @adminRoleOwner.
  ///
  /// In ru, this message translates to:
  /// **'Владелец'**
  String get adminRoleOwner;

  /// No description provided for @adminRoleAdministrator.
  ///
  /// In ru, this message translates to:
  /// **'Администратор'**
  String get adminRoleAdministrator;

  /// No description provided for @adminRoleViewer.
  ///
  /// In ru, this message translates to:
  /// **'Наблюдатель'**
  String get adminRoleViewer;

  /// No description provided for @adminPermissionViewProjects.
  ///
  /// In ru, this message translates to:
  /// **'Может просматривать проекты'**
  String get adminPermissionViewProjects;

  /// No description provided for @adminPermissionEditProjects.
  ///
  /// In ru, this message translates to:
  /// **'Может редактировать проекты'**
  String get adminPermissionEditProjects;

  /// No description provided for @adminPermissionDeleteProjects.
  ///
  /// In ru, this message translates to:
  /// **'Может удалять проекты'**
  String get adminPermissionDeleteProjects;

  /// No description provided for @adminPermissionCreateTasks.
  ///
  /// In ru, this message translates to:
  /// **'Может создавать задачи'**
  String get adminPermissionCreateTasks;

  /// No description provided for @adminPermissionCompleteTasks.
  ///
  /// In ru, this message translates to:
  /// **'Может завершать задачи'**
  String get adminPermissionCompleteTasks;

  /// No description provided for @adminPermissionViewFinance.
  ///
  /// In ru, this message translates to:
  /// **'Может просматривать финансы'**
  String get adminPermissionViewFinance;

  /// No description provided for @adminPermissionEditFinance.
  ///
  /// In ru, this message translates to:
  /// **'Может редактировать финансы'**
  String get adminPermissionEditFinance;

  /// No description provided for @adminPermissionUploadDocuments.
  ///
  /// In ru, this message translates to:
  /// **'Может загружать документы'**
  String get adminPermissionUploadDocuments;

  /// No description provided for @adminPermissionDeleteDocuments.
  ///
  /// In ru, this message translates to:
  /// **'Может удалять документы'**
  String get adminPermissionDeleteDocuments;

  /// No description provided for @adminPermissionManageEmployees.
  ///
  /// In ru, this message translates to:
  /// **'Может управлять сотрудниками'**
  String get adminPermissionManageEmployees;

  /// No description provided for @adminPermissionManageChats.
  ///
  /// In ru, this message translates to:
  /// **'Может управлять чатами'**
  String get adminPermissionManageChats;

  /// No description provided for @adminPermissionManageReports.
  ///
  /// In ru, this message translates to:
  /// **'Может управлять отчетами'**
  String get adminPermissionManageReports;

  /// No description provided for @adminPermissionManageSettings.
  ///
  /// In ru, this message translates to:
  /// **'Может управлять настройками'**
  String get adminPermissionManageSettings;

  /// No description provided for @homeSummarySection.
  ///
  /// In ru, this message translates to:
  /// **'Сводка'**
  String get homeSummarySection;

  /// No description provided for @tasksTabAll.
  ///
  /// In ru, this message translates to:
  /// **'Все'**
  String get tasksTabAll;

  /// No description provided for @tasksTabMine.
  ///
  /// In ru, this message translates to:
  /// **'Мои'**
  String get tasksTabMine;

  /// No description provided for @tasksTabInProgress.
  ///
  /// In ru, this message translates to:
  /// **'В работе'**
  String get tasksTabInProgress;

  /// No description provided for @tasksTabCompleted.
  ///
  /// In ru, this message translates to:
  /// **'Готово'**
  String get tasksTabCompleted;

  /// No description provided for @tasksTabKanban.
  ///
  /// In ru, this message translates to:
  /// **'Канбан'**
  String get tasksTabKanban;

  /// No description provided for @tasksFiltersTitle.
  ///
  /// In ru, this message translates to:
  /// **'Фильтры'**
  String get tasksFiltersTitle;

  /// No description provided for @chatGroupAvatarTitle.
  ///
  /// In ru, this message translates to:
  /// **'Аватар группы'**
  String get chatGroupAvatarTitle;

  /// No description provided for @chatGroupAvatarSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Выбор аватара будет подключен после интеграции хранилища медиа.'**
  String get chatGroupAvatarSubtitle;

  /// No description provided for @chatLeaveGroup.
  ///
  /// In ru, this message translates to:
  /// **'Покинуть группу'**
  String get chatLeaveGroup;

  /// No description provided for @chatAvatarActionPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Действие с аватаром будет доступно в подключенном режиме.'**
  String get chatAvatarActionPlaceholder;

  /// No description provided for @chatChangeAvatar.
  ///
  /// In ru, this message translates to:
  /// **'Изменить'**
  String get chatChangeAvatar;

  /// No description provided for @profilePositionValue.
  ///
  /// In ru, this message translates to:
  /// **'Старший менеджер проекта'**
  String get profilePositionValue;

  /// No description provided for @profileDepartmentValue.
  ///
  /// In ru, this message translates to:
  /// **'Проектный офис'**
  String get profileDepartmentValue;

  /// No description provided for @profileCompanyValue.
  ///
  /// In ru, this message translates to:
  /// **'ACM Control Center'**
  String get profileCompanyValue;

  /// No description provided for @profilePhoneValue.
  ///
  /// In ru, this message translates to:
  /// **'+7 777 450 22 11'**
  String get profilePhoneValue;

  /// No description provided for @profileEmailValue.
  ///
  /// In ru, this message translates to:
  /// **'manager@structra-group.com'**
  String get profileEmailValue;

  /// No description provided for @enterpriseCalendarTitle.
  ///
  /// In ru, this message translates to:
  /// **'Календарь'**
  String get enterpriseCalendarTitle;

  /// No description provided for @enterpriseCalendarViewDaily.
  ///
  /// In ru, this message translates to:
  /// **'День'**
  String get enterpriseCalendarViewDaily;

  /// No description provided for @enterpriseCalendarViewWeekly.
  ///
  /// In ru, this message translates to:
  /// **'Неделя'**
  String get enterpriseCalendarViewWeekly;

  /// No description provided for @enterpriseCalendarViewMonthly.
  ///
  /// In ru, this message translates to:
  /// **'Месяц'**
  String get enterpriseCalendarViewMonthly;

  /// No description provided for @enterpriseCalendarCardTitle.
  ///
  /// In ru, this message translates to:
  /// **'Корпоративный календарь'**
  String get enterpriseCalendarCardTitle;

  /// No description provided for @enterpriseCalendarCardSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Графики задач, проектов и сотрудников'**
  String get enterpriseCalendarCardSubtitle;

  /// No description provided for @enterpriseCalendarCardDescription.
  ///
  /// In ru, this message translates to:
  /// **'Встречи и смены отображаются как реальные события строительного графика.'**
  String get enterpriseCalendarCardDescription;

  /// No description provided for @enterpriseDrawingsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Чертежи'**
  String get enterpriseDrawingsTitle;

  /// No description provided for @enterpriseDrawingsCardTitle.
  ///
  /// In ru, this message translates to:
  /// **'Модуль чертежей'**
  String get enterpriseDrawingsCardTitle;

  /// No description provided for @enterpriseDrawingsCardSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'DWG, PDF, blueprints, 3D-модели и спецификации'**
  String get enterpriseDrawingsCardSubtitle;

  /// No description provided for @enterpriseDrawingsCardDescription.
  ///
  /// In ru, this message translates to:
  /// **'Реестр чертежей с контролем версий, ревизий и согласований.'**
  String get enterpriseDrawingsCardDescription;

  /// No description provided for @enterpriseDrawingsAuthorLabel.
  ///
  /// In ru, this message translates to:
  /// **'Автор'**
  String get enterpriseDrawingsAuthorLabel;

  /// No description provided for @enterpriseDrawingsActionsLabel.
  ///
  /// In ru, this message translates to:
  /// **'Предпросмотр доступен • Загрузка доступна • Комментарии и история ревизий'**
  String get enterpriseDrawingsActionsLabel;

  /// No description provided for @enterpriseEquipmentTitle.
  ///
  /// In ru, this message translates to:
  /// **'Оборудование'**
  String get enterpriseEquipmentTitle;

  /// No description provided for @enterpriseEquipmentCardTitle.
  ///
  /// In ru, this message translates to:
  /// **'Управление оборудованием'**
  String get enterpriseEquipmentCardTitle;

  /// No description provided for @enterpriseEquipmentCardSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Статус, назначение и цикл обслуживания'**
  String get enterpriseEquipmentCardSubtitle;

  /// No description provided for @enterpriseEquipmentCardDescription.
  ///
  /// In ru, this message translates to:
  /// **'Для каждой единицы ведется учет топлива и состояние инспекций.'**
  String get enterpriseEquipmentCardDescription;

  /// No description provided for @enterpriseEquipmentSerialLabel.
  ///
  /// In ru, this message translates to:
  /// **'Серийный номер'**
  String get enterpriseEquipmentSerialLabel;

  /// No description provided for @enterpriseEquipmentMaintenanceLabel.
  ///
  /// In ru, this message translates to:
  /// **'Обслуживание'**
  String get enterpriseEquipmentMaintenanceLabel;

  /// No description provided for @enterpriseEquipmentFuelLabel.
  ///
  /// In ru, this message translates to:
  /// **'Расход топлива отслеживается'**
  String get enterpriseEquipmentFuelLabel;

  /// No description provided for @enterpriseEquipmentInspectionLabel.
  ///
  /// In ru, this message translates to:
  /// **'Инспекция запланирована'**
  String get enterpriseEquipmentInspectionLabel;

  /// No description provided for @enterpriseVehiclesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Транспорт'**
  String get enterpriseVehiclesTitle;

  /// No description provided for @enterpriseVehiclesCardTitle.
  ///
  /// In ru, this message translates to:
  /// **'Управление автопарком'**
  String get enterpriseVehiclesCardTitle;

  /// No description provided for @enterpriseVehiclesCardSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Операции флота и контроль сервиса'**
  String get enterpriseVehiclesCardSubtitle;

  /// No description provided for @enterpriseVehiclesCardDescription.
  ///
  /// In ru, this message translates to:
  /// **'Записи автопарка включают маршрутный статус, сервис и документы.'**
  String get enterpriseVehiclesCardDescription;

  /// No description provided for @enterpriseVehiclesDriverLabel.
  ///
  /// In ru, this message translates to:
  /// **'Водитель'**
  String get enterpriseVehiclesDriverLabel;

  /// No description provided for @enterpriseVehiclesMileageLabel.
  ///
  /// In ru, this message translates to:
  /// **'Пробег'**
  String get enterpriseVehiclesMileageLabel;

  /// No description provided for @enterpriseVehiclesFuelLabel.
  ///
  /// In ru, this message translates to:
  /// **'Топливо'**
  String get enterpriseVehiclesFuelLabel;

  /// No description provided for @enterpriseVehiclesMaintenanceLabel.
  ///
  /// In ru, this message translates to:
  /// **'Обслуживание'**
  String get enterpriseVehiclesMaintenanceLabel;

  /// No description provided for @enterpriseVehiclesDocumentsLabel.
  ///
  /// In ru, this message translates to:
  /// **'Документы актуальны'**
  String get enterpriseVehiclesDocumentsLabel;

  /// No description provided for @enterpriseWarehouseTitle.
  ///
  /// In ru, this message translates to:
  /// **'Склад'**
  String get enterpriseWarehouseTitle;

  /// No description provided for @enterpriseWarehouseCardTitle.
  ///
  /// In ru, this message translates to:
  /// **'Склад'**
  String get enterpriseWarehouseCardTitle;

  /// No description provided for @enterpriseWarehouseCardSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Контроль запасов материалов, инструментов и оборудования'**
  String get enterpriseWarehouseCardSubtitle;

  /// No description provided for @enterpriseWarehouseCardDescription.
  ///
  /// In ru, this message translates to:
  /// **'Приход, расход и движения отражены как реалистичные корпоративные записи.'**
  String get enterpriseWarehouseCardDescription;

  /// No description provided for @enterpriseWarehouseCurrentLabel.
  ///
  /// In ru, this message translates to:
  /// **'Текущий остаток'**
  String get enterpriseWarehouseCurrentLabel;

  /// No description provided for @enterpriseWarehouseMinimumLabel.
  ///
  /// In ru, this message translates to:
  /// **'Минимум'**
  String get enterpriseWarehouseMinimumLabel;

  /// No description provided for @enterpriseWarehouseIncomingLabel.
  ///
  /// In ru, this message translates to:
  /// **'Приход'**
  String get enterpriseWarehouseIncomingLabel;

  /// No description provided for @enterpriseWarehouseOutgoingLabel.
  ///
  /// In ru, this message translates to:
  /// **'Расход'**
  String get enterpriseWarehouseOutgoingLabel;

  /// No description provided for @enterpriseWarehouseHistoryLabel.
  ///
  /// In ru, this message translates to:
  /// **'История движений доступна'**
  String get enterpriseWarehouseHistoryLabel;

  /// No description provided for @reportsDailyReportLabel.
  ///
  /// In ru, this message translates to:
  /// **'Ежедневный отчет'**
  String get reportsDailyReportLabel;

  /// No description provided for @reportsWeeklyReportLabel.
  ///
  /// In ru, this message translates to:
  /// **'Еженедельный отчет'**
  String get reportsWeeklyReportLabel;

  /// No description provided for @reportsMonthlyReportLabel.
  ///
  /// In ru, this message translates to:
  /// **'Ежемесячный отчет'**
  String get reportsMonthlyReportLabel;

  /// No description provided for @reportsEmployeeReportLabel.
  ///
  /// In ru, this message translates to:
  /// **'Отчет по сотрудникам'**
  String get reportsEmployeeReportLabel;

  /// No description provided for @reportsFinanceReportLabel.
  ///
  /// In ru, this message translates to:
  /// **'Финансовый отчет'**
  String get reportsFinanceReportLabel;

  /// No description provided for @reportsProjectReportLabel.
  ///
  /// In ru, this message translates to:
  /// **'Отчет по проектам'**
  String get reportsProjectReportLabel;

  /// No description provided for @reportsPhotoReportLabel.
  ///
  /// In ru, this message translates to:
  /// **'Фотоотчет'**
  String get reportsPhotoReportLabel;

  /// No description provided for @reportsProgressReportLabel.
  ///
  /// In ru, this message translates to:
  /// **'Отчет по прогрессу'**
  String get reportsProgressReportLabel;

  /// No description provided for @financeDialogAddTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавить финансовую запись'**
  String get financeDialogAddTitle;

  /// No description provided for @financeDialogEditTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать финансовую запись'**
  String get financeDialogEditTitle;

  /// No description provided for @financeTypeExpense.
  ///
  /// In ru, this message translates to:
  /// **'Расход'**
  String get financeTypeExpense;

  /// No description provided for @financeTypeIncome.
  ///
  /// In ru, this message translates to:
  /// **'Доход'**
  String get financeTypeIncome;

  /// No description provided for @financeFieldAmount.
  ///
  /// In ru, this message translates to:
  /// **'Сумма'**
  String get financeFieldAmount;

  /// No description provided for @financeFieldCategory.
  ///
  /// In ru, this message translates to:
  /// **'Категория'**
  String get financeFieldCategory;

  /// No description provided for @financeFieldPaymentMethod.
  ///
  /// In ru, this message translates to:
  /// **'Способ оплаты'**
  String get financeFieldPaymentMethod;

  /// No description provided for @financeFieldReceipt.
  ///
  /// In ru, this message translates to:
  /// **'Документ'**
  String get financeFieldReceipt;

  /// No description provided for @financeAccountEditTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать личный счет'**
  String get financeAccountEditTitle;

  /// No description provided for @financeAddEntryButton.
  ///
  /// In ru, this message translates to:
  /// **'Добавить запись'**
  String get financeAddEntryButton;

  /// No description provided for @financeSectionAccessControl.
  ///
  /// In ru, this message translates to:
  /// **'Доступ и валюта'**
  String get financeSectionAccessControl;

  /// No description provided for @financeActiveUserLabel.
  ///
  /// In ru, this message translates to:
  /// **'Пользователь'**
  String get financeActiveUserLabel;

  /// No description provided for @financePrivacyNote.
  ///
  /// In ru, this message translates to:
  /// **'В локальном режиме отображаются только данные выбранного пользователя.'**
  String get financePrivacyNote;

  /// No description provided for @financeCurrencyLabel.
  ///
  /// In ru, this message translates to:
  /// **'Валюта'**
  String get financeCurrencyLabel;

  /// No description provided for @financeCurrencyKzt.
  ///
  /// In ru, this message translates to:
  /// **'Тенге (KZT)'**
  String get financeCurrencyKzt;

  /// No description provided for @financeCurrencyUsd.
  ///
  /// In ru, this message translates to:
  /// **'Доллар США (USD)'**
  String get financeCurrencyUsd;

  /// No description provided for @financeCurrencyEur.
  ///
  /// In ru, this message translates to:
  /// **'Евро (EUR)'**
  String get financeCurrencyEur;

  /// No description provided for @financeSectionPersonalAccount.
  ///
  /// In ru, this message translates to:
  /// **'Личный финансовый счет'**
  String get financeSectionPersonalAccount;

  /// No description provided for @financeMetricPersonalBalance.
  ///
  /// In ru, this message translates to:
  /// **'Личный баланс'**
  String get financeMetricPersonalBalance;

  /// No description provided for @financeMetricCash.
  ///
  /// In ru, this message translates to:
  /// **'Наличные'**
  String get financeMetricCash;

  /// No description provided for @financeMetricCard.
  ///
  /// In ru, this message translates to:
  /// **'Карта'**
  String get financeMetricCard;

  /// No description provided for @financeMetricWallet.
  ///
  /// In ru, this message translates to:
  /// **'Кошелек'**
  String get financeMetricWallet;

  /// No description provided for @financeMetricRemainingBalance.
  ///
  /// In ru, this message translates to:
  /// **'Остаток'**
  String get financeMetricRemainingBalance;

  /// No description provided for @financeSectionStatistics.
  ///
  /// In ru, this message translates to:
  /// **'Статистика'**
  String get financeSectionStatistics;

  /// No description provided for @financeStatTotalIncome.
  ///
  /// In ru, this message translates to:
  /// **'Общий доход'**
  String get financeStatTotalIncome;

  /// No description provided for @financeStatTotalExpenses.
  ///
  /// In ru, this message translates to:
  /// **'Общие расходы'**
  String get financeStatTotalExpenses;

  /// No description provided for @financeStatMonthlyExpenses.
  ///
  /// In ru, this message translates to:
  /// **'Расходы за месяц'**
  String get financeStatMonthlyExpenses;

  /// No description provided for @financeStatWeeklyExpenses.
  ///
  /// In ru, this message translates to:
  /// **'Расходы за неделю'**
  String get financeStatWeeklyExpenses;

  /// No description provided for @financeSectionSearchFilters.
  ///
  /// In ru, this message translates to:
  /// **'Поиск и фильтры'**
  String get financeSectionSearchFilters;

  /// No description provided for @financeSearchHint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск по описанию, проекту или категории'**
  String get financeSearchHint;

  /// No description provided for @financeFilterCategory.
  ///
  /// In ru, this message translates to:
  /// **'Фильтр по категории'**
  String get financeFilterCategory;

  /// No description provided for @financeFilterPaymentMethod.
  ///
  /// In ru, this message translates to:
  /// **'Фильтр по способу оплаты'**
  String get financeFilterPaymentMethod;

  /// No description provided for @financeFilterProject.
  ///
  /// In ru, this message translates to:
  /// **'Фильтр по проекту'**
  String get financeFilterProject;

  /// No description provided for @financeAllCategories.
  ///
  /// In ru, this message translates to:
  /// **'Все категории'**
  String get financeAllCategories;

  /// No description provided for @financeAllMethods.
  ///
  /// In ru, this message translates to:
  /// **'Все способы'**
  String get financeAllMethods;

  /// No description provided for @financeAllProjects.
  ///
  /// In ru, this message translates to:
  /// **'Все проекты'**
  String get financeAllProjects;

  /// No description provided for @financeExportPlaceholderTitle.
  ///
  /// In ru, this message translates to:
  /// **'Экспорт'**
  String get financeExportPlaceholderTitle;

  /// No description provided for @financeExportPlaceholderSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Экспорт PDF/XLS по выбранному периоду будет доступен после интеграции backend.'**
  String get financeExportPlaceholderSubtitle;

  /// No description provided for @financeNoEntries.
  ///
  /// In ru, this message translates to:
  /// **'Нет записей для выбранных фильтров'**
  String get financeNoEntries;

  /// No description provided for @financeReceiptDefaultValue.
  ///
  /// In ru, this message translates to:
  /// **'Ссылка на документ'**
  String get financeReceiptDefaultValue;

  /// No description provided for @financePaymentCash.
  ///
  /// In ru, this message translates to:
  /// **'Наличные'**
  String get financePaymentCash;

  /// No description provided for @financePaymentCard.
  ///
  /// In ru, this message translates to:
  /// **'Карта'**
  String get financePaymentCard;

  /// No description provided for @financePaymentWallet.
  ///
  /// In ru, this message translates to:
  /// **'Кошелек'**
  String get financePaymentWallet;

  /// No description provided for @financeFoodLabel.
  ///
  /// In ru, this message translates to:
  /// **'Питание'**
  String get financeFoodLabel;

  /// No description provided for @financeAccommodationLabel.
  ///
  /// In ru, this message translates to:
  /// **'Проживание'**
  String get financeAccommodationLabel;

  /// No description provided for @financeToolsLabel.
  ///
  /// In ru, this message translates to:
  /// **'Инструменты'**
  String get financeToolsLabel;

  /// No description provided for @commonCancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get commonSave;

  /// No description provided for @commonAdd.
  ///
  /// In ru, this message translates to:
  /// **'Добавить'**
  String get commonAdd;

  /// No description provided for @commonEdit.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get commonEdit;

  /// No description provided for @commonDelete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get commonDelete;

  /// No description provided for @validationRequired.
  ///
  /// In ru, this message translates to:
  /// **'Это поле обязательно.'**
  String get validationRequired;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'kk':
      return AppLocalizationsKk();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
