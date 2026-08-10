// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Aydin Control Manager';

  @override
  String get navHome => 'Home';

  @override
  String get navChats => 'Chats';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navFinance => 'Finance';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeTitle => 'Dashboard';

  @override
  String get homeGreeting => 'Welcome to ACM';

  @override
  String get homeOverviewSubtitle =>
      'Key construction metrics and live progress at a glance.';

  @override
  String get quickStatisticsTitle => 'Quick Statistics';

  @override
  String get quickActionsTitle => 'Quick Actions';

  @override
  String get recentActivityTitle => 'Recent Activity';

  @override
  String get recentActivitySubtitle => 'Site updates and team events.';

  @override
  String get actionOpenChats => 'Open Chats';

  @override
  String get actionViewTasks => 'View Tasks';

  @override
  String get actionFinance => 'Finance';

  @override
  String get actionEmployees => 'Employees';

  @override
  String get actionProjects => 'Projects';

  @override
  String get actionReports => 'Reports';

  @override
  String get actionAdminPanel => 'Admin Panel';

  @override
  String get reportsPlaceholderInfo =>
      'Reports module will be enabled in a next phase.';

  @override
  String get statActiveTasks => 'Active Tasks';

  @override
  String get statEmployeesOnline => 'Employees Online';

  @override
  String get statUnreadMessages => 'Unread Messages';

  @override
  String get statBudgetRemaining => 'Budget Remaining';

  @override
  String get currentProjectTitle => 'Current Project';

  @override
  String currentProjectProgress(String value) {
    return 'Progress: $value';
  }

  @override
  String get activityConcreteTitle => 'Concrete pour completed';

  @override
  String get activityConcreteDetail =>
      'Tower A, Level 18 was completed ahead of schedule.';

  @override
  String get activitySafetyTitle => 'Safety inspection submitted';

  @override
  String get activitySafetyDetail =>
      'Daily EHS checklist approved by site supervisor.';

  @override
  String get activityProcurementTitle => 'Procurement update';

  @override
  String get activityProcurementDetail =>
      'Steel beams batch #47 is en route to the site.';

  @override
  String get activityClientTitle => 'Client comment received';

  @override
  String get activityClientDetail =>
      'New layout markups were attached to the project thread.';

  @override
  String get chatsTitle => 'Chats';

  @override
  String get chatsPlaceholder =>
      'Team communication threads, project channels, and contextual attachments will be implemented here.';

  @override
  String get chatsPrivateTab => 'Private';

  @override
  String get chatsGroupTab => 'Groups';

  @override
  String get chatsTypingPlaceholder => 'Typing...';

  @override
  String get chatsVoicePlaceholder => 'Voice message';

  @override
  String get chatsVoiceStart => 'Start recording';

  @override
  String get chatsVoiceStopAndSend => 'Stop and send';

  @override
  String get chatsVoicePlaceholderButton => 'Voice';

  @override
  String get chatsAttachmentPlaceholder =>
      'Attachment upload flow will be available in the next iteration.';

  @override
  String get chatsAttachmentPlaceholderButton => 'Attach';

  @override
  String get financeTitle => 'Finance';

  @override
  String get financePlaceholder =>
      'Budget controls, approvals, and cost analytics will be added to this module.';

  @override
  String get financeHeadline => 'Finance Control Center';

  @override
  String get financeSubtitle =>
      'Track personal and project expenses, income, and remaining budget automatically.';

  @override
  String get financePersonalExpenses => 'Personal expenses';

  @override
  String get financeProjectExpenses => 'Project expenses';

  @override
  String get financeIncome => 'Income';

  @override
  String get financeRemainingBudget => 'Remaining budget';

  @override
  String get financeChartsPlaceholder => 'Charts placeholder';

  @override
  String get financeChartsPlaceholderDescription =>
      'Cashflow, burn-rate, and variance charts will be added here.';

  @override
  String get financeExpenseHistory => 'Expense history';

  @override
  String get companyTitle => 'Company Management';

  @override
  String get companyContacts => 'Company contacts';

  @override
  String get companyNotFound => 'Company not found';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get documentsHeadline => 'Document Management';

  @override
  String get documentsSubtitle =>
      'Organize folders, categories, and recent project files.';

  @override
  String get documentsFolders => 'Folders';

  @override
  String get documentsRecent => 'Recent documents';

  @override
  String get documentsPdfPlaceholder => 'PDF preview placeholder';

  @override
  String get documentsDwgPlaceholder => 'DWG preview placeholder';

  @override
  String get documentsExcelPlaceholder => 'Excel preview placeholder';

  @override
  String get documentsOpenPlaceholder =>
      'Open workflow will be available in a connected backend phase.';

  @override
  String get photoReportsTitle => 'Photo Reports';

  @override
  String get photoReportsHeadline => 'Site Photo Reports';

  @override
  String get photoReportsSubtitle =>
      'Track albums with before/after evidence by employee and project.';

  @override
  String get photoReportsDate => 'Date';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsCenter => 'Notification Center';

  @override
  String get notificationsSubtitle =>
      'Task reminders, project updates, and finance alerts in one place.';

  @override
  String get notificationsTaskReminders => 'Task reminder';

  @override
  String get notificationsProjectUpdates => 'Project update';

  @override
  String get notificationsFinanceAlerts => 'Finance alert';

  @override
  String get notificationsEmployeeAlerts => 'Employee alert';

  @override
  String get notificationsSystemAlerts => 'System alert';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileHeadline => 'Profile Settings';

  @override
  String get profileDescription =>
      'Manage personal preferences and interface language.';

  @override
  String get profileManagerName => 'Aruzhan Tolegen';

  @override
  String get languageSectionTitle => 'Application Language';

  @override
  String get languageSectionSubtitle =>
      'Select a language. Changes apply instantly.';

  @override
  String get languageSelectLabel => 'Language';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageKazakh => 'Kazakh';

  @override
  String get languageEnglish => 'English';

  @override
  String get splashTagline => 'Enterprise-grade construction management';

  @override
  String get loginWelcomeBack => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to continue to ACM.';

  @override
  String get loginSideTitle => 'One Construction Command Center';

  @override
  String get loginSideSubtitle =>
      'Plan projects, coordinate teams, and control budgets in one place.';

  @override
  String get commonEmail => 'Email';

  @override
  String get commonPhone => 'Phone';

  @override
  String get commonPassword => 'Password';

  @override
  String get loginRememberMe => 'Remember me';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginForgotPasswordInfo =>
      'Password recovery will be available in the next release.';

  @override
  String get loginRoleLabel => 'Role';

  @override
  String get loginButton => 'Sign In';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsHeadline => 'Application Settings';

  @override
  String get settingsSubtitle =>
      'Control appearance, language, notifications, and security options.';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Allow task reminders, project updates, and finance alerts.';

  @override
  String get settingsSecurity => 'Security';

  @override
  String get settingsSecuritySubtitle =>
      'Require local security checks for sensitive actions.';

  @override
  String get employeesTitle => 'Employees';

  @override
  String get employeesHeadline => 'Employee Management';

  @override
  String get employeesSubtitle =>
      'Monitor team availability, roles, and project assignments.';

  @override
  String get employeesNoResults => 'No employees match your criteria';

  @override
  String get employeesSearchHint =>
      'Search employees by name, phone, or project';

  @override
  String get employeeDetailsTitle => 'Employee Details';

  @override
  String get employeeNotFound => 'Employee not found';

  @override
  String employeeContactReady(String name) {
    return 'Contact action for $name is ready.';
  }

  @override
  String get employeeTaskSummaryTitle => 'Task Summary';

  @override
  String get employeeAssignedTasks => 'Assigned tasks';

  @override
  String get employeeCompletedTasks => 'Completed tasks';

  @override
  String get employeePersonalNotes => 'Personal Notes';

  @override
  String get statusOnline => 'Online';

  @override
  String get statusOffline => 'Offline';

  @override
  String get filterRoleLabel => 'Role';

  @override
  String get filterAllRoles => 'All roles';

  @override
  String get filterSortByLabel => 'Sort by';

  @override
  String get sortOnlineFirst => 'Online first';

  @override
  String get sortAlphabetically => 'Alphabetically';

  @override
  String get sortByPosition => 'By position';

  @override
  String get roleDirector => 'Director';

  @override
  String get roleProjectManager => 'Project Manager';

  @override
  String get roleSiteEngineer => 'Site Engineer';

  @override
  String get roleForeman => 'Foreman';

  @override
  String get roleSurveyor => 'Surveyor';

  @override
  String get roleSafetyEngineer => 'Safety Engineer';

  @override
  String get roleAccountant => 'Accountant';

  @override
  String get roleStorekeeper => 'Storekeeper';

  @override
  String get roleWorker => 'Worker';

  @override
  String get projectsTitle => 'Projects';

  @override
  String get projectsHeadline => 'Construction Projects';

  @override
  String get projectsSubtitle =>
      'Track project health, budget, timelines, and field progress.';

  @override
  String get projectDetailsTitle => 'Project Details';

  @override
  String get projectNotFound => 'Project not found';

  @override
  String get newProjectTitle => 'New Project';

  @override
  String get newProjectHeadline => 'Create Project';

  @override
  String get newProjectSubtitle =>
      'Define scope, timeline, and budget to initialize a project workspace.';

  @override
  String get projectFieldName => 'Project Name';

  @override
  String get projectFieldClient => 'Client';

  @override
  String get projectFieldAddress => 'Address';

  @override
  String get projectCreateButton => 'Create Project';

  @override
  String get projectSelectDatesError => 'Please select start and end dates.';

  @override
  String get projectEndDateError => 'End date must be after start date.';

  @override
  String get projectBudgetValidationError => 'Enter a valid budget amount.';

  @override
  String get projectCreatedLocalInfo =>
      'Project draft created locally (mock flow).';

  @override
  String get projectInformationTitle => 'Project Information';

  @override
  String get projectProgressStageTitle => 'Progress and Current Stage';

  @override
  String projectCompletedValue(String value) {
    return '$value completed';
  }

  @override
  String get projectCurrentStage => 'Current stage';

  @override
  String get projectWeatherActivityTitle => 'Weather and Last Activity';

  @override
  String get projectStatusPlanning => 'Planning';

  @override
  String get projectStatusOnTrack => 'On Track';

  @override
  String get projectStatusAtRisk => 'At Risk';

  @override
  String get projectStatusDelayed => 'Delayed';

  @override
  String get projectStatusCompleted => 'Completed';

  @override
  String get tabOverview => 'Overview';

  @override
  String get tabTasks => 'Tasks';

  @override
  String get tabEmployees => 'Employees';

  @override
  String get tabDocuments => 'Documents';

  @override
  String get tabPhotos => 'Photos';

  @override
  String get tabFinance => 'Finance';

  @override
  String get projectTabTasksPlaceholder =>
      'Task planning, dependencies, and key project milestones.';

  @override
  String get projectTabEmployeesPlaceholder =>
      'Assigned site team and labor allocation by object.';

  @override
  String get projectTabDocumentsPlaceholder =>
      'Contracts, permits, and project files for the site.';

  @override
  String get projectTabPhotosPlaceholder => 'Field progress photo timeline.';

  @override
  String get projectTabFinancePlaceholder =>
      'Project cost control, invoices, and payment schedules.';

  @override
  String get tasksTitle => 'Tasks';

  @override
  String get tasksHeadline => 'Task Management';

  @override
  String get tasksSubtitle =>
      'Plan, assign, and monitor construction execution tasks.';

  @override
  String get tasksNoResults => 'No tasks found for selected filters';

  @override
  String get newTaskTitle => 'New Task';

  @override
  String get newTaskHeadline => 'Create Task';

  @override
  String get newTaskSubtitle =>
      'Define scope, ownership, cost, and schedule for a construction task.';

  @override
  String get taskAssignEmployee => 'Assign Employee';

  @override
  String get taskEstimatedCost => 'Estimated Cost';

  @override
  String get taskCreateButton => 'Create Task';

  @override
  String get taskSelectDatesError => 'Please select start and deadline dates.';

  @override
  String get taskDeadlineAfterStartError =>
      'Deadline should be after start date.';

  @override
  String get taskCostValidationError => 'Enter a valid cost.';

  @override
  String get taskCreatedLocalInfo => 'Task created locally (mock flow).';

  @override
  String get taskAttachPhotos => 'Attach Photos';

  @override
  String get taskAttachPhotosPlaceholder =>
      'Open photo reports to add task images.';

  @override
  String get taskAttachDocuments => 'Attach Documents';

  @override
  String get taskAttachDocumentsPlaceholder =>
      'Open documents to add drawings and files.';

  @override
  String get taskAttachButton => 'Attach';

  @override
  String taskAttachmentInfoAction(String title) {
    return '$title section opened locally.';
  }

  @override
  String get taskDetailsTitle => 'Task Details';

  @override
  String get taskNotFound => 'Task not found';

  @override
  String taskDeadlineValue(String date) {
    return 'Deadline $date';
  }

  @override
  String get taskFullDescription => 'Full Description';

  @override
  String get taskAssignedEmployees => 'Assigned Employees';

  @override
  String get taskComments => 'Comments';

  @override
  String get taskActivityHistory => 'Activity History';

  @override
  String get taskBeforePhotos => 'Before Photos';

  @override
  String get taskAfterPhotos => 'After Photos';

  @override
  String get taskChangeStatus => 'Change Status';

  @override
  String taskStatusChangedLocal(String status) {
    return 'Status changed to $status (local mock).';
  }

  @override
  String get taskPriorityLow => 'Low';

  @override
  String get taskPriorityMedium => 'Medium';

  @override
  String get taskPriorityHigh => 'High';

  @override
  String get taskPriorityCritical => 'Critical';

  @override
  String get taskStatusNotStarted => 'Not Started';

  @override
  String get taskStatusInProgress => 'In Progress';

  @override
  String get taskStatusWaiting => 'Waiting';

  @override
  String get taskStatusCompleted => 'Completed';

  @override
  String get filterAllProjects => 'All projects';

  @override
  String get filterAllEmployees => 'All employees';

  @override
  String get filterAllStatuses => 'All statuses';

  @override
  String get filterAllPriorities => 'All priorities';

  @override
  String get filterSortLabel => 'Sort';

  @override
  String get sortRecentlyUpdated => 'Recently Updated';

  @override
  String get commonTitle => 'Title';

  @override
  String get commonDescription => 'Description';

  @override
  String get commonProject => 'Project';

  @override
  String get commonEmployee => 'Employee';

  @override
  String get commonStatus => 'Status';

  @override
  String get commonPriority => 'Priority';

  @override
  String get commonDeadline => 'Deadline';

  @override
  String get commonStartDate => 'Start Date';

  @override
  String get commonEndDate => 'End Date';

  @override
  String get commonSelectDate => 'Select date';

  @override
  String get commonBudget => 'Budget';

  @override
  String get commonEmployees => 'Employees';

  @override
  String get commonRemainingBudget => 'Remaining budget';

  @override
  String get commonTimeline => 'Timeline';

  @override
  String get commonWeather => 'Weather';

  @override
  String get commonLastActivity => 'Last activity';

  @override
  String get commonRecentUpdates => 'Recent Updates';

  @override
  String get commonContact => 'Contact';

  @override
  String get commonProgress => 'Progress';

  @override
  String commonProgressValue(String value) {
    return 'Progress $value';
  }

  @override
  String get commonNoItemsYet => 'No items available yet.';

  @override
  String taskEstimatedCostValue(String cost) {
    return 'Estimated cost: $cost';
  }

  @override
  String get chatsSearchLabel => 'Search chats and users';

  @override
  String get chatsNoResults => 'No chats found';

  @override
  String get chatsEmojiPlaceholder => 'Emoji and stickers';

  @override
  String get chatsImagePlaceholder =>
      'Image sending will be available in the next iteration.';

  @override
  String get chatsCreateDirectPlaceholder =>
      'Direct chat creation flow will be available in the next iteration.';

  @override
  String get chatCreateDirectTitle => 'Direct Chat';

  @override
  String get chatCreateGroupTitle => 'Create Group';

  @override
  String get chatCreateGroupButton => 'New Group';

  @override
  String get chatGroupCreatedPlaceholder => 'Group created in local mock mode.';

  @override
  String get chatGroupNameLabel => 'Group name';

  @override
  String get chatSearchUsersLabel => 'Search members';

  @override
  String get chatAddMembersTitle => 'Add members';

  @override
  String get chatAddMember => 'Add';

  @override
  String get chatRemoveMember => 'Remove';

  @override
  String get chatGroupAdmin => 'Group admin';

  @override
  String get chatInfoTitle => 'Chat Info';

  @override
  String get chatMessageInputPlaceholder => 'Type a message';

  @override
  String get chatSharedMediaPlaceholder => 'Shared media';

  @override
  String get chatSharedMediaDescription =>
      'Photos and files will appear after backend integration.';

  @override
  String get chatReactionsPlaceholder => 'Reactions and replies';

  @override
  String get chatReactionsDescription =>
      'Reaction summary will be available in the next sprint.';

  @override
  String get chatPin => 'Pin chat';

  @override
  String get chatUnpin => 'Unpin chat';

  @override
  String get chatArchive => 'Archive chat';

  @override
  String get chatUnarchive => 'Unarchive chat';

  @override
  String get chatMuteNotifications => 'Mute notifications';

  @override
  String get chatUnmute => 'Unmute notifications';

  @override
  String get chatDelete => 'Delete chat';

  @override
  String get chatDeletePlaceholder =>
      'Chat deletion will require backend-side confirmation.';

  @override
  String get chatMarkRead => 'Mark as read';

  @override
  String get chatNotFound => 'Chat not found';

  @override
  String get chatMembersTitle => 'Members';

  @override
  String chatMembersCount(int count) {
    return 'Members: $count';
  }

  @override
  String chatLastSeen(String value) {
    return 'Last seen: $value';
  }

  @override
  String get chatShowArchived => 'Show archived';

  @override
  String get chatHideArchived => 'Hide archived';

  @override
  String get commonBackToChat => 'Back to chat';

  @override
  String get settingsGeneralSection => 'General';

  @override
  String get settingsAppearanceSection => 'Appearance';

  @override
  String get settingsNotificationsSection => 'Notifications';

  @override
  String get settingsSecuritySection => 'Security';

  @override
  String get settingsApplicationSection => 'Application';

  @override
  String get settingsSupportSection => 'Support';

  @override
  String get settingsDateFormat => 'Date format';

  @override
  String get settingsTimeFormat => 'Time format';

  @override
  String get settingsDateFormatDmy => 'DD.MM.YYYY';

  @override
  String get settingsDateFormatMdy => 'MM/DD/YYYY';

  @override
  String get settingsDateFormatYmd => 'YYYY-MM-DD';

  @override
  String get settingsTimeFormat24 => '24-hour';

  @override
  String get settingsTimeFormat12 => '12-hour';

  @override
  String get settingsPushNotifications => 'Push notifications';

  @override
  String get settingsChatNotifications => 'Chat notifications';

  @override
  String get settingsTaskNotifications => 'Task notifications';

  @override
  String get settingsFinanceNotifications => 'Finance notifications';

  @override
  String get settingsPinCode => 'PIN code';

  @override
  String get settingsBiometric => 'Biometric';

  @override
  String get settingsAutoLock => 'Auto lock';

  @override
  String get settingsChangePassword => 'Change password';

  @override
  String get settingsSecurityPlaceholder =>
      'Password change will be available after identity service integration.';

  @override
  String get settingsCache => 'Clear cache';

  @override
  String get settingsStorage => 'Storage usage';

  @override
  String get settingsPrivacyMode => 'Privacy mode';

  @override
  String get settingsPrivacyModeSubtitle =>
      'Hide sensitive values in lists and cards.';

  @override
  String get settingsAnalytics => 'Anonymous analytics';

  @override
  String get settingsAnalyticsSubtitle =>
      'Help improve product quality with anonymous telemetry.';

  @override
  String get settingsAccessibilityHighContrast => 'High contrast';

  @override
  String get settingsAccessibilityReduceMotion => 'Reduce motion';

  @override
  String get settingsDataSaver => 'Data saver';

  @override
  String get settingsBackup => 'Backup';

  @override
  String get settingsBackupPlaceholder => 'Backup and restore placeholder.';

  @override
  String get settingsExportData => 'Export data';

  @override
  String get settingsAboutApp => 'About app';

  @override
  String get settingsPrivacyPolicy => 'Privacy policy';

  @override
  String get settingsTerms => 'Terms of service';

  @override
  String get settingsHelpCenter => 'Help center';

  @override
  String get settingsContactSupport => 'Contact support';

  @override
  String get settingsSendFeedback => 'Send feedback';

  @override
  String get settingsActionPlaceholder =>
      'Action will be available in the next integration phase.';

  @override
  String get profileRoleLabel => 'Role';

  @override
  String get profilePositionLabel => 'Position';

  @override
  String get profileDepartmentLabel => 'Department';

  @override
  String get profileCompanyLabel => 'Company';

  @override
  String get profileCoverPlaceholder => 'Cover image placeholder';

  @override
  String get profileStatsTitle => 'Statistics';

  @override
  String get profileAchievementsTitle => 'Achievements';

  @override
  String get profileAchievementsPlaceholder =>
      'Achievements showcase placeholder.';

  @override
  String get profileRecentActivityTitle => 'Recent Activity';

  @override
  String get profileRecentActivityPlaceholder =>
      'Recent profile activity placeholder.';

  @override
  String get profileNotificationStatus => 'Notification status';

  @override
  String get profileSecurityStatus => 'Security status';

  @override
  String get profileAboutTitle => 'About';

  @override
  String get profileVersionTitle => 'Version';

  @override
  String get profileVersionValue => '1.0.0-enterprise';

  @override
  String get profileNotificationEnabled => 'Enabled';

  @override
  String get profileNotificationDisabled => 'Disabled';

  @override
  String get profileSecurityEnabled => 'Local protection enabled';

  @override
  String get profileSecurityDisabled => 'Local protection disabled';

  @override
  String get profileAboutDescription =>
      'ACM unifies project, task, communication, and finance management for construction teams.';

  @override
  String get statProjects => 'Projects';

  @override
  String get statEmployees => 'Employees';

  @override
  String get statTasksToday => 'Tasks today';

  @override
  String get statCompletedTasks => 'Completed tasks';

  @override
  String get statPendingTasks => 'Pending tasks';

  @override
  String get statOverdueTasks => 'Overdue tasks';

  @override
  String get statProjectProgress => 'Project progress';

  @override
  String get statExpenses => 'Expenses';

  @override
  String get statIncome => 'Income';

  @override
  String get statMonthlyExpenses => 'Monthly expenses';

  @override
  String get statMonthlyIncome => 'Monthly income';

  @override
  String get tabChat => 'Chat';

  @override
  String get tabReports => 'Reports';

  @override
  String get projectTabChatPlaceholder =>
      'Project communication stream and discussion threads.';

  @override
  String get projectTabReportsPlaceholder =>
      'Project reports, inspections, and executive summaries.';

  @override
  String get taskStatusInspection => 'Inspection';

  @override
  String get tasksListMode => 'List';

  @override
  String get tasksKanbanMode => 'Kanban';

  @override
  String get kanbanDropTasksHere => 'Drop tasks here';

  @override
  String get kanbanReleaseToMove => 'Release to move task';

  @override
  String get kanbanPlanned => 'Planned';

  @override
  String get kanbanInProgress => 'In Progress';

  @override
  String get kanbanWaiting => 'Waiting';

  @override
  String get kanbanInspection => 'Inspection';

  @override
  String get kanbanCompleted => 'Completed';

  @override
  String get reportsModuleTitle => 'Construction Reports';

  @override
  String get reportsModuleHeadline => 'Project Reporting Center';

  @override
  String get reportsModuleSubtitle =>
      'Track performance, quality, safety, and budget results in one view.';

  @override
  String get reportsWeeklyProgress => 'Weekly progress';

  @override
  String get reportsSafetyChecks => 'Safety checks';

  @override
  String get reportsBudgetDeviation => 'Budget deviation';

  @override
  String get reportsQualityScore => 'Quality score';

  @override
  String get reportsChartsPlaceholderTitle => 'Chart summary';

  @override
  String get reportsChartsPlaceholderSubtitle =>
      'S-curve, productivity, and quality trends across projects.';

  @override
  String get reportsExportPlaceholderTitle => 'Report export';

  @override
  String get reportsExportPlaceholderSubtitle =>
      'PDF/XLS export for the selected range and project.';

  @override
  String get globalSearchTitle => 'Global Search';

  @override
  String get globalSearchHint =>
      'Search projects, employees, tasks, chats, documents';

  @override
  String get globalSearchStartTyping => 'Start typing to search';

  @override
  String get globalSearchNoResults => 'No results found';

  @override
  String globalSearchPhotosCount(int count) {
    return 'Photos: $count';
  }

  @override
  String get dashboardWidgetsTitle => 'Operational Widgets';

  @override
  String get dashboardWeatherTitle => 'Current weather';

  @override
  String get dashboardWeatherPlaceholder => 'Weather placeholder';

  @override
  String get dashboardTodayTasksTitle => 'Today\'s tasks';

  @override
  String get dashboardRecentMessagesTitle => 'Recent messages';

  @override
  String get dashboardRecentExpensesTitle => 'Recent expenses';

  @override
  String get dashboardProjectProgressTitle => 'Project progress';

  @override
  String get dashboardEmployeesOnlineTitle => 'Employees online';

  @override
  String get dashboardChartsPlaceholderTitle => 'Charts';

  @override
  String get dashboardChartsPlaceholderSubtitle =>
      'S-curve and progress charts placeholder';

  @override
  String get dashboardQuickActionsHint => 'Open key modules quickly';

  @override
  String get photoReportsCreateAlbum => 'Create album';

  @override
  String get photoReportsDescriptionPlaceholder =>
      'Photo report description placeholder';

  @override
  String get photoReportsLocationPlaceholder => 'Location placeholder';

  @override
  String get photoReportsAddPhotoPlaceholder =>
      'Photo adding flow is placeholder-only in this stage.';

  @override
  String get photoReportsTaskLabel => 'Task';

  @override
  String get photoReportsTimeLabel => 'Time';

  @override
  String get photoReportsLocationLabel => 'Location';

  @override
  String get photoReportsAddBefore => 'Add before';

  @override
  String get photoReportsAddAfter => 'Add after';

  @override
  String get photoReportsDeleteBefore => 'Delete before';

  @override
  String get photoReportsDeleteAfter => 'Delete after';

  @override
  String get photoReportsPreviewTitle => 'Preview photos';

  @override
  String get documentsCategoryLabel => 'Category';

  @override
  String get documentsDateLabel => 'Date';

  @override
  String get documentsAuthorLabel => 'Author';

  @override
  String get documentsSizeLabel => 'Size';

  @override
  String get documentsVersionLabel => 'Version';

  @override
  String get financeExpensesLabel => 'Expenses';

  @override
  String get financeNetLabel => 'Net result';

  @override
  String get financeCategoriesTitle => 'Category breakdown';

  @override
  String get financeMonthlySummaryTitle => 'Monthly summary';

  @override
  String get financeFuelLabel => 'Fuel';

  @override
  String get financeEquipmentLabel => 'Equipment';

  @override
  String get financeMaterialsLabel => 'Materials';

  @override
  String get financeWorkersLabel => 'Workers';

  @override
  String get financeTransportLabel => 'Transport';

  @override
  String get financeOtherLabel => 'Other';

  @override
  String get employeeAssignedProjectsTitle => 'Assigned projects';

  @override
  String get employeeAssignedTasksTitle => 'Assigned tasks';

  @override
  String get employeeCompletedTasksTitle => 'Completed tasks';

  @override
  String get employeePerformanceTitle => 'Performance';

  @override
  String get employeeAttendancePlaceholderTitle => 'Active tasks';

  @override
  String get employeeAttendancePlaceholderSubtitle =>
      'Current workload for the employee.';

  @override
  String get employeeWorkingHoursPlaceholderTitle => 'Working hours';

  @override
  String get employeeWorkingHoursPlaceholderSubtitle =>
      'Working-hours integration placeholder.';

  @override
  String get adminTitle => 'Administration';

  @override
  String get adminTabOverview => 'Overview';

  @override
  String get adminTabCompany => 'Company';

  @override
  String get adminTabRbac => 'RBAC';

  @override
  String get adminTabManagement => 'Management';

  @override
  String get adminTabActivity => 'Activity';

  @override
  String get adminOverviewHeadline => 'Enterprise Admin Panel';

  @override
  String get adminOverviewSubtitle =>
      'Manage companies, roles, projects, departments and compliance controls.';

  @override
  String get adminDepartmentsTitle => 'Departments';

  @override
  String get adminTeamsTitle => 'Teams';

  @override
  String get adminRolesTitle => 'Roles';

  @override
  String get adminOrganizationStructure => 'Organization Structure';

  @override
  String get adminCompanySettingsTitle => 'Company Settings';

  @override
  String get adminCompanyLogo => 'Company Logo';

  @override
  String get adminCompanyName => 'Company Name';

  @override
  String get adminCompanyBin => 'BIN';

  @override
  String get adminCompanyWebsite => 'Website';

  @override
  String get adminCompanyWorkingHours => 'Working Hours';

  @override
  String get adminCompanyTimezone => 'Timezone';

  @override
  String get adminCompanyCurrency => 'Currency';

  @override
  String get adminCompanyMeasurement => 'Measurement System';

  @override
  String get adminSuspendCompany => 'Suspend Company';

  @override
  String get adminSuspendCompanySubtitle =>
      'Temporarily restrict all company operations.';

  @override
  String get adminCreateCompany => 'Create Company';

  @override
  String get adminEditCompany => 'Edit Company';

  @override
  String get adminDeleteCompany => 'Delete Company';

  @override
  String get adminActionCompanyCreated => 'Company created (mock).';

  @override
  String get adminActionCompanyUpdated => 'Company updated (mock).';

  @override
  String get adminActionCompanyDeleted => 'Company deleted (mock).';

  @override
  String get adminRbacTitle => 'Role Based Access Control';

  @override
  String get adminRbacSubtitle =>
      'Configure permissions for each enterprise role.';

  @override
  String get adminResetPermissions => 'Reset permissions';

  @override
  String get adminSavePermissions => 'Save permissions';

  @override
  String get adminActionRoleReset => 'Role permissions reset to template.';

  @override
  String get adminActionRoleSaved => 'Role permissions saved (mock).';

  @override
  String get adminCreateProjects => 'Create Projects';

  @override
  String get adminCreateProjectsSubtitle =>
      'Create and launch new project workspaces.';

  @override
  String get adminArchiveProjects => 'Archive Projects';

  @override
  String get adminArchiveProjectsSubtitle =>
      'Move completed projects to archive.';

  @override
  String get adminActionProjectCreated => 'Project created (mock).';

  @override
  String get adminManagementModules => 'Management Modules';

  @override
  String get adminOpen => 'Open';

  @override
  String get adminActionOpened => 'opened';

  @override
  String get adminActivityTitle => 'Activity History';

  @override
  String get adminActivitySubtitle =>
      'Track all critical operations across enterprise modules.';

  @override
  String get adminRoleOwner => 'Owner';

  @override
  String get adminRoleAdministrator => 'Administrator';

  @override
  String get adminRoleViewer => 'Viewer';

  @override
  String get adminPermissionViewProjects => 'Can View Projects';

  @override
  String get adminPermissionEditProjects => 'Can Edit Projects';

  @override
  String get adminPermissionDeleteProjects => 'Can Delete Projects';

  @override
  String get adminPermissionCreateTasks => 'Can Create Tasks';

  @override
  String get adminPermissionCompleteTasks => 'Can Complete Tasks';

  @override
  String get adminPermissionViewFinance => 'Can View Finance';

  @override
  String get adminPermissionEditFinance => 'Can Edit Finance';

  @override
  String get adminPermissionUploadDocuments => 'Can Upload Documents';

  @override
  String get adminPermissionDeleteDocuments => 'Can Delete Documents';

  @override
  String get adminPermissionManageEmployees => 'Can Manage Employees';

  @override
  String get adminPermissionManageChats => 'Can Manage Chats';

  @override
  String get adminPermissionManageReports => 'Can Manage Reports';

  @override
  String get adminPermissionManageSettings => 'Can Manage Settings';

  @override
  String get homeSummarySection => 'Summary';

  @override
  String get tasksTabAll => 'All';

  @override
  String get tasksTabMine => 'Mine';

  @override
  String get tasksTabInProgress => 'Active';

  @override
  String get tasksTabCompleted => 'Done';

  @override
  String get tasksTabKanban => 'Kanban';

  @override
  String get tasksFiltersTitle => 'Filters';

  @override
  String get chatGroupAvatarTitle => 'Group avatar';

  @override
  String get chatGroupAvatarSubtitle =>
      'Avatar picker will be connected after media storage integration.';

  @override
  String get chatLeaveGroup => 'Leave group';

  @override
  String get chatAvatarActionPlaceholder =>
      'Avatar action will be available in connected mode.';

  @override
  String get chatChangeAvatar => 'Change';

  @override
  String get profilePositionValue => 'Senior Project Manager';

  @override
  String get profileDepartmentValue => 'Project Office';

  @override
  String get profileCompanyValue => 'ACM Control Center';

  @override
  String get profilePhoneValue => '+7 777 450 22 11';

  @override
  String get profileEmailValue => 'manager@structra-group.com';

  @override
  String get enterpriseCalendarTitle => 'Calendar';

  @override
  String get enterpriseCalendarViewDaily => 'Daily';

  @override
  String get enterpriseCalendarViewWeekly => 'Weekly';

  @override
  String get enterpriseCalendarViewMonthly => 'Monthly';

  @override
  String get enterpriseCalendarCardTitle => 'Enterprise Calendar';

  @override
  String get enterpriseCalendarCardSubtitle =>
      'Task, project, and employee schedules';

  @override
  String get enterpriseCalendarCardDescription =>
      'Meeting and shift schedules are shown as realistic construction timeline events.';

  @override
  String get enterpriseDrawingsTitle => 'Drawings';

  @override
  String get enterpriseDrawingsCardTitle => 'Drawings Module';

  @override
  String get enterpriseDrawingsCardSubtitle =>
      'DWG, PDF, blueprints, 3D models, and specifications';

  @override
  String get enterpriseDrawingsCardDescription =>
      'Enterprise drawing registry with revision and approval controls.';

  @override
  String get enterpriseDrawingsAuthorLabel => 'Author';

  @override
  String get enterpriseDrawingsActionsLabel =>
      'Preview available • Download available • Comments and revision history';

  @override
  String get enterpriseEquipmentTitle => 'Equipment';

  @override
  String get enterpriseEquipmentCardTitle => 'Equipment Management';

  @override
  String get enterpriseEquipmentCardSubtitle =>
      'Status, assignment, and maintenance lifecycle';

  @override
  String get enterpriseEquipmentCardDescription =>
      'Track fuel usage and inspection state on each equipment unit.';

  @override
  String get enterpriseEquipmentSerialLabel => 'Serial';

  @override
  String get enterpriseEquipmentMaintenanceLabel => 'Maintenance';

  @override
  String get enterpriseEquipmentFuelLabel => 'Fuel usage tracked';

  @override
  String get enterpriseEquipmentInspectionLabel => 'Inspection scheduled';

  @override
  String get enterpriseVehiclesTitle => 'Vehicles';

  @override
  String get enterpriseVehiclesCardTitle => 'Vehicle Management';

  @override
  String get enterpriseVehiclesCardSubtitle =>
      'Fleet operations and service tracking';

  @override
  String get enterpriseVehiclesCardDescription =>
      'Operational fleet records include route state, service, and documents.';

  @override
  String get enterpriseVehiclesDriverLabel => 'Driver';

  @override
  String get enterpriseVehiclesMileageLabel => 'Mileage';

  @override
  String get enterpriseVehiclesFuelLabel => 'Fuel';

  @override
  String get enterpriseVehiclesMaintenanceLabel => 'Maintenance';

  @override
  String get enterpriseVehiclesDocumentsLabel => 'Documents are up to date';

  @override
  String get enterpriseWarehouseTitle => 'Warehouse';

  @override
  String get enterpriseWarehouseCardTitle => 'Warehouse';

  @override
  String get enterpriseWarehouseCardSubtitle =>
      'Materials, tools, and equipment inventory control';

  @override
  String get enterpriseWarehouseCardDescription =>
      'Incoming, outgoing, and stock movement are represented as realistic enterprise records.';

  @override
  String get enterpriseWarehouseCurrentLabel => 'Current';

  @override
  String get enterpriseWarehouseMinimumLabel => 'Minimum';

  @override
  String get enterpriseWarehouseIncomingLabel => 'Incoming';

  @override
  String get enterpriseWarehouseOutgoingLabel => 'Outgoing';

  @override
  String get enterpriseWarehouseHistoryLabel => 'Movement history available';

  @override
  String get reportsDailyReportLabel => 'Daily report';

  @override
  String get reportsWeeklyReportLabel => 'Weekly report';

  @override
  String get reportsMonthlyReportLabel => 'Monthly report';

  @override
  String get reportsEmployeeReportLabel => 'Employee report';

  @override
  String get reportsFinanceReportLabel => 'Finance report';

  @override
  String get reportsProjectReportLabel => 'Project report';

  @override
  String get reportsPhotoReportLabel => 'Photo report';

  @override
  String get reportsProgressReportLabel => 'Progress report';

  @override
  String get financeDialogAddTitle => 'Add finance entry';

  @override
  String get financeDialogEditTitle => 'Edit finance entry';

  @override
  String get financeTypeExpense => 'Expense';

  @override
  String get financeTypeIncome => 'Income';

  @override
  String get financeFieldAmount => 'Amount';

  @override
  String get financeFieldCategory => 'Category';

  @override
  String get financeFieldPaymentMethod => 'Payment Method';

  @override
  String get financeFieldReceipt => 'Receipt';

  @override
  String get financeAccountEditTitle => 'Edit personal account';

  @override
  String get financeAddEntryButton => 'Add entry';

  @override
  String get financeSectionAccessControl => 'Access and currency';

  @override
  String get financeActiveUserLabel => 'Active user';

  @override
  String get financePrivacyNote =>
      'Only data for the selected user is shown in this local mode.';

  @override
  String get financeCurrencyLabel => 'Currency';

  @override
  String get financeCurrencyKzt => 'Tenge (KZT)';

  @override
  String get financeCurrencyUsd => 'US Dollar (USD)';

  @override
  String get financeCurrencyEur => 'Euro (EUR)';

  @override
  String get financeSectionPersonalAccount => 'Personal Finance Account';

  @override
  String get financeMetricPersonalBalance => 'Personal Balance';

  @override
  String get financeMetricCash => 'Cash';

  @override
  String get financeMetricCard => 'Card';

  @override
  String get financeMetricWallet => 'Wallet';

  @override
  String get financeMetricRemainingBalance => 'Remaining Balance';

  @override
  String get financeSectionStatistics => 'Statistics';

  @override
  String get financeStatTotalIncome => 'Total Income';

  @override
  String get financeStatTotalExpenses => 'Total Expenses';

  @override
  String get financeStatMonthlyExpenses => 'Monthly Expenses';

  @override
  String get financeStatWeeklyExpenses => 'Weekly Expenses';

  @override
  String get financeSectionSearchFilters => 'Search & Filters';

  @override
  String get financeSearchHint => 'Search by description, project, or category';

  @override
  String get financeFilterCategory => 'Category Filter';

  @override
  String get financeFilterPaymentMethod => 'Payment Method Filter';

  @override
  String get financeFilterProject => 'Project Filter';

  @override
  String get financeAllCategories => 'All categories';

  @override
  String get financeAllMethods => 'All methods';

  @override
  String get financeAllProjects => 'All projects';

  @override
  String get financeExportPlaceholderTitle => 'Export';

  @override
  String get financeExportPlaceholderSubtitle =>
      'PDF/XLS export of selected range will be available after backend integration.';

  @override
  String get financeNoEntries => 'No entries for selected filters';

  @override
  String get financeReceiptDefaultValue => 'Receipt reference';

  @override
  String get financePaymentCash => 'Cash';

  @override
  String get financePaymentCard => 'Card';

  @override
  String get financePaymentWallet => 'Wallet';

  @override
  String get financeFoodLabel => 'Food';

  @override
  String get financeAccommodationLabel => 'Accommodation';

  @override
  String get financeToolsLabel => 'Tools';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonDelete => 'Delete';

  @override
  String get validationRequired => 'This field is required.';
}
