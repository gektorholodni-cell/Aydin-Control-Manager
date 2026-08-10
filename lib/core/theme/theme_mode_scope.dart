import 'package:flutter/widgets.dart';

import 'theme_mode_controller.dart';

class ThemeModeScope extends InheritedNotifier<ThemeModeController> {
  const ThemeModeScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static ThemeModeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeModeScope>();

    assert(scope != null, 'ThemeModeScope not found in widget tree');
    return scope!.notifier!;
  }
}
