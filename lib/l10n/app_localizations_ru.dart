// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Aydin Control Manager';

  @override
  String get navHome => 'Главная';

  @override
  String get navChats => 'Чаты';

  @override
  String get navTasks => 'Задачи';

  @override
  String get navFinance => 'Финансы';

  @override
  String get navProfile => 'Профиль';

  @override
  String get homeTitle => 'Панель управления';

  @override
  String get homeGreeting => 'Добро пожаловать в ACM';

  @override
  String get homeOverviewSubtitle =>
      'Ключевые показатели строительства и прогресс в реальном времени.';

  @override
  String get quickStatisticsTitle => 'Быстрая статистика';

  @override
  String get quickActionsTitle => 'Быстрые действия';

  @override
  String get recentActivityTitle => 'Последняя активность';

  @override
  String get recentActivitySubtitle =>
      'Обновления с площадки и события команды.';

  @override
  String get actionOpenChats => 'Открыть чаты';

  @override
  String get actionViewTasks => 'Открыть задачи';

  @override
  String get actionFinance => 'Финансы';

  @override
  String get actionEmployees => 'Сотрудники';

  @override
  String get actionProjects => 'Проекты';

  @override
  String get actionReports => 'Отчеты';

  @override
  String get actionAdminPanel => 'Панель администратора';

  @override
  String get reportsPlaceholderInfo =>
      'Модуль отчетов будет включен на следующем этапе.';

  @override
  String get statActiveTasks => 'Активные задачи';

  @override
  String get statEmployeesOnline => 'Сотрудники онлайн';

  @override
  String get statUnreadMessages => 'Непрочитанные сообщения';

  @override
  String get statBudgetRemaining => 'Остаток бюджета';

  @override
  String get currentProjectTitle => 'Текущий проект';

  @override
  String currentProjectProgress(String value) {
    return 'Прогресс: $value';
  }

  @override
  String get activityConcreteTitle => 'Заливка бетона завершена';

  @override
  String get activityConcreteDetail =>
      'Башня А, уровень 18 завершен раньше графика.';

  @override
  String get activitySafetyTitle => 'Проверка безопасности отправлена';

  @override
  String get activitySafetyDetail =>
      'Ежедневный EHS-чеклист подтвержден прорабом.';

  @override
  String get activityProcurementTitle => 'Обновление снабжения';

  @override
  String get activityProcurementDetail =>
      'Партия стальных балок №47 в пути на объект.';

  @override
  String get activityClientTitle => 'Получен комментарий заказчика';

  @override
  String get activityClientDetail =>
      'К обсуждению проекта добавлены новые правки планировки.';

  @override
  String get chatsTitle => 'Чаты';

  @override
  String get chatsPlaceholder =>
      'Здесь будут рабочие переписки команды, проектные каналы и вложения по контексту.';

  @override
  String get chatsPrivateTab => 'Личные';

  @override
  String get chatsGroupTab => 'Группы';

  @override
  String get chatsTypingPlaceholder => 'Печатает...';

  @override
  String get chatsVoicePlaceholder => 'Голосовое сообщение';

  @override
  String get chatsVoiceStart => 'Начать запись';

  @override
  String get chatsVoiceStopAndSend => 'Остановить и отправить';

  @override
  String get chatsVoicePlaceholderButton => 'Голос';

  @override
  String get chatsAttachmentPlaceholder =>
      'Загрузка вложений будет доступна в следующей итерации.';

  @override
  String get chatsAttachmentPlaceholderButton => 'Вложить';

  @override
  String get financeTitle => 'Финансы';

  @override
  String get financePlaceholder =>
      'В этот модуль будут добавлены бюджетный контроль, согласования и аналитика затрат.';

  @override
  String get financeHeadline => 'Центр финансового контроля';

  @override
  String get financeSubtitle =>
      'Автоматически отслеживайте личные и проектные расходы, доходы и остаток бюджета.';

  @override
  String get financePersonalExpenses => 'Личные расходы';

  @override
  String get financeProjectExpenses => 'Проектные расходы';

  @override
  String get financeIncome => 'Доход';

  @override
  String get financeRemainingBudget => 'Остаток бюджета';

  @override
  String get financeChartsPlaceholder => 'Графики';

  @override
  String get financeChartsPlaceholderDescription =>
      'Здесь будут графики cashflow, burn-rate и отклонений.';

  @override
  String get financeExpenseHistory => 'История расходов';

  @override
  String get companyTitle => 'Управление компанией';

  @override
  String get companyContacts => 'Контакты компании';

  @override
  String get companyNotFound => 'Компания не найдена';

  @override
  String get documentsTitle => 'Документы';

  @override
  String get documentsHeadline => 'Управление документами';

  @override
  String get documentsSubtitle =>
      'Организуйте папки, категории и последние файлы проекта.';

  @override
  String get documentsFolders => 'Папки';

  @override
  String get documentsRecent => 'Последние документы';

  @override
  String get documentsPdfPlaceholder => 'Предпросмотр PDF';

  @override
  String get documentsDwgPlaceholder => 'Предпросмотр DWG';

  @override
  String get documentsExcelPlaceholder => 'Предпросмотр Excel';

  @override
  String get documentsOpenPlaceholder =>
      'Открытие документов будет доступно после подключения backend.';

  @override
  String get photoReportsTitle => 'Фотоотчеты';

  @override
  String get photoReportsHeadline => 'Фотоотчеты с объекта';

  @override
  String get photoReportsSubtitle =>
      'Отслеживайте альбомы с фото до/после по сотрудникам и проектам.';

  @override
  String get photoReportsDate => 'Дата';

  @override
  String get notificationsTitle => 'Уведомления';

  @override
  String get notificationsCenter => 'Центр уведомлений';

  @override
  String get notificationsSubtitle =>
      'Напоминания по задачам, обновления проектов и финансовые алерты в одном месте.';

  @override
  String get notificationsTaskReminders => 'Напоминание по задаче';

  @override
  String get notificationsProjectUpdates => 'Обновление проекта';

  @override
  String get notificationsFinanceAlerts => 'Финансовый алерт';

  @override
  String get notificationsEmployeeAlerts => 'Алерт по сотрудникам';

  @override
  String get notificationsSystemAlerts => 'Системное уведомление';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get profileHeadline => 'Настройки профиля';

  @override
  String get profileDescription =>
      'Управляйте личными параметрами и языком интерфейса.';

  @override
  String get profileManagerName => 'Aruzhan Tolegen';

  @override
  String get languageSectionTitle => 'Язык приложения';

  @override
  String get languageSectionSubtitle =>
      'Выберите язык. Изменения применяются сразу.';

  @override
  String get languageSelectLabel => 'Язык';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageKazakh => 'Казахский';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get splashTagline => 'Корпоративное управление строительством';

  @override
  String get loginWelcomeBack => 'С возвращением';

  @override
  String get loginSubtitle => 'Войдите, чтобы продолжить работу в ACM.';

  @override
  String get loginSideTitle => 'Единый центр управления стройкой';

  @override
  String get loginSideSubtitle =>
      'Планируйте проекты, координируйте команды и контролируйте бюджет в одном месте.';

  @override
  String get commonEmail => 'Email';

  @override
  String get commonPhone => 'Телефон';

  @override
  String get commonPassword => 'Пароль';

  @override
  String get loginRememberMe => 'Запомнить меня';

  @override
  String get loginForgotPassword => 'Забыли пароль?';

  @override
  String get loginForgotPasswordInfo =>
      'Восстановление пароля будет доступно в следующем релизе.';

  @override
  String get loginRoleLabel => 'Роль';

  @override
  String get loginButton => 'Войти';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsHeadline => 'Настройки приложения';

  @override
  String get settingsSubtitle =>
      'Управляйте внешним видом, языком, уведомлениями и безопасностью.';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsThemeLight => 'Светлая';

  @override
  String get settingsThemeDark => 'Темная';

  @override
  String get settingsThemeSystem => 'Системная';

  @override
  String get settingsNotifications => 'Уведомления';

  @override
  String get settingsNotificationsSubtitle =>
      'Разрешить напоминания по задачам, обновлениям проектов и финансовым алертам.';

  @override
  String get settingsSecurity => 'Безопасность';

  @override
  String get settingsSecuritySubtitle =>
      'Требовать локальную проверку безопасности для чувствительных действий.';

  @override
  String get employeesTitle => 'Сотрудники';

  @override
  String get employeesHeadline => 'Управление сотрудниками';

  @override
  String get employeesSubtitle =>
      'Контролируйте доступность команды, роли и назначения по проектам.';

  @override
  String get employeesNoResults =>
      'По выбранным условиям сотрудники не найдены';

  @override
  String get employeesSearchHint =>
      'Поиск сотрудников по имени, телефону или проекту';

  @override
  String get employeeDetailsTitle => 'Данные сотрудника';

  @override
  String get employeeNotFound => 'Сотрудник не найден';

  @override
  String employeeContactReady(String name) {
    return 'Действие связи для $name готово.';
  }

  @override
  String get employeeTaskSummaryTitle => 'Сводка по задачам';

  @override
  String get employeeAssignedTasks => 'Назначенные задачи';

  @override
  String get employeeCompletedTasks => 'Выполненные задачи';

  @override
  String get employeePersonalNotes => 'Личные заметки';

  @override
  String get statusOnline => 'Онлайн';

  @override
  String get statusOffline => 'Оффлайн';

  @override
  String get filterRoleLabel => 'Роль';

  @override
  String get filterAllRoles => 'Все роли';

  @override
  String get filterSortByLabel => 'Сортировка';

  @override
  String get sortOnlineFirst => 'Сначала онлайн';

  @override
  String get sortAlphabetically => 'По алфавиту';

  @override
  String get sortByPosition => 'По должности';

  @override
  String get roleDirector => 'Директор';

  @override
  String get roleProjectManager => 'Менеджер проекта';

  @override
  String get roleSiteEngineer => 'Инженер участка';

  @override
  String get roleForeman => 'Прораб';

  @override
  String get roleSurveyor => 'Геодезист';

  @override
  String get roleSafetyEngineer => 'Инженер по безопасности';

  @override
  String get roleAccountant => 'Бухгалтер';

  @override
  String get roleStorekeeper => 'Кладовщик';

  @override
  String get roleWorker => 'Рабочий';

  @override
  String get projectsTitle => 'Проекты';

  @override
  String get projectsHeadline => 'Строительные проекты';

  @override
  String get projectsSubtitle =>
      'Отслеживайте состояние проекта, бюджет, сроки и прогресс на площадке.';

  @override
  String get projectDetailsTitle => 'Детали проекта';

  @override
  String get projectNotFound => 'Проект не найден';

  @override
  String get newProjectTitle => 'Новый проект';

  @override
  String get newProjectHeadline => 'Создание проекта';

  @override
  String get newProjectSubtitle =>
      'Задайте объем, сроки и бюджет для запуска рабочего пространства проекта.';

  @override
  String get projectFieldName => 'Название проекта';

  @override
  String get projectFieldClient => 'Заказчик';

  @override
  String get projectFieldAddress => 'Адрес';

  @override
  String get projectCreateButton => 'Создать проект';

  @override
  String get projectSelectDatesError => 'Выберите даты начала и завершения.';

  @override
  String get projectEndDateError =>
      'Дата завершения должна быть позже даты начала.';

  @override
  String get projectBudgetValidationError =>
      'Введите корректную сумму бюджета.';

  @override
  String get projectCreatedLocalInfo =>
      'Черновик проекта создан локально (mock-поток).';

  @override
  String get projectInformationTitle => 'Информация о проекте';

  @override
  String get projectProgressStageTitle => 'Прогресс и текущий этап';

  @override
  String projectCompletedValue(String value) {
    return 'Выполнено: $value';
  }

  @override
  String get projectCurrentStage => 'Текущий этап';

  @override
  String get projectWeatherActivityTitle => 'Погода и последняя активность';

  @override
  String get projectStatusPlanning => 'Планирование';

  @override
  String get projectStatusOnTrack => 'По плану';

  @override
  String get projectStatusAtRisk => 'Под риском';

  @override
  String get projectStatusDelayed => 'С задержкой';

  @override
  String get projectStatusCompleted => 'Завершен';

  @override
  String get tabOverview => 'Обзор';

  @override
  String get tabTasks => 'Задачи';

  @override
  String get tabEmployees => 'Сотрудники';

  @override
  String get tabDocuments => 'Документы';

  @override
  String get tabPhotos => 'Фото';

  @override
  String get tabFinance => 'Финансы';

  @override
  String get projectTabTasksPlaceholder =>
      'План задач, зависимости и ключевые этапы проекта.';

  @override
  String get projectTabEmployeesPlaceholder =>
      'Назначенная команда и распределение ресурсов по объекту.';

  @override
  String get projectTabDocumentsPlaceholder =>
      'Договоры, разрешения и проектные файлы по объекту.';

  @override
  String get projectTabPhotosPlaceholder => 'Лента фото прогресса с площадки.';

  @override
  String get projectTabFinancePlaceholder =>
      'Контроль затрат, счета и графики оплат по проекту.';

  @override
  String get tasksTitle => 'Задачи';

  @override
  String get tasksHeadline => 'Управление задачами';

  @override
  String get tasksSubtitle =>
      'Планируйте, назначайте и контролируйте выполнение строительных задач.';

  @override
  String get tasksNoResults => 'По выбранным фильтрам задачи не найдены';

  @override
  String get newTaskTitle => 'Новая задача';

  @override
  String get newTaskHeadline => 'Создание задачи';

  @override
  String get newTaskSubtitle =>
      'Задайте объем, ответственного, стоимость и сроки.';

  @override
  String get taskAssignEmployee => 'Назначить сотрудника';

  @override
  String get taskEstimatedCost => 'Оценочная стоимость';

  @override
  String get taskCreateButton => 'Создать задачу';

  @override
  String get taskSelectDatesError => 'Выберите дату начала и дедлайн.';

  @override
  String get taskDeadlineAfterStartError =>
      'Дедлайн должен быть позже даты начала.';

  @override
  String get taskCostValidationError => 'Введите корректную стоимость.';

  @override
  String get taskCreatedLocalInfo => 'Задача создана локально (mock-поток).';

  @override
  String get taskAttachPhotos => 'Прикрепить фото';

  @override
  String get taskAttachPhotosPlaceholder =>
      'Откройте фотоотчеты для добавления снимков по задаче.';

  @override
  String get taskAttachDocuments => 'Прикрепить документы';

  @override
  String get taskAttachDocumentsPlaceholder =>
      'Перейдите в документы, чтобы добавить чертежи и файлы.';

  @override
  String get taskAttachButton => 'Прикрепить';

  @override
  String taskAttachmentInfoAction(String title) {
    return 'Раздел $title открыт локально.';
  }

  @override
  String get taskDetailsTitle => 'Детали задачи';

  @override
  String get taskNotFound => 'Задача не найдена';

  @override
  String taskDeadlineValue(String date) {
    return 'Дедлайн: $date';
  }

  @override
  String get taskFullDescription => 'Полное описание';

  @override
  String get taskAssignedEmployees => 'Назначенные сотрудники';

  @override
  String get taskComments => 'Комментарии';

  @override
  String get taskActivityHistory => 'История активности';

  @override
  String get taskBeforePhotos => 'Фото до';

  @override
  String get taskAfterPhotos => 'Фото после';

  @override
  String get taskChangeStatus => 'Изменить статус';

  @override
  String taskStatusChangedLocal(String status) {
    return 'Статус изменен на $status (локальный mock).';
  }

  @override
  String get taskPriorityLow => 'Низкий';

  @override
  String get taskPriorityMedium => 'Средний';

  @override
  String get taskPriorityHigh => 'Высокий';

  @override
  String get taskPriorityCritical => 'Критический';

  @override
  String get taskStatusNotStarted => 'Не начата';

  @override
  String get taskStatusInProgress => 'В работе';

  @override
  String get taskStatusWaiting => 'Ожидание';

  @override
  String get taskStatusCompleted => 'Завершена';

  @override
  String get filterAllProjects => 'Все проекты';

  @override
  String get filterAllEmployees => 'Все сотрудники';

  @override
  String get filterAllStatuses => 'Все статусы';

  @override
  String get filterAllPriorities => 'Все приоритеты';

  @override
  String get filterSortLabel => 'Сортировка';

  @override
  String get sortRecentlyUpdated => 'Недавно обновленные';

  @override
  String get commonTitle => 'Название';

  @override
  String get commonDescription => 'Описание';

  @override
  String get commonProject => 'Проект';

  @override
  String get commonEmployee => 'Сотрудник';

  @override
  String get commonStatus => 'Статус';

  @override
  String get commonPriority => 'Приоритет';

  @override
  String get commonDeadline => 'Дедлайн';

  @override
  String get commonStartDate => 'Дата начала';

  @override
  String get commonEndDate => 'Дата окончания';

  @override
  String get commonSelectDate => 'Выберите дату';

  @override
  String get commonBudget => 'Бюджет';

  @override
  String get commonEmployees => 'Сотрудники';

  @override
  String get commonRemainingBudget => 'Остаток бюджета';

  @override
  String get commonTimeline => 'Сроки';

  @override
  String get commonWeather => 'Погода';

  @override
  String get commonLastActivity => 'Последняя активность';

  @override
  String get commonRecentUpdates => 'Последние обновления';

  @override
  String get commonContact => 'Связаться';

  @override
  String get commonProgress => 'Прогресс';

  @override
  String commonProgressValue(String value) {
    return 'Прогресс: $value';
  }

  @override
  String get commonNoItemsYet => 'Пока нет данных.';

  @override
  String taskEstimatedCostValue(String cost) {
    return 'Оценочная стоимость: $cost';
  }

  @override
  String get chatsSearchLabel => 'Поиск чатов и пользователей';

  @override
  String get chatsNoResults => 'Чаты не найдены';

  @override
  String get chatsEmojiPlaceholder => 'Смайлики и стикеры';

  @override
  String get chatsImagePlaceholder =>
      'Отправка изображений будет доступна в следующей итерации.';

  @override
  String get chatsCreateDirectPlaceholder =>
      'Создание личного чата будет доступно в следующей итерации.';

  @override
  String get chatCreateDirectTitle => 'Личный чат';

  @override
  String get chatCreateGroupTitle => 'Создать группу';

  @override
  String get chatCreateGroupButton => 'Новая группа';

  @override
  String get chatGroupCreatedPlaceholder =>
      'Группа создана в локальном mock-режиме.';

  @override
  String get chatGroupNameLabel => 'Название группы';

  @override
  String get chatSearchUsersLabel => 'Поиск участников';

  @override
  String get chatAddMembersTitle => 'Добавить участников';

  @override
  String get chatAddMember => 'Добавить';

  @override
  String get chatRemoveMember => 'Удалить';

  @override
  String get chatGroupAdmin => 'Администратор группы';

  @override
  String get chatInfoTitle => 'Информация о чате';

  @override
  String get chatMessageInputPlaceholder => 'Введите сообщение';

  @override
  String get chatSharedMediaPlaceholder => 'Общие медиа';

  @override
  String get chatSharedMediaDescription =>
      'Фото и файлы появятся после интеграции backend.';

  @override
  String get chatReactionsPlaceholder => 'Реакции и ответы';

  @override
  String get chatReactionsDescription =>
      'Сводка реакций будет доступна в следующем спринте.';

  @override
  String get chatPin => 'Закрепить чат';

  @override
  String get chatUnpin => 'Открепить чат';

  @override
  String get chatArchive => 'Архивировать чат';

  @override
  String get chatUnarchive => 'Разархивировать чат';

  @override
  String get chatMuteNotifications => 'Отключить уведомления';

  @override
  String get chatUnmute => 'Включить уведомления';

  @override
  String get chatDelete => 'Удалить чат';

  @override
  String get chatDeletePlaceholder =>
      'Удаление чата потребует подтверждения на backend.';

  @override
  String get chatMarkRead => 'Отметить как прочитанный';

  @override
  String get chatNotFound => 'Чат не найден';

  @override
  String get chatMembersTitle => 'Участники';

  @override
  String chatMembersCount(int count) {
    return 'Участники: $count';
  }

  @override
  String chatLastSeen(String value) {
    return 'Был(а) в сети: $value';
  }

  @override
  String get chatShowArchived => 'Показать архив';

  @override
  String get chatHideArchived => 'Скрыть архив';

  @override
  String get commonBackToChat => 'Назад в чат';

  @override
  String get settingsGeneralSection => 'Общие';

  @override
  String get settingsAppearanceSection => 'Внешний вид';

  @override
  String get settingsNotificationsSection => 'Уведомления';

  @override
  String get settingsSecuritySection => 'Безопасность';

  @override
  String get settingsApplicationSection => 'Приложение';

  @override
  String get settingsSupportSection => 'Поддержка';

  @override
  String get settingsDateFormat => 'Формат даты';

  @override
  String get settingsTimeFormat => 'Формат времени';

  @override
  String get settingsDateFormatDmy => 'DD.MM.YYYY';

  @override
  String get settingsDateFormatMdy => 'MM/DD/YYYY';

  @override
  String get settingsDateFormatYmd => 'YYYY-MM-DD';

  @override
  String get settingsTimeFormat24 => '24-часовой';

  @override
  String get settingsTimeFormat12 => '12-часовой';

  @override
  String get settingsPushNotifications => 'Push-уведомления';

  @override
  String get settingsChatNotifications => 'Уведомления чатов';

  @override
  String get settingsTaskNotifications => 'Уведомления задач';

  @override
  String get settingsFinanceNotifications => 'Финансовые уведомления';

  @override
  String get settingsPinCode => 'PIN-код';

  @override
  String get settingsBiometric => 'Биометрия';

  @override
  String get settingsAutoLock => 'Автоблокировка';

  @override
  String get settingsChangePassword => 'Сменить пароль';

  @override
  String get settingsSecurityPlaceholder =>
      'Смена пароля будет доступна после интеграции сервиса идентификации.';

  @override
  String get settingsCache => 'Очистить кэш';

  @override
  String get settingsStorage => 'Использование хранилища';

  @override
  String get settingsPrivacyMode => 'Режим приватности';

  @override
  String get settingsPrivacyModeSubtitle =>
      'Скрывать чувствительные значения в списках и карточках.';

  @override
  String get settingsAnalytics => 'Анонимная аналитика';

  @override
  String get settingsAnalyticsSubtitle =>
      'Помогать улучшать продукт с помощью анонимной телеметрии.';

  @override
  String get settingsAccessibilityHighContrast => 'Высокая контрастность';

  @override
  String get settingsAccessibilityReduceMotion => 'Уменьшить анимацию';

  @override
  String get settingsDataSaver => 'Экономия трафика';

  @override
  String get settingsBackup => 'Резервное копирование';

  @override
  String get settingsBackupPlaceholder =>
      'Резервное копирование и восстановление будут добавлены позже.';

  @override
  String get settingsExportData => 'Экспорт данных';

  @override
  String get settingsAboutApp => 'О приложении';

  @override
  String get settingsPrivacyPolicy => 'Политика конфиденциальности';

  @override
  String get settingsTerms => 'Условия использования';

  @override
  String get settingsHelpCenter => 'Центр помощи';

  @override
  String get settingsContactSupport => 'Связаться с поддержкой';

  @override
  String get settingsSendFeedback => 'Отправить отзыв';

  @override
  String get settingsActionPlaceholder =>
      'Действие будет доступно на следующем этапе интеграции.';

  @override
  String get profileRoleLabel => 'Роль';

  @override
  String get profilePositionLabel => 'Должность';

  @override
  String get profileDepartmentLabel => 'Отдел';

  @override
  String get profileCompanyLabel => 'Компания';

  @override
  String get profileCoverPlaceholder => 'Заглушка обложки профиля';

  @override
  String get profileStatsTitle => 'Статистика';

  @override
  String get profileAchievementsTitle => 'Достижения';

  @override
  String get profileAchievementsPlaceholder => 'Заглушка витрины достижений.';

  @override
  String get profileRecentActivityTitle => 'Последняя активность';

  @override
  String get profileRecentActivityPlaceholder =>
      'Заглушка последней активности профиля.';

  @override
  String get profileNotificationStatus => 'Статус уведомлений';

  @override
  String get profileSecurityStatus => 'Статус безопасности';

  @override
  String get profileAboutTitle => 'О приложении';

  @override
  String get profileVersionTitle => 'Версия';

  @override
  String get profileVersionValue => '1.0.0-enterprise';

  @override
  String get profileNotificationEnabled => 'Включено';

  @override
  String get profileNotificationDisabled => 'Выключено';

  @override
  String get profileSecurityEnabled => 'Локальная защита включена';

  @override
  String get profileSecurityDisabled => 'Локальная защита выключена';

  @override
  String get profileAboutDescription =>
      'ACM объединяет управление проектами, задачами, коммуникацией и финансами для строительных команд.';

  @override
  String get statProjects => 'Проекты';

  @override
  String get statEmployees => 'Сотрудники';

  @override
  String get statTasksToday => 'Задачи на сегодня';

  @override
  String get statCompletedTasks => 'Выполненные задачи';

  @override
  String get statPendingTasks => 'Ожидающие задачи';

  @override
  String get statOverdueTasks => 'Просроченные задачи';

  @override
  String get statProjectProgress => 'Прогресс проекта';

  @override
  String get statExpenses => 'Расходы';

  @override
  String get statIncome => 'Доход';

  @override
  String get statMonthlyExpenses => 'Расходы за месяц';

  @override
  String get statMonthlyIncome => 'Доход за месяц';

  @override
  String get tabChat => 'Чат';

  @override
  String get tabReports => 'Отчеты';

  @override
  String get projectTabChatPlaceholder =>
      'Лента проектной коммуникации и обсуждений.';

  @override
  String get projectTabReportsPlaceholder =>
      'Проектные отчеты, инспекции и сводки для руководства.';

  @override
  String get taskStatusInspection => 'Инспекция';

  @override
  String get tasksListMode => 'Список';

  @override
  String get tasksKanbanMode => 'Kanban';

  @override
  String get kanbanDropTasksHere => 'Перетащите задачу сюда';

  @override
  String get kanbanReleaseToMove => 'Отпустите, чтобы переместить задачу';

  @override
  String get kanbanPlanned => 'Запланировано';

  @override
  String get kanbanInProgress => 'В работе';

  @override
  String get kanbanWaiting => 'Ожидание';

  @override
  String get kanbanInspection => 'Инспекция';

  @override
  String get kanbanCompleted => 'Завершено';

  @override
  String get reportsModuleTitle => 'Строительные отчеты';

  @override
  String get reportsModuleHeadline => 'Центр проектной отчетности';

  @override
  String get reportsModuleSubtitle =>
      'Контролируйте эффективность, качество, безопасность и бюджет в одном окне.';

  @override
  String get reportsWeeklyProgress => 'Еженедельный прогресс';

  @override
  String get reportsSafetyChecks => 'Проверки безопасности';

  @override
  String get reportsBudgetDeviation => 'Отклонение бюджета';

  @override
  String get reportsQualityScore => 'Оценка качества';

  @override
  String get reportsChartsPlaceholderTitle => 'Сводка по графикам';

  @override
  String get reportsChartsPlaceholderSubtitle =>
      'S-кривая, производительность и тренды качества по проектам.';

  @override
  String get reportsExportPlaceholderTitle => 'Экспорт отчетов';

  @override
  String get reportsExportPlaceholderSubtitle =>
      'PDF/XLS экспорт выбранного диапазона и проекта.';

  @override
  String get globalSearchTitle => 'Глобальный поиск';

  @override
  String get globalSearchHint =>
      'Поиск по проектам, сотрудникам, задачам, чатам и документам';

  @override
  String get globalSearchStartTyping => 'Начните ввод для поиска';

  @override
  String get globalSearchNoResults => 'Ничего не найдено';

  @override
  String globalSearchPhotosCount(int count) {
    return 'Фото: $count';
  }

  @override
  String get dashboardWidgetsTitle => 'Операционные виджеты';

  @override
  String get dashboardWeatherTitle => 'Текущая погода';

  @override
  String get dashboardWeatherPlaceholder => 'Заглушка погоды';

  @override
  String get dashboardTodayTasksTitle => 'Задачи на сегодня';

  @override
  String get dashboardRecentMessagesTitle => 'Последние сообщения';

  @override
  String get dashboardRecentExpensesTitle => 'Последние расходы';

  @override
  String get dashboardProjectProgressTitle => 'Прогресс проекта';

  @override
  String get dashboardEmployeesOnlineTitle => 'Сотрудники онлайн';

  @override
  String get dashboardChartsPlaceholderTitle => 'Графики';

  @override
  String get dashboardChartsPlaceholderSubtitle =>
      'Заглушка графиков S-кривой и прогресса';

  @override
  String get dashboardQuickActionsHint => 'Быстрый переход к ключевым модулям';

  @override
  String get photoReportsCreateAlbum => 'Создать альбом';

  @override
  String get photoReportsDescriptionPlaceholder =>
      'Заглушка описания фотоотчета';

  @override
  String get photoReportsLocationPlaceholder => 'Заглушка локации';

  @override
  String get photoReportsAddPhotoPlaceholder =>
      'Добавление фото на этом этапе работает в режиме заглушки.';

  @override
  String get photoReportsTaskLabel => 'Задача';

  @override
  String get photoReportsTimeLabel => 'Время';

  @override
  String get photoReportsLocationLabel => 'Локация';

  @override
  String get photoReportsAddBefore => 'Добавить до';

  @override
  String get photoReportsAddAfter => 'Добавить после';

  @override
  String get photoReportsDeleteBefore => 'Удалить до';

  @override
  String get photoReportsDeleteAfter => 'Удалить после';

  @override
  String get photoReportsPreviewTitle => 'Предпросмотр фото';

  @override
  String get documentsCategoryLabel => 'Категория';

  @override
  String get documentsDateLabel => 'Дата';

  @override
  String get documentsAuthorLabel => 'Автор';

  @override
  String get documentsSizeLabel => 'Размер';

  @override
  String get documentsVersionLabel => 'Версия';

  @override
  String get financeExpensesLabel => 'Расходы';

  @override
  String get financeNetLabel => 'Чистый результат';

  @override
  String get financeCategoriesTitle => 'Структура по категориям';

  @override
  String get financeMonthlySummaryTitle => 'Итоги месяца';

  @override
  String get financeFuelLabel => 'Топливо';

  @override
  String get financeEquipmentLabel => 'Оборудование';

  @override
  String get financeMaterialsLabel => 'Материалы';

  @override
  String get financeWorkersLabel => 'Рабочие';

  @override
  String get financeTransportLabel => 'Транспорт';

  @override
  String get financeOtherLabel => 'Другое';

  @override
  String get employeeAssignedProjectsTitle => 'Назначенные проекты';

  @override
  String get employeeAssignedTasksTitle => 'Назначенные задачи';

  @override
  String get employeeCompletedTasksTitle => 'Выполненные задачи';

  @override
  String get employeePerformanceTitle => 'Производительность';

  @override
  String get employeeAttendancePlaceholderTitle => 'Активные задачи';

  @override
  String get employeeAttendancePlaceholderSubtitle =>
      'Текущая рабочая загрузка по сотруднику.';

  @override
  String get employeeWorkingHoursPlaceholderTitle => 'Рабочие часы';

  @override
  String get employeeWorkingHoursPlaceholderSubtitle =>
      'Заглушка интеграции учета рабочего времени.';

  @override
  String get adminTitle => 'Администрирование';

  @override
  String get adminTabOverview => 'Обзор';

  @override
  String get adminTabCompany => 'Компания';

  @override
  String get adminTabRbac => 'RBAC';

  @override
  String get adminTabManagement => 'Управление';

  @override
  String get adminTabActivity => 'Активность';

  @override
  String get adminOverviewHeadline => 'Корпоративная админ-панель';

  @override
  String get adminOverviewSubtitle =>
      'Управляйте компаниями, ролями, проектами, отделами и контролем соответствия.';

  @override
  String get adminDepartmentsTitle => 'Отделы';

  @override
  String get adminTeamsTitle => 'Команды';

  @override
  String get adminRolesTitle => 'Роли';

  @override
  String get adminOrganizationStructure => 'Оргструктура';

  @override
  String get adminCompanySettingsTitle => 'Настройки компании';

  @override
  String get adminCompanyLogo => 'Логотип компании';

  @override
  String get adminCompanyName => 'Название компании';

  @override
  String get adminCompanyBin => 'BIN';

  @override
  String get adminCompanyWebsite => 'Веб-сайт';

  @override
  String get adminCompanyWorkingHours => 'Рабочие часы';

  @override
  String get adminCompanyTimezone => 'Часовой пояс';

  @override
  String get adminCompanyCurrency => 'Валюта';

  @override
  String get adminCompanyMeasurement => 'Система измерений';

  @override
  String get adminSuspendCompany => 'Приостановить компанию';

  @override
  String get adminSuspendCompanySubtitle =>
      'Временно ограничить все операции компании.';

  @override
  String get adminCreateCompany => 'Создать компанию';

  @override
  String get adminEditCompany => 'Изменить компанию';

  @override
  String get adminDeleteCompany => 'Удалить компанию';

  @override
  String get adminActionCompanyCreated => 'Компания создана (mock).';

  @override
  String get adminActionCompanyUpdated => 'Компания обновлена (mock).';

  @override
  String get adminActionCompanyDeleted => 'Компания удалена (mock).';

  @override
  String get adminRbacTitle => 'Ролевой доступ';

  @override
  String get adminRbacSubtitle =>
      'Настройте права для каждой корпоративной роли.';

  @override
  String get adminResetPermissions => 'Сбросить права';

  @override
  String get adminSavePermissions => 'Сохранить права';

  @override
  String get adminActionRoleReset => 'Права роли сброшены к шаблону.';

  @override
  String get adminActionRoleSaved => 'Права роли сохранены (mock).';

  @override
  String get adminCreateProjects => 'Создать проекты';

  @override
  String get adminCreateProjectsSubtitle =>
      'Создавайте и запускайте новые рабочие пространства проектов.';

  @override
  String get adminArchiveProjects => 'Архивировать проекты';

  @override
  String get adminArchiveProjectsSubtitle =>
      'Переносите завершенные проекты в архив.';

  @override
  String get adminActionProjectCreated => 'Проект создан (mock).';

  @override
  String get adminManagementModules => 'Управляющие модули';

  @override
  String get adminOpen => 'Открыть';

  @override
  String get adminActionOpened => 'открыто';

  @override
  String get adminActivityTitle => 'История активности';

  @override
  String get adminActivitySubtitle =>
      'Отслеживайте все критичные операции в корпоративных модулях.';

  @override
  String get adminRoleOwner => 'Владелец';

  @override
  String get adminRoleAdministrator => 'Администратор';

  @override
  String get adminRoleViewer => 'Наблюдатель';

  @override
  String get adminPermissionViewProjects => 'Может просматривать проекты';

  @override
  String get adminPermissionEditProjects => 'Может редактировать проекты';

  @override
  String get adminPermissionDeleteProjects => 'Может удалять проекты';

  @override
  String get adminPermissionCreateTasks => 'Может создавать задачи';

  @override
  String get adminPermissionCompleteTasks => 'Может завершать задачи';

  @override
  String get adminPermissionViewFinance => 'Может просматривать финансы';

  @override
  String get adminPermissionEditFinance => 'Может редактировать финансы';

  @override
  String get adminPermissionUploadDocuments => 'Может загружать документы';

  @override
  String get adminPermissionDeleteDocuments => 'Может удалять документы';

  @override
  String get adminPermissionManageEmployees => 'Может управлять сотрудниками';

  @override
  String get adminPermissionManageChats => 'Может управлять чатами';

  @override
  String get adminPermissionManageReports => 'Может управлять отчетами';

  @override
  String get adminPermissionManageSettings => 'Может управлять настройками';

  @override
  String get homeSummarySection => 'Сводка';

  @override
  String get tasksTabAll => 'Все';

  @override
  String get tasksTabMine => 'Мои';

  @override
  String get tasksTabInProgress => 'В работе';

  @override
  String get tasksTabCompleted => 'Готово';

  @override
  String get tasksTabKanban => 'Канбан';

  @override
  String get tasksFiltersTitle => 'Фильтры';

  @override
  String get chatGroupAvatarTitle => 'Аватар группы';

  @override
  String get chatGroupAvatarSubtitle =>
      'Выбор аватара будет подключен после интеграции хранилища медиа.';

  @override
  String get chatLeaveGroup => 'Покинуть группу';

  @override
  String get chatAvatarActionPlaceholder =>
      'Действие с аватаром будет доступно в подключенном режиме.';

  @override
  String get chatChangeAvatar => 'Изменить';

  @override
  String get profilePositionValue => 'Старший менеджер проекта';

  @override
  String get profileDepartmentValue => 'Проектный офис';

  @override
  String get profileCompanyValue => 'ACM Control Center';

  @override
  String get profilePhoneValue => '+7 777 450 22 11';

  @override
  String get profileEmailValue => 'manager@structra-group.com';

  @override
  String get enterpriseCalendarTitle => 'Календарь';

  @override
  String get enterpriseCalendarViewDaily => 'День';

  @override
  String get enterpriseCalendarViewWeekly => 'Неделя';

  @override
  String get enterpriseCalendarViewMonthly => 'Месяц';

  @override
  String get enterpriseCalendarCardTitle => 'Корпоративный календарь';

  @override
  String get enterpriseCalendarCardSubtitle =>
      'Графики задач, проектов и сотрудников';

  @override
  String get enterpriseCalendarCardDescription =>
      'Встречи и смены отображаются как реальные события строительного графика.';

  @override
  String get enterpriseDrawingsTitle => 'Чертежи';

  @override
  String get enterpriseDrawingsCardTitle => 'Модуль чертежей';

  @override
  String get enterpriseDrawingsCardSubtitle =>
      'DWG, PDF, blueprints, 3D-модели и спецификации';

  @override
  String get enterpriseDrawingsCardDescription =>
      'Реестр чертежей с контролем версий, ревизий и согласований.';

  @override
  String get enterpriseDrawingsAuthorLabel => 'Автор';

  @override
  String get enterpriseDrawingsActionsLabel =>
      'Предпросмотр доступен • Загрузка доступна • Комментарии и история ревизий';

  @override
  String get enterpriseEquipmentTitle => 'Оборудование';

  @override
  String get enterpriseEquipmentCardTitle => 'Управление оборудованием';

  @override
  String get enterpriseEquipmentCardSubtitle =>
      'Статус, назначение и цикл обслуживания';

  @override
  String get enterpriseEquipmentCardDescription =>
      'Для каждой единицы ведется учет топлива и состояние инспекций.';

  @override
  String get enterpriseEquipmentSerialLabel => 'Серийный номер';

  @override
  String get enterpriseEquipmentMaintenanceLabel => 'Обслуживание';

  @override
  String get enterpriseEquipmentFuelLabel => 'Расход топлива отслеживается';

  @override
  String get enterpriseEquipmentInspectionLabel => 'Инспекция запланирована';

  @override
  String get enterpriseVehiclesTitle => 'Транспорт';

  @override
  String get enterpriseVehiclesCardTitle => 'Управление автопарком';

  @override
  String get enterpriseVehiclesCardSubtitle =>
      'Операции флота и контроль сервиса';

  @override
  String get enterpriseVehiclesCardDescription =>
      'Записи автопарка включают маршрутный статус, сервис и документы.';

  @override
  String get enterpriseVehiclesDriverLabel => 'Водитель';

  @override
  String get enterpriseVehiclesMileageLabel => 'Пробег';

  @override
  String get enterpriseVehiclesFuelLabel => 'Топливо';

  @override
  String get enterpriseVehiclesMaintenanceLabel => 'Обслуживание';

  @override
  String get enterpriseVehiclesDocumentsLabel => 'Документы актуальны';

  @override
  String get enterpriseWarehouseTitle => 'Склад';

  @override
  String get enterpriseWarehouseCardTitle => 'Склад';

  @override
  String get enterpriseWarehouseCardSubtitle =>
      'Контроль запасов материалов, инструментов и оборудования';

  @override
  String get enterpriseWarehouseCardDescription =>
      'Приход, расход и движения отражены как реалистичные корпоративные записи.';

  @override
  String get enterpriseWarehouseCurrentLabel => 'Текущий остаток';

  @override
  String get enterpriseWarehouseMinimumLabel => 'Минимум';

  @override
  String get enterpriseWarehouseIncomingLabel => 'Приход';

  @override
  String get enterpriseWarehouseOutgoingLabel => 'Расход';

  @override
  String get enterpriseWarehouseHistoryLabel => 'История движений доступна';

  @override
  String get reportsDailyReportLabel => 'Ежедневный отчет';

  @override
  String get reportsWeeklyReportLabel => 'Еженедельный отчет';

  @override
  String get reportsMonthlyReportLabel => 'Ежемесячный отчет';

  @override
  String get reportsEmployeeReportLabel => 'Отчет по сотрудникам';

  @override
  String get reportsFinanceReportLabel => 'Финансовый отчет';

  @override
  String get reportsProjectReportLabel => 'Отчет по проектам';

  @override
  String get reportsPhotoReportLabel => 'Фотоотчет';

  @override
  String get reportsProgressReportLabel => 'Отчет по прогрессу';

  @override
  String get financeDialogAddTitle => 'Добавить финансовую запись';

  @override
  String get financeDialogEditTitle => 'Редактировать финансовую запись';

  @override
  String get financeTypeExpense => 'Расход';

  @override
  String get financeTypeIncome => 'Доход';

  @override
  String get financeFieldAmount => 'Сумма';

  @override
  String get financeFieldCategory => 'Категория';

  @override
  String get financeFieldPaymentMethod => 'Способ оплаты';

  @override
  String get financeFieldReceipt => 'Документ';

  @override
  String get financeAccountEditTitle => 'Редактировать личный счет';

  @override
  String get financeAddEntryButton => 'Добавить запись';

  @override
  String get financeSectionAccessControl => 'Доступ и валюта';

  @override
  String get financeActiveUserLabel => 'Пользователь';

  @override
  String get financePrivacyNote =>
      'В локальном режиме отображаются только данные выбранного пользователя.';

  @override
  String get financeCurrencyLabel => 'Валюта';

  @override
  String get financeCurrencyKzt => 'Тенге (KZT)';

  @override
  String get financeCurrencyUsd => 'Доллар США (USD)';

  @override
  String get financeCurrencyEur => 'Евро (EUR)';

  @override
  String get financeSectionPersonalAccount => 'Личный финансовый счет';

  @override
  String get financeMetricPersonalBalance => 'Личный баланс';

  @override
  String get financeMetricCash => 'Наличные';

  @override
  String get financeMetricCard => 'Карта';

  @override
  String get financeMetricWallet => 'Кошелек';

  @override
  String get financeMetricRemainingBalance => 'Остаток';

  @override
  String get financeSectionStatistics => 'Статистика';

  @override
  String get financeStatTotalIncome => 'Общий доход';

  @override
  String get financeStatTotalExpenses => 'Общие расходы';

  @override
  String get financeStatMonthlyExpenses => 'Расходы за месяц';

  @override
  String get financeStatWeeklyExpenses => 'Расходы за неделю';

  @override
  String get financeSectionSearchFilters => 'Поиск и фильтры';

  @override
  String get financeSearchHint => 'Поиск по описанию, проекту или категории';

  @override
  String get financeFilterCategory => 'Фильтр по категории';

  @override
  String get financeFilterPaymentMethod => 'Фильтр по способу оплаты';

  @override
  String get financeFilterProject => 'Фильтр по проекту';

  @override
  String get financeAllCategories => 'Все категории';

  @override
  String get financeAllMethods => 'Все способы';

  @override
  String get financeAllProjects => 'Все проекты';

  @override
  String get financeExportPlaceholderTitle => 'Экспорт';

  @override
  String get financeExportPlaceholderSubtitle =>
      'Экспорт PDF/XLS по выбранному периоду будет доступен после интеграции backend.';

  @override
  String get financeNoEntries => 'Нет записей для выбранных фильтров';

  @override
  String get financeReceiptDefaultValue => 'Ссылка на документ';

  @override
  String get financePaymentCash => 'Наличные';

  @override
  String get financePaymentCard => 'Карта';

  @override
  String get financePaymentWallet => 'Кошелек';

  @override
  String get financeFoodLabel => 'Питание';

  @override
  String get financeAccommodationLabel => 'Проживание';

  @override
  String get financeToolsLabel => 'Инструменты';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonAdd => 'Добавить';

  @override
  String get commonEdit => 'Редактировать';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get validationRequired => 'Это поле обязательно.';
}
