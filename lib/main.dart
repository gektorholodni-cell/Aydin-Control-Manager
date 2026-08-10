import 'package:flutter/widgets.dart';

import 'core/app.dart';
import 'core/localization/locale_controller.dart';
import 'core/theme/theme_mode_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localeController = await LocaleController.create();
  final themeModeController = await ThemeModeController.create();
  runApp(
    StructraApp(
      localeController: localeController,
      themeModeController: themeModeController,
    ),
  );
}
