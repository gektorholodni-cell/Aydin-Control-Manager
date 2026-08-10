// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'Aydin Control Manager';

  @override
  String get navHome => 'Басты бет';

  @override
  String get navChats => 'Чаттар';

  @override
  String get navTasks => 'Тапсырмалар';

  @override
  String get navFinance => 'Қаржы';

  @override
  String get navProfile => 'Профиль';

  @override
  String get homeTitle => 'Басқару панелі';

  @override
  String get homeGreeting => 'ACM жүйесіне қош келдіңіз';

  @override
  String get homeOverviewSubtitle =>
      'Негізгі құрылыс көрсеткіштері мен прогресс бір экранда.';

  @override
  String get quickStatisticsTitle => 'Жедел статистика';

  @override
  String get quickActionsTitle => 'Жедел әрекеттер';

  @override
  String get recentActivityTitle => 'Соңғы белсенділік';

  @override
  String get recentActivitySubtitle =>
      'Алаңдағы жаңартулар және команда оқиғалары.';

  @override
  String get actionOpenChats => 'Чаттарды ашу';

  @override
  String get actionViewTasks => 'Тапсырмаларды ашу';

  @override
  String get actionFinance => 'Қаржы';

  @override
  String get actionEmployees => 'Қызметкерлер';

  @override
  String get actionProjects => 'Жобалар';

  @override
  String get actionReports => 'Есептер';

  @override
  String get actionAdminPanel => 'Әкімші панелі';

  @override
  String get reportsPlaceholderInfo =>
      'Есептер модулі келесі кезеңде қосылады.';

  @override
  String get statActiveTasks => 'Белсенді тапсырмалар';

  @override
  String get statEmployeesOnline => 'Онлайн қызметкерлер';

  @override
  String get statUnreadMessages => 'Оқылмаған хабарламалар';

  @override
  String get statBudgetRemaining => 'Қалған бюджет';

  @override
  String get currentProjectTitle => 'Ағымдағы жоба';

  @override
  String currentProjectProgress(String value) {
    return 'Прогресс: $value';
  }

  @override
  String get activityConcreteTitle => 'Бетон құю аяқталды';

  @override
  String get activityConcreteDetail =>
      'A мұнарасы, 18-деңгей мерзімінен бұрын аяқталды.';

  @override
  String get activitySafetyTitle => 'Қауіпсіздік тексерісі жіберілді';

  @override
  String get activitySafetyDetail =>
      'Күнделікті EHS чек-парағы учаске басшысымен бекітілді.';

  @override
  String get activityProcurementTitle => 'Жабдықтау жаңартуы';

  @override
  String get activityProcurementDetail =>
      'Болат арқалықтардың №47 партиясы нысанға жолда.';

  @override
  String get activityClientTitle => 'Клиент пікірі алынды';

  @override
  String get activityClientDetail =>
      'Жоба тредіне жаңа жоспар белгілеулері тіркелді.';

  @override
  String get chatsTitle => 'Чаттар';

  @override
  String get chatsPlaceholder =>
      'Мұнда команда тредтері, жоба арналары және контекстік тіркемелер іске асырылады.';

  @override
  String get chatsPrivateTab => 'Жеке';

  @override
  String get chatsGroupTab => 'Топтар';

  @override
  String get chatsTypingPlaceholder => 'Жазып жатыр...';

  @override
  String get chatsVoicePlaceholder => 'Дауыстық хабарлама';

  @override
  String get chatsVoiceStart => 'Жазуды бастау';

  @override
  String get chatsVoiceStopAndSend => 'Тоқтату және жіберу';

  @override
  String get chatsVoicePlaceholderButton => 'Дауыс';

  @override
  String get chatsAttachmentPlaceholder =>
      'Тіркемелерді жүктеу келесі итерацияда қолжетімді болады.';

  @override
  String get chatsAttachmentPlaceholderButton => 'Тіркеу';

  @override
  String get financeTitle => 'Қаржы';

  @override
  String get financePlaceholder =>
      'Бұл модульге бюджет бақылауы, келісімдер және шығын аналитикасы қосылады.';

  @override
  String get financeHeadline => 'Қаржыны басқару орталығы';

  @override
  String get financeSubtitle =>
      'Жеке және жоба шығындарын, кірісті және қалған бюджетті автоматты түрде бақылаңыз.';

  @override
  String get financePersonalExpenses => 'Жеке шығындар';

  @override
  String get financeProjectExpenses => 'Жоба шығындары';

  @override
  String get financeIncome => 'Кіріс';

  @override
  String get financeRemainingBudget => 'Қалған бюджет';

  @override
  String get financeChartsPlaceholder => 'Графиктер placeholder';

  @override
  String get financeChartsPlaceholderDescription =>
      'Мұнда cashflow, burn-rate және ауытқу графиктері қосылады.';

  @override
  String get financeExpenseHistory => 'Шығындар тарихы';

  @override
  String get companyTitle => 'Компанияны басқару';

  @override
  String get companyContacts => 'Компания байланыстары';

  @override
  String get companyNotFound => 'Компания табылмады';

  @override
  String get documentsTitle => 'Құжаттар';

  @override
  String get documentsHeadline => 'Құжаттарды басқару';

  @override
  String get documentsSubtitle =>
      'Бума, санат және соңғы жоба файлдарын реттеңіз.';

  @override
  String get documentsFolders => 'Бумалар';

  @override
  String get documentsRecent => 'Соңғы құжаттар';

  @override
  String get documentsPdfPlaceholder => 'PDF алдын ала қарау placeholder';

  @override
  String get documentsDwgPlaceholder => 'DWG алдын ала қарау placeholder';

  @override
  String get documentsExcelPlaceholder => 'Excel алдын ала қарау placeholder';

  @override
  String get documentsOpenPlaceholder =>
      'Ашу ағыны backend интеграция кезеңінде қолжетімді болады.';

  @override
  String get photoReportsTitle => 'Фото есептер';

  @override
  String get photoReportsHeadline => 'Нысан фото есептері';

  @override
  String get photoReportsSubtitle =>
      'Жоба және қызметкер бойынша дейін/кейін альбомдарын бақылаңыз.';

  @override
  String get photoReportsDate => 'Күні';

  @override
  String get notificationsTitle => 'Хабарландырулар';

  @override
  String get notificationsCenter => 'Хабарландыру орталығы';

  @override
  String get notificationsSubtitle =>
      'Тапсырма ескертулері, жоба жаңартулары және қаржы дабылдары бір жерде.';

  @override
  String get notificationsTaskReminders => 'Тапсырма ескертуі';

  @override
  String get notificationsProjectUpdates => 'Жоба жаңартуы';

  @override
  String get notificationsFinanceAlerts => 'Қаржы дабылы';

  @override
  String get notificationsEmployeeAlerts => 'Қызметкер хабарламасы';

  @override
  String get notificationsSystemAlerts => 'Жүйелік хабарлама';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get profileHeadline => 'Профиль баптаулары';

  @override
  String get profileDescription =>
      'Жеке параметрлер мен интерфейс тілін басқарыңыз.';

  @override
  String get profileManagerName => 'Аружан Төлеген';

  @override
  String get languageSectionTitle => 'Қолданба тілі';

  @override
  String get languageSectionSubtitle =>
      'Тілді таңдаңыз. Өзгеріс бірден қолданылады.';

  @override
  String get languageSelectLabel => 'Тіл';

  @override
  String get languageRussian => 'Орыс тілі';

  @override
  String get languageKazakh => 'Қазақ тілі';

  @override
  String get languageEnglish => 'Ағылшын тілі';

  @override
  String get splashTagline => 'Кәсіпорын деңгейіндегі құрылыс менеджменті';

  @override
  String get loginWelcomeBack => 'Қайта қош келдіңіз';

  @override
  String get loginSubtitle => 'ACM жүйесіне кіру үшін аккаунтқа өтіңіз.';

  @override
  String get loginSideTitle => 'Құрылысты басқарудың бір орталығы';

  @override
  String get loginSideSubtitle =>
      'Жобаларды жоспарлаңыз, команданы үйлестіріңіз және бюджетті бір жерден басқарыңыз.';

  @override
  String get commonEmail => 'Email';

  @override
  String get commonPhone => 'Телефон';

  @override
  String get commonPassword => 'Құпиясөз';

  @override
  String get loginRememberMe => 'Мені есте сақтау';

  @override
  String get loginForgotPassword => 'Құпиясөзді ұмыттыңыз ба?';

  @override
  String get loginForgotPasswordInfo =>
      'Құпиясөзді қалпына келтіру келесі релизде қолжетімді болады.';

  @override
  String get loginRoleLabel => 'Рөл';

  @override
  String get loginButton => 'Кіру';

  @override
  String get settingsTitle => 'Баптаулар';

  @override
  String get settingsHeadline => 'Қолданба баптаулары';

  @override
  String get settingsSubtitle =>
      'Көрініс, тіл, хабарландыру және қауіпсіздік параметрлерін басқарыңыз.';

  @override
  String get settingsTheme => 'Тақырып';

  @override
  String get settingsThemeLight => 'Жарық';

  @override
  String get settingsThemeDark => 'Қараңғы';

  @override
  String get settingsThemeSystem => 'Жүйелік';

  @override
  String get settingsNotifications => 'Хабарландырулар';

  @override
  String get settingsNotificationsSubtitle =>
      'Тапсырма ескертулері, жоба жаңартулары және қаржы дабылдарына рұқсат беру.';

  @override
  String get settingsSecurity => 'Қауіпсіздік';

  @override
  String get settingsSecuritySubtitle =>
      'Маңызды әрекеттер үшін жергілікті қауіпсіздік тексерісін талап ету.';

  @override
  String get employeesTitle => 'Қызметкерлер';

  @override
  String get employeesHeadline => 'Қызметкерлерді басқару';

  @override
  String get employeesSubtitle =>
      'Команда қолжетімділігін, рөлдерді және жоба тағайындауларын бақылаңыз.';

  @override
  String get employeesNoResults =>
      'Таңдалған шарттарға сай қызметкерлер табылмады';

  @override
  String get employeesSearchHint =>
      'Қызметкерлерді аты, телефон немесе жоба бойынша іздеу';

  @override
  String get employeeDetailsTitle => 'Қызметкер деректері';

  @override
  String get employeeNotFound => 'Қызметкер табылмады';

  @override
  String employeeContactReady(String name) {
    return '$name үшін байланыс әрекеті дайын.';
  }

  @override
  String get employeeTaskSummaryTitle => 'Тапсырма қорытындысы';

  @override
  String get employeeAssignedTasks => 'Тағайындалған тапсырмалар';

  @override
  String get employeeCompletedTasks => 'Орындалған тапсырмалар';

  @override
  String get employeePersonalNotes => 'Жеке жазбалар';

  @override
  String get statusOnline => 'Онлайн';

  @override
  String get statusOffline => 'Офлайн';

  @override
  String get filterRoleLabel => 'Рөл';

  @override
  String get filterAllRoles => 'Барлық рөлдер';

  @override
  String get filterSortByLabel => 'Сұрыптау';

  @override
  String get sortOnlineFirst => 'Алдымен онлайн';

  @override
  String get sortAlphabetically => 'Әліпби бойынша';

  @override
  String get sortByPosition => 'Лауазым бойынша';

  @override
  String get roleDirector => 'Директор';

  @override
  String get roleProjectManager => 'Жоба менеджері';

  @override
  String get roleSiteEngineer => 'Учаске инженері';

  @override
  String get roleForeman => 'Прораб';

  @override
  String get roleSurveyor => 'Геодезист';

  @override
  String get roleSafetyEngineer => 'Қауіпсіздік инженері';

  @override
  String get roleAccountant => 'Бухгалтер';

  @override
  String get roleStorekeeper => 'Қоймашы';

  @override
  String get roleWorker => 'Жұмысшы';

  @override
  String get projectsTitle => 'Жобалар';

  @override
  String get projectsHeadline => 'Құрылыс жобалары';

  @override
  String get projectsSubtitle =>
      'Жоба күйін, бюджетті, мерзімдерді және алаң прогресін бақылаңыз.';

  @override
  String get projectDetailsTitle => 'Жоба деректері';

  @override
  String get projectNotFound => 'Жоба табылмады';

  @override
  String get newProjectTitle => 'Жаңа жоба';

  @override
  String get newProjectHeadline => 'Жоба құру';

  @override
  String get newProjectSubtitle =>
      'Жоба кеңістігін бастау үшін ауқым, мерзім және бюджетті анықтаңыз.';

  @override
  String get projectFieldName => 'Жоба атауы';

  @override
  String get projectFieldClient => 'Тапсырыс беруші';

  @override
  String get projectFieldAddress => 'Мекенжай';

  @override
  String get projectCreateButton => 'Жоба құру';

  @override
  String get projectSelectDatesError =>
      'Басталу және аяқталу күндерін таңдаңыз.';

  @override
  String get projectEndDateError =>
      'Аяқталу күні басталу күнінен кейін болуы керек.';

  @override
  String get projectBudgetValidationError => 'Дұрыс бюджет сомасын енгізіңіз.';

  @override
  String get projectCreatedLocalInfo =>
      'Жоба черновигі жергілікті түрде құрылды (mock ағын).';

  @override
  String get projectInformationTitle => 'Жоба туралы ақпарат';

  @override
  String get projectProgressStageTitle => 'Прогресс және ағымдағы кезең';

  @override
  String projectCompletedValue(String value) {
    return 'Орындалды: $value';
  }

  @override
  String get projectCurrentStage => 'Ағымдағы кезең';

  @override
  String get projectWeatherActivityTitle => 'Ауа райы және соңғы белсенділік';

  @override
  String get projectStatusPlanning => 'Жоспарлау';

  @override
  String get projectStatusOnTrack => 'Жоспарға сай';

  @override
  String get projectStatusAtRisk => 'Тәуекелде';

  @override
  String get projectStatusDelayed => 'Кешігу';

  @override
  String get projectStatusCompleted => 'Аяқталды';

  @override
  String get tabOverview => 'Шолу';

  @override
  String get tabTasks => 'Тапсырмалар';

  @override
  String get tabEmployees => 'Қызметкерлер';

  @override
  String get tabDocuments => 'Құжаттар';

  @override
  String get tabPhotos => 'Фотолар';

  @override
  String get tabFinance => 'Қаржы';

  @override
  String get projectTabTasksPlaceholder =>
      'Тапсырма жоспары, тәуелділіктер және негізгі кезеңдер.';

  @override
  String get projectTabEmployeesPlaceholder =>
      'Нысан бойынша тағайындалған команда және ресурс бөлінісі.';

  @override
  String get projectTabDocumentsPlaceholder =>
      'Нысанға қатысты келісімшарттар, рұқсаттар және файлдар.';

  @override
  String get projectTabPhotosPlaceholder =>
      'Алаң прогресінің фото хронологиясы.';

  @override
  String get projectTabFinancePlaceholder =>
      'Жоба бойынша шығын бақылауы, шоттар және төлем кестелері.';

  @override
  String get tasksTitle => 'Тапсырмалар';

  @override
  String get tasksHeadline => 'Тапсырмаларды басқару';

  @override
  String get tasksSubtitle =>
      'Құрылыс тапсырмаларын жоспарлаңыз, тағайындаңыз және орындауды бақылаңыз.';

  @override
  String get tasksNoResults =>
      'Таңдалған сүзгілер бойынша тапсырмалар табылмады';

  @override
  String get newTaskTitle => 'Жаңа тапсырма';

  @override
  String get newTaskHeadline => 'Тапсырма құру';

  @override
  String get newTaskSubtitle =>
      'Тапсырманың ауқымын, жауаптыны, құнын және мерзімін анықтаңыз.';

  @override
  String get taskAssignEmployee => 'Қызметкерді тағайындау';

  @override
  String get taskEstimatedCost => 'Болжамды құн';

  @override
  String get taskCreateButton => 'Тапсырма құру';

  @override
  String get taskSelectDatesError => 'Басталу күні мен дедлайнды таңдаңыз.';

  @override
  String get taskDeadlineAfterStartError =>
      'Дедлайн басталу күнінен кейін болуы керек.';

  @override
  String get taskCostValidationError => 'Дұрыс құнды енгізіңіз.';

  @override
  String get taskCreatedLocalInfo =>
      'Тапсырма жергілікті түрде құрылды (mock ағын).';

  @override
  String get taskAttachPhotos => 'Фото тіркеу';

  @override
  String get taskAttachPhotosPlaceholder =>
      'Тапсырмаға сурет қосу үшін фотоотчеттарды ашыңыз.';

  @override
  String get taskAttachDocuments => 'Құжат тіркеу';

  @override
  String get taskAttachDocumentsPlaceholder =>
      'Сызбалар мен файлдарды қосу үшін құжаттарды ашыңыз.';

  @override
  String get taskAttachButton => 'Тіркеу';

  @override
  String taskAttachmentInfoAction(String title) {
    return '$title бөлімі жергілікті түрде ашылды.';
  }

  @override
  String get taskDetailsTitle => 'Тапсырма деректері';

  @override
  String get taskNotFound => 'Тапсырма табылмады';

  @override
  String taskDeadlineValue(String date) {
    return 'Дедлайн: $date';
  }

  @override
  String get taskFullDescription => 'Толық сипаттама';

  @override
  String get taskAssignedEmployees => 'Тағайындалған қызметкерлер';

  @override
  String get taskComments => 'Пікірлер';

  @override
  String get taskActivityHistory => 'Белсенділік тарихы';

  @override
  String get taskBeforePhotos => 'Бұрынғы фотолар';

  @override
  String get taskAfterPhotos => 'Кейінгі фотолар';

  @override
  String get taskChangeStatus => 'Күйді өзгерту';

  @override
  String taskStatusChangedLocal(String status) {
    return 'Күй $status болып өзгертілді (жергілікті mock).';
  }

  @override
  String get taskPriorityLow => 'Төмен';

  @override
  String get taskPriorityMedium => 'Орташа';

  @override
  String get taskPriorityHigh => 'Жоғары';

  @override
  String get taskPriorityCritical => 'Критикалық';

  @override
  String get taskStatusNotStarted => 'Басталмаған';

  @override
  String get taskStatusInProgress => 'Орындалуда';

  @override
  String get taskStatusWaiting => 'Күту';

  @override
  String get taskStatusCompleted => 'Аяқталған';

  @override
  String get filterAllProjects => 'Барлық жобалар';

  @override
  String get filterAllEmployees => 'Барлық қызметкерлер';

  @override
  String get filterAllStatuses => 'Барлық күйлер';

  @override
  String get filterAllPriorities => 'Барлық басымдықтар';

  @override
  String get filterSortLabel => 'Сұрыптау';

  @override
  String get sortRecentlyUpdated => 'Жақында жаңартылған';

  @override
  String get commonTitle => 'Атауы';

  @override
  String get commonDescription => 'Сипаттама';

  @override
  String get commonProject => 'Жоба';

  @override
  String get commonEmployee => 'Қызметкер';

  @override
  String get commonStatus => 'Күй';

  @override
  String get commonPriority => 'Басымдық';

  @override
  String get commonDeadline => 'Дедлайн';

  @override
  String get commonStartDate => 'Басталу күні';

  @override
  String get commonEndDate => 'Аяқталу күні';

  @override
  String get commonSelectDate => 'Күнді таңдаңыз';

  @override
  String get commonBudget => 'Бюджет';

  @override
  String get commonEmployees => 'Қызметкерлер';

  @override
  String get commonRemainingBudget => 'Қалған бюджет';

  @override
  String get commonTimeline => 'Мерзім';

  @override
  String get commonWeather => 'Ауа райы';

  @override
  String get commonLastActivity => 'Соңғы белсенділік';

  @override
  String get commonRecentUpdates => 'Соңғы жаңартулар';

  @override
  String get commonContact => 'Байланысу';

  @override
  String get commonProgress => 'Прогресс';

  @override
  String commonProgressValue(String value) {
    return 'Прогресс: $value';
  }

  @override
  String get commonNoItemsYet => 'Әзірге элементтер жоқ.';

  @override
  String taskEstimatedCostValue(String cost) {
    return 'Болжамды құн: $cost';
  }

  @override
  String get chatsSearchLabel => 'Чаттар мен пайдаланушыларды іздеу';

  @override
  String get chatsNoResults => 'Чаттар табылмады';

  @override
  String get chatsEmojiPlaceholder => 'Смайликтер мен стикерлер';

  @override
  String get chatsImagePlaceholder =>
      'Сурет жіберу келесі итерацияда қолжетімді болады.';

  @override
  String get chatsCreateDirectPlaceholder =>
      'Жеке чат құру ағыны келесі итерацияда қосылады.';

  @override
  String get chatCreateDirectTitle => 'Жеке чат';

  @override
  String get chatCreateGroupTitle => 'Топ құру';

  @override
  String get chatCreateGroupButton => 'Жаңа топ';

  @override
  String get chatGroupCreatedPlaceholder =>
      'Топ жергілікті mock режимінде құрылды.';

  @override
  String get chatGroupNameLabel => 'Топ атауы';

  @override
  String get chatSearchUsersLabel => 'Қатысушыларды іздеу';

  @override
  String get chatAddMembersTitle => 'Қатысушылар қосу';

  @override
  String get chatAddMember => 'Қосу';

  @override
  String get chatRemoveMember => 'Өшіру';

  @override
  String get chatGroupAdmin => 'Топ әкімшісі';

  @override
  String get chatInfoTitle => 'Чат ақпараты';

  @override
  String get chatMessageInputPlaceholder => 'Хабарлама енгізіңіз';

  @override
  String get chatSharedMediaPlaceholder => 'Ортақ медиа';

  @override
  String get chatSharedMediaDescription =>
      'Фото мен файлдар backend интеграциясынан кейін көрсетіледі.';

  @override
  String get chatReactionsPlaceholder => 'Реакциялар мен жауаптар';

  @override
  String get chatReactionsDescription =>
      'Реакциялар қорытындысы келесі спринтте қолжетімді болады.';

  @override
  String get chatPin => 'Чатты бекіту';

  @override
  String get chatUnpin => 'Чатты бекітуден шығару';

  @override
  String get chatArchive => 'Чатты архивтеу';

  @override
  String get chatUnarchive => 'Архивтен шығару';

  @override
  String get chatMuteNotifications => 'Хабарландыруларды өшіру';

  @override
  String get chatUnmute => 'Хабарландыруларды қосу';

  @override
  String get chatDelete => 'Чатты жою';

  @override
  String get chatDeletePlaceholder =>
      'Чатты жою сервер растауынан кейін қосылады.';

  @override
  String get chatMarkRead => 'Оқылды деп белгілеу';

  @override
  String get chatNotFound => 'Чат табылмады';

  @override
  String get chatMembersTitle => 'Қатысушылар';

  @override
  String chatMembersCount(int count) {
    return 'Қатысушылар: $count';
  }

  @override
  String chatLastSeen(String value) {
    return 'Соңғы рет желіде: $value';
  }

  @override
  String get chatShowArchived => 'Архивті көрсету';

  @override
  String get chatHideArchived => 'Архивті жасыру';

  @override
  String get commonBackToChat => 'Чатқа оралу';

  @override
  String get settingsGeneralSection => 'Жалпы';

  @override
  String get settingsAppearanceSection => 'Көрініс';

  @override
  String get settingsNotificationsSection => 'Хабарландырулар';

  @override
  String get settingsSecuritySection => 'Қауіпсіздік';

  @override
  String get settingsApplicationSection => 'Қолданба';

  @override
  String get settingsSupportSection => 'Қолдау';

  @override
  String get settingsDateFormat => 'Күн форматы';

  @override
  String get settingsTimeFormat => 'Уақыт форматы';

  @override
  String get settingsDateFormatDmy => 'КК.АА.ЖЖЖЖ';

  @override
  String get settingsDateFormatMdy => 'АА/КК/ЖЖЖЖ';

  @override
  String get settingsDateFormatYmd => 'ЖЖЖЖ-АА-КК';

  @override
  String get settingsTimeFormat24 => '24 сағат';

  @override
  String get settingsTimeFormat12 => '12 сағат';

  @override
  String get settingsPushNotifications => 'Push хабарландырулар';

  @override
  String get settingsChatNotifications => 'Чат хабарландырулары';

  @override
  String get settingsTaskNotifications => 'Тапсырма хабарландырулары';

  @override
  String get settingsFinanceNotifications => 'Қаржы хабарландырулары';

  @override
  String get settingsPinCode => 'PIN код';

  @override
  String get settingsBiometric => 'Биометрия';

  @override
  String get settingsAutoLock => 'Автоқұлып';

  @override
  String get settingsChangePassword => 'Құпиясөзді өзгерту';

  @override
  String get settingsSecurityPlaceholder =>
      'Құпиясөзді өзгерту identity сервисінен кейін қолжетімді болады.';

  @override
  String get settingsCache => 'Кэшті тазалау';

  @override
  String get settingsStorage => 'Сақтау орны';

  @override
  String get settingsPrivacyMode => 'Құпиялылық режимі';

  @override
  String get settingsPrivacyModeSubtitle =>
      'Соңғы қолданбалар экранында сезімтал деректерді жасыру.';

  @override
  String get settingsAnalytics => 'Пайдалану аналитикасы';

  @override
  String get settingsAnalyticsSubtitle =>
      'Өнімді жақсарту үшін анонимді пайдалану деректерін бөлісу.';

  @override
  String get settingsAccessibilityHighContrast => 'Жоғары контраст';

  @override
  String get settingsAccessibilityReduceMotion => 'Қимылды азайту';

  @override
  String get settingsDataSaver => 'Трафикті үнемдеу режимі';

  @override
  String get settingsBackup => 'Сақтық көшіру';

  @override
  String get settingsBackupPlaceholder =>
      'Бұлтқа сақтық көшіру келесі интеграция кезеңінде қосылады.';

  @override
  String get settingsExportData => 'Деректерді экспорттау';

  @override
  String get settingsAboutApp => 'Қолданба туралы';

  @override
  String get settingsPrivacyPolicy => 'Құпиялық саясаты';

  @override
  String get settingsTerms => 'Пайдалану шарттары';

  @override
  String get settingsHelpCenter => 'Көмек орталығы';

  @override
  String get settingsContactSupport => 'Қолдауға жазу';

  @override
  String get settingsSendFeedback => 'Пікір жіберу';

  @override
  String get settingsActionPlaceholder =>
      'Бұл әрекет келесі интеграция кезеңінде қолжетімді болады.';

  @override
  String get profileRoleLabel => 'Рөл';

  @override
  String get profilePositionLabel => 'Лауазым';

  @override
  String get profileDepartmentLabel => 'Бөлім';

  @override
  String get profileCompanyLabel => 'Компания';

  @override
  String get profileCoverPlaceholder => 'Профиль мұқабасының заглушкасы';

  @override
  String get profileStatsTitle => 'Статистика';

  @override
  String get profileAchievementsTitle => 'Жетістіктер';

  @override
  String get profileAchievementsPlaceholder =>
      'Жетістіктер блогының заглушкасы.';

  @override
  String get profileRecentActivityTitle => 'Соңғы белсенділік';

  @override
  String get profileRecentActivityPlaceholder =>
      'Пайдаланушының соңғы әрекеттерінің заглушкасы.';

  @override
  String get profileNotificationStatus => 'Хабарландыру күйі';

  @override
  String get profileSecurityStatus => 'Қауіпсіздік күйі';

  @override
  String get profileAboutTitle => 'Қолданба туралы';

  @override
  String get profileVersionTitle => 'Нұсқа';

  @override
  String get profileVersionValue => '1.0.0-enterprise';

  @override
  String get profileNotificationEnabled => 'Қосулы';

  @override
  String get profileNotificationDisabled => 'Өшірулі';

  @override
  String get profileSecurityEnabled => 'Жергілікті қорғаныс қосулы';

  @override
  String get profileSecurityDisabled => 'Жергілікті қорғаныс өшірулі';

  @override
  String get profileAboutDescription =>
      'ACM құрылыс командалары үшін жоба, тапсырма, байланыс және қаржы басқаруын біріктіреді.';

  @override
  String get statProjects => 'Жобалар';

  @override
  String get statEmployees => 'Қызметкерлер';

  @override
  String get statTasksToday => 'Бүгінгі тапсырмалар';

  @override
  String get statCompletedTasks => 'Аяқталған тапсырмалар';

  @override
  String get statPendingTasks => 'Күтілудегі тапсырмалар';

  @override
  String get statOverdueTasks => 'Мерзімі өткен тапсырмалар';

  @override
  String get statProjectProgress => 'Жоба прогресі';

  @override
  String get statExpenses => 'Шығындар';

  @override
  String get statIncome => 'Кіріс';

  @override
  String get statMonthlyExpenses => 'Айлық шығындар';

  @override
  String get statMonthlyIncome => 'Айлық кіріс';

  @override
  String get tabChat => 'Чат';

  @override
  String get tabReports => 'Есептер';

  @override
  String get projectTabChatPlaceholder =>
      'Жоба талқылаулары мен команда байланысы.';

  @override
  String get projectTabReportsPlaceholder =>
      'Жоба есептері, инспекциялар және басшылыққа арналған қорытындылар.';

  @override
  String get taskStatusInspection => 'Инспекция';

  @override
  String get tasksListMode => 'Тізім';

  @override
  String get tasksKanbanMode => 'Канбан';

  @override
  String get kanbanDropTasksHere => 'Тапсырманы осында апарыңыз';

  @override
  String get kanbanReleaseToMove => 'Жылжыту үшін жіберіңіз';

  @override
  String get kanbanPlanned => 'Жоспарланған';

  @override
  String get kanbanInProgress => 'Орындалуда';

  @override
  String get kanbanWaiting => 'Күту';

  @override
  String get kanbanInspection => 'Инспекция';

  @override
  String get kanbanCompleted => 'Аяқталған';

  @override
  String get reportsModuleTitle => 'Құрылыс есептері';

  @override
  String get reportsModuleHeadline => 'Жобалық есеп беру орталығы';

  @override
  String get reportsModuleSubtitle =>
      'Тиімділік, сапа, қауіпсіздік және бюджетті бір жерден бақылаңыз.';

  @override
  String get reportsWeeklyProgress => 'Апталық прогресс';

  @override
  String get reportsSafetyChecks => 'Қауіпсіздік тексерістері';

  @override
  String get reportsBudgetDeviation => 'Бюджет ауытқуы';

  @override
  String get reportsQualityScore => 'Сапа ұпайы';

  @override
  String get reportsChartsPlaceholderTitle => 'Графиктер қорытындысы';

  @override
  String get reportsChartsPlaceholderSubtitle =>
      'Жобалар бойынша S-қисық, өнімділік және сапа трендтері.';

  @override
  String get reportsExportPlaceholderTitle => 'Есептер экспорты';

  @override
  String get reportsExportPlaceholderSubtitle =>
      'Таңдалған кезең мен жоба үшін PDF/XLS экспорт.';

  @override
  String get globalSearchTitle => 'Жаһандық іздеу';

  @override
  String get globalSearchHint =>
      'Жоба, қызметкер, тапсырма, чат, құжат бойынша іздеу';

  @override
  String get globalSearchStartTyping => 'Іздеу үшін енгізуді бастаңыз';

  @override
  String get globalSearchNoResults => 'Нәтиже табылмады';

  @override
  String globalSearchPhotosCount(int count) {
    return 'Фотолар: $count';
  }

  @override
  String get dashboardWidgetsTitle => 'Операциялық виджеттер';

  @override
  String get dashboardWeatherTitle => 'Ағымдағы ауа райы';

  @override
  String get dashboardWeatherPlaceholder => 'Ауа райы заглушкасы';

  @override
  String get dashboardTodayTasksTitle => 'Бүгінгі тапсырмалар';

  @override
  String get dashboardRecentMessagesTitle => 'Соңғы хабарламалар';

  @override
  String get dashboardRecentExpensesTitle => 'Соңғы шығындар';

  @override
  String get dashboardProjectProgressTitle => 'Жоба прогресі';

  @override
  String get dashboardEmployeesOnlineTitle => 'Онлайн қызметкерлер';

  @override
  String get dashboardChartsPlaceholderTitle => 'Графиктер';

  @override
  String get dashboardChartsPlaceholderSubtitle =>
      'S-қисық және прогресс графиктерінің заглушкасы';

  @override
  String get dashboardQuickActionsHint => 'Негізгі модульдерге жылдам өту';

  @override
  String get photoReportsCreateAlbum => 'Альбом құру';

  @override
  String get photoReportsDescriptionPlaceholder =>
      'Фотоесеп сипаттамасы заглушкасы';

  @override
  String get photoReportsLocationPlaceholder => 'Локация заглушкасы';

  @override
  String get photoReportsAddPhotoPlaceholder =>
      'Фото қосу осы кезеңде заглушка режимінде.';

  @override
  String get photoReportsTaskLabel => 'Тапсырма';

  @override
  String get photoReportsTimeLabel => 'Уақыт';

  @override
  String get photoReportsLocationLabel => 'Локация';

  @override
  String get photoReportsAddBefore => 'Дейін қосу';

  @override
  String get photoReportsAddAfter => 'Кейін қосу';

  @override
  String get photoReportsDeleteBefore => 'Дейін жою';

  @override
  String get photoReportsDeleteAfter => 'Кейін жою';

  @override
  String get photoReportsPreviewTitle => 'Фотоны алдын ала қарау';

  @override
  String get documentsCategoryLabel => 'Санат';

  @override
  String get documentsDateLabel => 'Күні';

  @override
  String get documentsAuthorLabel => 'Автор';

  @override
  String get documentsSizeLabel => 'Өлшем';

  @override
  String get documentsVersionLabel => 'Нұсқа';

  @override
  String get financeExpensesLabel => 'Шығындар';

  @override
  String get financeNetLabel => 'Таза нәтиже';

  @override
  String get financeCategoriesTitle => 'Санаттар бойынша бөлу';

  @override
  String get financeMonthlySummaryTitle => 'Айлық қорытынды';

  @override
  String get financeFuelLabel => 'Отын';

  @override
  String get financeEquipmentLabel => 'Жабдық';

  @override
  String get financeMaterialsLabel => 'Материалдар';

  @override
  String get financeWorkersLabel => 'Жұмысшылар';

  @override
  String get financeTransportLabel => 'Көлік';

  @override
  String get financeOtherLabel => 'Басқа';

  @override
  String get employeeAssignedProjectsTitle => 'Тағайындалған жобалар';

  @override
  String get employeeAssignedTasksTitle => 'Тағайындалған тапсырмалар';

  @override
  String get employeeCompletedTasksTitle => 'Аяқталған тапсырмалар';

  @override
  String get employeePerformanceTitle => 'Өнімділік';

  @override
  String get employeeAttendancePlaceholderTitle => 'Белсенді тапсырмалар';

  @override
  String get employeeAttendancePlaceholderSubtitle =>
      'Қызметкердің ағымдағы жұмыс жүктемесі.';

  @override
  String get employeeWorkingHoursPlaceholderTitle => 'Жұмыс сағаттары';

  @override
  String get employeeWorkingHoursPlaceholderSubtitle =>
      'Жұмыс уақыты интеграциясының заглушкасы.';

  @override
  String get adminTitle => 'Әкімшілендіру';

  @override
  String get adminTabOverview => 'Шолу';

  @override
  String get adminTabCompany => 'Компания';

  @override
  String get adminTabRbac => 'RBAC';

  @override
  String get adminTabManagement => 'Басқару';

  @override
  String get adminTabActivity => 'Тарих';

  @override
  String get adminOverviewHeadline => 'Кәсіпорын әкімші панелі';

  @override
  String get adminOverviewSubtitle =>
      'Компания, рөл, жоба, бөлім және бақылау процестерін басқарыңыз.';

  @override
  String get adminDepartmentsTitle => 'Бөлімдер';

  @override
  String get adminTeamsTitle => 'Командалар';

  @override
  String get adminRolesTitle => 'Рөлдер';

  @override
  String get adminOrganizationStructure => 'Ұйым құрылымы';

  @override
  String get adminCompanySettingsTitle => 'Компания баптаулары';

  @override
  String get adminCompanyLogo => 'Компания логотипі';

  @override
  String get adminCompanyName => 'Компания атауы';

  @override
  String get adminCompanyBin => 'БСН';

  @override
  String get adminCompanyWebsite => 'Веб-сайт';

  @override
  String get adminCompanyWorkingHours => 'Жұмыс уақыты';

  @override
  String get adminCompanyTimezone => 'Уақыт белдеуі';

  @override
  String get adminCompanyCurrency => 'Валюта';

  @override
  String get adminCompanyMeasurement => 'Өлшем жүйесі';

  @override
  String get adminSuspendCompany => 'Компанияны тоқтату';

  @override
  String get adminSuspendCompanySubtitle =>
      'Компанияның барлық операцияларын уақытша шектеу.';

  @override
  String get adminCreateCompany => 'Компания құру';

  @override
  String get adminEditCompany => 'Компанияны өңдеу';

  @override
  String get adminDeleteCompany => 'Компанияны жою';

  @override
  String get adminActionCompanyCreated => 'Компания құрылды (mock).';

  @override
  String get adminActionCompanyUpdated => 'Компания жаңартылды (mock).';

  @override
  String get adminActionCompanyDeleted => 'Компания жойылды (mock).';

  @override
  String get adminRbacTitle => 'Рөлге негізделген қолжетімділік (RBAC)';

  @override
  String get adminRbacSubtitle =>
      'Әр корпоративтік рөл үшін рұқсаттарды баптаңыз.';

  @override
  String get adminResetPermissions => 'Рұқсаттарды қалпына келтіру';

  @override
  String get adminSavePermissions => 'Рұқсаттарды сақтау';

  @override
  String get adminActionRoleReset => 'Рөл рұқсаттары үлгіге қайтарылды.';

  @override
  String get adminActionRoleSaved => 'Рөл рұқсаттары сақталды (mock).';

  @override
  String get adminCreateProjects => 'Жоба құру';

  @override
  String get adminCreateProjectsSubtitle =>
      'Жаңа жоба жұмыс кеңістіктерін құрыңыз және іске қосыңыз.';

  @override
  String get adminArchiveProjects => 'Жобаларды архивтеу';

  @override
  String get adminArchiveProjectsSubtitle =>
      'Аяқталған жобаларды архивке жіберу.';

  @override
  String get adminActionProjectCreated => 'Жоба құрылды (mock).';

  @override
  String get adminManagementModules => 'Басқару модульдері';

  @override
  String get adminOpen => 'Ашу';

  @override
  String get adminActionOpened => 'ашылды';

  @override
  String get adminActivityTitle => 'Белсенділік тарихы';

  @override
  String get adminActivitySubtitle =>
      'Кәсіпорын модульдеріндегі барлық маңызды әрекеттерді бақылаңыз.';

  @override
  String get adminRoleOwner => 'Иесі';

  @override
  String get adminRoleAdministrator => 'Әкімші';

  @override
  String get adminRoleViewer => 'Бақылаушы';

  @override
  String get adminPermissionViewProjects => 'Жобаларды көре алады';

  @override
  String get adminPermissionEditProjects => 'Жобаларды өңдей алады';

  @override
  String get adminPermissionDeleteProjects => 'Жобаларды жоя алады';

  @override
  String get adminPermissionCreateTasks => 'Тапсырма құра алады';

  @override
  String get adminPermissionCompleteTasks => 'Тапсырманы аяқтай алады';

  @override
  String get adminPermissionViewFinance => 'Қаржыны көре алады';

  @override
  String get adminPermissionEditFinance => 'Қаржыны өңдей алады';

  @override
  String get adminPermissionUploadDocuments => 'Құжаттарды жүктей алады';

  @override
  String get adminPermissionDeleteDocuments => 'Құжаттарды жоя алады';

  @override
  String get adminPermissionManageEmployees => 'Қызметкерлерді басқара алады';

  @override
  String get adminPermissionManageChats => 'Чаттарды басқара алады';

  @override
  String get adminPermissionManageReports => 'Есептерді басқара алады';

  @override
  String get adminPermissionManageSettings => 'Баптауларды басқара алады';

  @override
  String get homeSummarySection => 'Жалпы шолу';

  @override
  String get tasksTabAll => 'Барлығы';

  @override
  String get tasksTabMine => 'Менікі';

  @override
  String get tasksTabInProgress => 'Жұмыс';

  @override
  String get tasksTabCompleted => 'Дайын';

  @override
  String get tasksTabKanban => 'Канбан';

  @override
  String get tasksFiltersTitle => 'Сүзгілер';

  @override
  String get chatGroupAvatarTitle => 'Топ аватары';

  @override
  String get chatGroupAvatarSubtitle =>
      'Аватар таңдау медиа сақтау интеграциясынан кейін қосылады.';

  @override
  String get chatLeaveGroup => 'Топтан шығу';

  @override
  String get chatAvatarActionPlaceholder =>
      'Аватар әрекеті қосылған режимде қолжетімді болады.';

  @override
  String get chatChangeAvatar => 'Өзгерту';

  @override
  String get profilePositionValue => 'Аға жоба менеджері';

  @override
  String get profileDepartmentValue => 'Жоба кеңсесі';

  @override
  String get profileCompanyValue => 'ACM Control Center';

  @override
  String get profilePhoneValue => '+7 777 450 22 11';

  @override
  String get profileEmailValue => 'manager@structra-group.com';

  @override
  String get enterpriseCalendarTitle => 'Күнтізбе';

  @override
  String get enterpriseCalendarViewDaily => 'Күндік';

  @override
  String get enterpriseCalendarViewWeekly => 'Апталық';

  @override
  String get enterpriseCalendarViewMonthly => 'Айлық';

  @override
  String get enterpriseCalendarCardTitle => 'Корпоративтік күнтізбе';

  @override
  String get enterpriseCalendarCardSubtitle =>
      'Тапсырма, жоба және қызметкер кестелері';

  @override
  String get enterpriseCalendarCardDescription =>
      'Кездесулер мен ауысымдар құрылыс кестесінің нақты оқиғалары ретінде көрсетіледі.';

  @override
  String get enterpriseDrawingsTitle => 'Сызбалар';

  @override
  String get enterpriseDrawingsCardTitle => 'Сызбалар модулі';

  @override
  String get enterpriseDrawingsCardSubtitle =>
      'DWG, PDF, blueprints, 3D-модельдер және спецификациялар';

  @override
  String get enterpriseDrawingsCardDescription =>
      'Нұсқа, ревизия және бекіту бақылауы бар корпоративтік сызба реестрі.';

  @override
  String get enterpriseDrawingsAuthorLabel => 'Автор';

  @override
  String get enterpriseDrawingsActionsLabel =>
      'Алдын ала қарау бар • Жүктеу бар • Пікірлер және ревизия тарихы';

  @override
  String get enterpriseEquipmentTitle => 'Жабдық';

  @override
  String get enterpriseEquipmentCardTitle => 'Жабдықты басқару';

  @override
  String get enterpriseEquipmentCardSubtitle =>
      'Күйі, тағайындау және қызмет көрсету циклі';

  @override
  String get enterpriseEquipmentCardDescription =>
      'Әр жабдық бірлігі үшін отын шығыны мен инспекция күйі бақыланады.';

  @override
  String get enterpriseEquipmentSerialLabel => 'Сериялық нөмір';

  @override
  String get enterpriseEquipmentMaintenanceLabel => 'Техқызмет';

  @override
  String get enterpriseEquipmentFuelLabel => 'Отын шығыны бақыланады';

  @override
  String get enterpriseEquipmentInspectionLabel => 'Инспекция жоспарланған';

  @override
  String get enterpriseVehiclesTitle => 'Көлік';

  @override
  String get enterpriseVehiclesCardTitle => 'Көлік паркін басқару';

  @override
  String get enterpriseVehiclesCardSubtitle =>
      'Флот операциялары және сервис бақылауы';

  @override
  String get enterpriseVehiclesCardDescription =>
      'Флот жазбаларына маршрут күйі, сервис және құжаттар кіреді.';

  @override
  String get enterpriseVehiclesDriverLabel => 'Жүргізуші';

  @override
  String get enterpriseVehiclesMileageLabel => 'Жүрісі';

  @override
  String get enterpriseVehiclesFuelLabel => 'Отын';

  @override
  String get enterpriseVehiclesMaintenanceLabel => 'Техқызмет';

  @override
  String get enterpriseVehiclesDocumentsLabel => 'Құжаттар өзекті';

  @override
  String get enterpriseWarehouseTitle => 'Қойма';

  @override
  String get enterpriseWarehouseCardTitle => 'Қойма';

  @override
  String get enterpriseWarehouseCardSubtitle =>
      'Материал, құрал және жабдық қорын бақылау';

  @override
  String get enterpriseWarehouseCardDescription =>
      'Кіріс, шығыс және қозғалыс нақты корпоративтік жазба түрінде көрсетіледі.';

  @override
  String get enterpriseWarehouseCurrentLabel => 'Ағымдағы қалдық';

  @override
  String get enterpriseWarehouseMinimumLabel => 'Минимум';

  @override
  String get enterpriseWarehouseIncomingLabel => 'Кіріс';

  @override
  String get enterpriseWarehouseOutgoingLabel => 'Шығыс';

  @override
  String get enterpriseWarehouseHistoryLabel => 'Қозғалыс тарихы қолжетімді';

  @override
  String get reportsDailyReportLabel => 'Күндік есеп';

  @override
  String get reportsWeeklyReportLabel => 'Апталық есеп';

  @override
  String get reportsMonthlyReportLabel => 'Айлық есеп';

  @override
  String get reportsEmployeeReportLabel => 'Қызметкер есебі';

  @override
  String get reportsFinanceReportLabel => 'Қаржы есебі';

  @override
  String get reportsProjectReportLabel => 'Жоба есебі';

  @override
  String get reportsPhotoReportLabel => 'Фото есеп';

  @override
  String get reportsProgressReportLabel => 'Прогресс есебі';

  @override
  String get financeDialogAddTitle => 'Қаржы жазбасын қосу';

  @override
  String get financeDialogEditTitle => 'Қаржы жазбасын өзгерту';

  @override
  String get financeTypeExpense => 'Шығыс';

  @override
  String get financeTypeIncome => 'Кіріс';

  @override
  String get financeFieldAmount => 'Сома';

  @override
  String get financeFieldCategory => 'Санат';

  @override
  String get financeFieldPaymentMethod => 'Төлем тәсілі';

  @override
  String get financeFieldReceipt => 'Құжат';

  @override
  String get financeAccountEditTitle => 'Жеке шотты өзгерту';

  @override
  String get financeAddEntryButton => 'Жазба қосу';

  @override
  String get financeSectionAccessControl => 'Қолжетімділік және валюта';

  @override
  String get financeActiveUserLabel => 'Белсенді пайдаланушы';

  @override
  String get financePrivacyNote =>
      'Жергілікті режимде тек таңдалған пайдаланушының деректері көрсетіледі.';

  @override
  String get financeCurrencyLabel => 'Валюта';

  @override
  String get financeCurrencyKzt => 'Теңге (KZT)';

  @override
  String get financeCurrencyUsd => 'АҚШ доллары (USD)';

  @override
  String get financeCurrencyEur => 'Еуро (EUR)';

  @override
  String get financeSectionPersonalAccount => 'Жеке қаржы шоты';

  @override
  String get financeMetricPersonalBalance => 'Жеке баланс';

  @override
  String get financeMetricCash => 'Қолма-қол';

  @override
  String get financeMetricCard => 'Карта';

  @override
  String get financeMetricWallet => 'Әмиян';

  @override
  String get financeMetricRemainingBalance => 'Қалған қалдық';

  @override
  String get financeSectionStatistics => 'Статистика';

  @override
  String get financeStatTotalIncome => 'Жалпы кіріс';

  @override
  String get financeStatTotalExpenses => 'Жалпы шығыс';

  @override
  String get financeStatMonthlyExpenses => 'Айлық шығыс';

  @override
  String get financeStatWeeklyExpenses => 'Апталық шығыс';

  @override
  String get financeSectionSearchFilters => 'Іздеу және сүзгілер';

  @override
  String get financeSearchHint => 'Сипаттама, жоба немесе санат бойынша іздеу';

  @override
  String get financeFilterCategory => 'Санат сүзгісі';

  @override
  String get financeFilterPaymentMethod => 'Төлем тәсілі сүзгісі';

  @override
  String get financeFilterProject => 'Жоба сүзгісі';

  @override
  String get financeAllCategories => 'Барлық санат';

  @override
  String get financeAllMethods => 'Барлық тәсіл';

  @override
  String get financeAllProjects => 'Барлық жоба';

  @override
  String get financeExportPlaceholderTitle => 'Экспорт';

  @override
  String get financeExportPlaceholderSubtitle =>
      'Таңдалған кезең үшін PDF/XLS экспорт backend интеграциясынан кейін қолжетімді болады.';

  @override
  String get financeNoEntries => 'Таңдалған сүзгілер бойынша жазбалар жоқ';

  @override
  String get financeReceiptDefaultValue => 'Құжат сілтемесі';

  @override
  String get financePaymentCash => 'Қолма-қол';

  @override
  String get financePaymentCard => 'Карта';

  @override
  String get financePaymentWallet => 'Әмиян';

  @override
  String get financeFoodLabel => 'Тамақ';

  @override
  String get financeAccommodationLabel => 'Тұру';

  @override
  String get financeToolsLabel => 'Құралдар';

  @override
  String get commonCancel => 'Бас тарту';

  @override
  String get commonSave => 'Сақтау';

  @override
  String get commonAdd => 'Қосу';

  @override
  String get commonEdit => 'Өңдеу';

  @override
  String get commonDelete => 'Жою';

  @override
  String get validationRequired => 'Бұл өріс міндетті.';
}
