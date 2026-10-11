import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:structra/core/app.dart';
import 'package:structra/core/constants/app_routes.dart';
import 'package:structra/core/localization/locale_controller.dart';
import 'package:structra/core/router/app_router.dart';
import 'package:structra/core/theme/theme_mode_controller.dart';

Future<void> _pumpApp(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues(<String, Object>{});
  final localeController = await LocaleController.create();
  final themeController = await ThemeModeController.create();

  await tester.pumpWidget(
    StructraApp(
      localeController: localeController,
      themeModeController: themeController,
    ),
  );

  await tester.pumpAndSettle(const Duration(milliseconds: 400));
}

void main() {
  testWidgets('Responsive smoke: key pages render without overflow on target sizes', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester);

    final sizes = <Size>[
      const Size(360, 800),
      const Size(390, 844),
      const Size(411, 891),
      const Size(430, 932),
      const Size(1024, 1366),
    ];

    final routes = <String>[
      AppRoutes.home,
      AppRoutes.chats,
      AppRoutes.tasks,
      AppRoutes.finance,
      AppRoutes.profile,
      AppRoutes.reports,
      AppRoutes.drawings,
      AppRoutes.equipment,
      AppRoutes.vehicles,
      AppRoutes.warehouse,
      AppRoutes.calendar,
    ];

    for (final size in sizes) {
      await tester.binding.setSurfaceSize(size);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      for (final route in routes) {
        tester.takeException();
        appRouter.go(route);
        await tester.pump(const Duration(milliseconds: 900));
        await tester.pump(const Duration(milliseconds: 400));
        expect(
          tester.takeException(),
          isNull,
          reason: 'Failed at ${size.width}x${size.height} on $route',
        );
      }
    }
  });

  testWidgets('Route smoke: all configured routes open without runtime exceptions', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester);

    final routes = <String>[
      AppRoutes.login,
      AppRoutes.home,
      AppRoutes.globalSearch,
      AppRoutes.chats,
      AppRoutes.newGroup,
      '${AppRoutes.chats}/missing-chat',
      '${AppRoutes.chats}/missing-chat/info',
      AppRoutes.tasks,
      AppRoutes.newTask,
      '${AppRoutes.tasks}/missing-task',
      AppRoutes.finance,
      AppRoutes.profile,
      AppRoutes.settings,
      AppRoutes.notifications,
      AppRoutes.documents,
      AppRoutes.photoReports,
      AppRoutes.reports,
      AppRoutes.drawings,
      AppRoutes.equipment,
      AppRoutes.vehicles,
      AppRoutes.warehouse,
      AppRoutes.calendar,
      AppRoutes.admin,
      AppRoutes.company,
      '${AppRoutes.company}/missing-company',
      AppRoutes.employees,
      '${AppRoutes.employees}/missing-employee',
      AppRoutes.projects,
      AppRoutes.newProject,
      '${AppRoutes.projects}/missing-project',
    ];

    for (final route in routes) {
      tester.takeException();
      appRouter.go(route);
      await tester.pump(const Duration(milliseconds: 700));
      expect(tester.takeException(), isNull, reason: 'Route failed: $route');
    }
  });

  testWidgets('Bottom navigation, dialogs, and forms respond', (WidgetTester tester) async {
    await _pumpApp(tester);

    appRouter.go(AppRoutes.home);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(NavigationDestination).at(1));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.byType(NavigationDestination).at(2));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.byType(NavigationDestination).at(3));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    appRouter.go(AppRoutes.finance);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);

    final dialogSave = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(FilledButton),
    );
    await tester.tap(dialogSave);
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsOneWidget);

    final dialogCancel = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextButton),
    );
    await tester.tap(dialogCancel.first);
    await tester.pumpAndSettle();

    appRouter.go(AppRoutes.profile);
    await tester.pump(const Duration(milliseconds: 700));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Home sections sheet and assistant respond', (WidgetTester tester) async {
    await _pumpApp(tester);
    await tester.binding.setSurfaceSize(const Size(400, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    appRouter.go(AppRoutes.home);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ещё'));
    await tester.pumpAndSettle();
    expect(find.text('Все разделы'), findsOneWidget);
    expect(find.text('Техподдержка'), findsOneWidget);
    Navigator.of(tester.element(find.text('Все разделы'))).pop();
    await tester.pumpAndSettle();

    appRouter.go(AppRoutes.assistant);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'помощь');
    await tester.tap(find.byIcon(Icons.arrow_upward));
    await tester.pumpAndSettle();
    expect(find.textContaining('Вот что я умею'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

}
