import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/admin/presentation/screens/admin_panel_screen.dart';
import '../../features/chats/presentation/screens/chat_info_screen.dart';
import '../../features/chats/presentation/screens/chat_thread_screen.dart';
import '../../features/chats/presentation/screens/chats_screen.dart';
import '../../features/chats/presentation/screens/new_group_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/company/presentation/screens/company_details_screen.dart';
import '../../features/company/presentation/screens/company_screen.dart';
import '../../features/documents/presentation/screens/documents_screen.dart';
import '../../features/drawings/presentation/screens/drawings_screen.dart';
import '../../features/employees/presentation/screens/employee_details_screen.dart';
import '../../features/employees/presentation/screens/employees_screen.dart';
import '../../features/equipment/presentation/screens/equipment_screen.dart';
import '../../features/finance/presentation/screens/finance_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/home_shell_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/photo_reports/presentation/screens/photo_reports_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/projects/presentation/screens/new_project_screen.dart';
import '../../features/projects/presentation/screens/project_details_screen.dart';
import '../../features/projects/presentation/screens/projects_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/search/presentation/screens/global_search_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/tasks/presentation/screens/new_task_screen.dart';
import '../../features/tasks/presentation/screens/task_details_screen.dart';
import '../../features/tasks/presentation/screens/tasks_screen.dart';
import '../../features/vehicles/presentation/screens/vehicles_screen.dart';
import '../../features/warehouse/presentation/screens/warehouse_screen.dart';
import '../constants/app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _buildTransitionPage(
          state: state,
          child: const SplashScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _buildTransitionPage(
          state: state,
          child: const LoginScreen(),
        );
      },
    ),
    ShellRoute(
      builder: (
        BuildContext context,
        GoRouterState state,
        Widget child,
      ) {
        return HomeShellScreen(
          currentLocation: state.uri.path,
          child: child,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.globalSearch,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const GlobalSearchScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.chats,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const ChatsScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.newGroup,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const NewGroupScreen(),
            );
          },
        ),
        GoRoute(
          path: '${AppRoutes.chats}/:chatId',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final chatId = state.pathParameters['chatId'] ?? '';

            return _buildTransitionPage(
              state: state,
              child: ChatThreadScreen(chatId: chatId),
            );
          },
        ),
        GoRoute(
          path: '${AppRoutes.chats}/:chatId/info',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final chatId = state.pathParameters['chatId'] ?? '';

            return _buildTransitionPage(
              state: state,
              child: ChatInfoScreen(chatId: chatId),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.tasks,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const TasksScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.newTask,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const NewTaskScreen(),
            );
          },
        ),
        GoRoute(
          path: '${AppRoutes.tasks}/:taskId',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final taskId = state.pathParameters['taskId'] ?? '';

            return _buildTransitionPage(
              state: state,
              child: TaskDetailsScreen(taskId: taskId),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.finance,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const FinanceScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.profile,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const ProfileScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const SettingsScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.notifications,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const NotificationsScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.documents,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const DocumentsScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.photoReports,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const PhotoReportsScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.reports,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const ReportsScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.drawings,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const DrawingsScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.equipment,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const EquipmentScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.vehicles,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const VehiclesScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.warehouse,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const WarehouseScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.calendar,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const EnterpriseCalendarScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.admin,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const AdminPanelScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.company,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const CompanyScreen(),
            );
          },
        ),
        GoRoute(
          path: '${AppRoutes.company}/:companyId',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final companyId = state.pathParameters['companyId'] ?? '';

            return _buildTransitionPage(
              state: state,
              child: CompanyDetailsScreen(companyId: companyId),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.employees,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const EmployeesScreen(),
            );
          },
        ),
        GoRoute(
          path: '${AppRoutes.employees}/:employeeId',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final employeeId = state.pathParameters['employeeId'] ?? '';

            return _buildTransitionPage(
              state: state,
              child: EmployeeDetailsScreen(employeeId: employeeId),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.projects,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const ProjectsScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.newProject,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildTransitionPage(
              state: state,
              child: const NewProjectScreen(),
            );
          },
        ),
        GoRoute(
          path: '${AppRoutes.projects}/:projectId',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final projectId = state.pathParameters['projectId'] ?? '';

            return _buildTransitionPage(
              state: state,
              child: ProjectDetailsScreen(projectId: projectId),
            );
          },
        ),
      ],
    ),
  ],
);

CustomTransitionPage<void> _buildTransitionPage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return FadeTransition(
        opacity: curved,
        child: child,
      );
    },
  );
}
