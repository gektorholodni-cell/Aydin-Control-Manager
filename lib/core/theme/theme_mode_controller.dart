import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeController extends ChangeNotifier {
  ThemeModeController._();

  static const _storageKey = 'structra.theme_mode';
  static const ThemeMode _defaultThemeMode = ThemeMode.system;

  ThemeMode _themeMode = _defaultThemeMode;

  ThemeMode get themeMode => _themeMode;

  static Future<ThemeModeController> create() async {
    final controller = ThemeModeController._();
    await controller._load();
    return controller;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    _themeMode = _fromRaw(raw) ?? _defaultThemeMode;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) {
      return;
    }

    _themeMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, _toRaw(mode));
  }

  ThemeMode? _fromRaw(String? raw) {
    switch (raw) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }

  String _toRaw(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
