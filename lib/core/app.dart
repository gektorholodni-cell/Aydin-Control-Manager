import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:structra/l10n/app_localizations.dart';

import 'localization/locale_controller.dart';
import 'localization/locale_scope.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_mode_controller.dart';
import 'theme/theme_mode_scope.dart';

class StructraApp extends StatelessWidget {
  const StructraApp({
    required this.localeController,
    required this.themeModeController,
    super.key,
  });

  final LocaleController localeController;
  final ThemeModeController themeModeController;

  @override
  Widget build(BuildContext context) {
    return ThemeModeScope(
      notifier: themeModeController,
      child: LocaleScope(
        notifier: localeController,
        child: AnimatedBuilder(
          animation: Listenable.merge(<Listenable>[
            localeController,
            themeModeController,
          ]),
          builder: (BuildContext context, Widget? child) {
            return MaterialApp.router(
              onGenerateTitle: (BuildContext context) {
                return AppLocalizations.of(context).appTitle;
              },
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeModeController.themeMode,
              locale: localeController.locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              routerConfig: appRouter,
            );
          },
        ),
      ),
    );
  }
}
