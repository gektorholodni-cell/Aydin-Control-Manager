import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:structra/core/app.dart';
import 'package:structra/core/localization/locale_controller.dart';
import 'package:structra/core/theme/theme_mode_controller.dart';
import 'package:structra/features/auth/presentation/screens/login_screen.dart';

void main() {
  testWidgets('App auto-navigates from splash to login', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final localeController = await LocaleController.create();
    final themeModeController = await ThemeModeController.create();
    await tester.pumpWidget(
      StructraApp(
        localeController: localeController,
        themeModeController: themeModeController,
      ),
    );

    expect(find.byType(StructraApp), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
