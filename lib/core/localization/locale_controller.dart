import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  LocaleController._();

  static const _storageKey = 'structra.selected_locale';
  static const Locale _defaultLocale = Locale('ru');

  Locale _locale = _defaultLocale;

  Locale get locale => _locale;

  static Future<LocaleController> create() async {
    final controller = LocaleController._();
    await controller._load();
    return controller;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_storageKey);

    if (languageCode == null || languageCode.isEmpty) {
      _locale = _defaultLocale;
      return;
    }

    _locale = Locale(languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) {
      return;
    }

    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, locale.languageCode);
  }
}
