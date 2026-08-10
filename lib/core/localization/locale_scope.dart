import 'package:flutter/widgets.dart';

import 'locale_controller.dart';

class LocaleScope extends InheritedNotifier<LocaleController> {
  const LocaleScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static LocaleController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<LocaleScope>();

    assert(scope != null, 'LocaleScope not found in widget tree');
    return scope!.notifier!;
  }
}
