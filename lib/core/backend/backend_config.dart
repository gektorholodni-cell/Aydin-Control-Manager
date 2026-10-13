/// Настройки облачного бэкенда (Supabase).
///
/// Значения передаются при сборке:
/// `flutter run --dart-define-from-file=config/supabase.json`.
/// Если URL или ключ пустые, приложение работает в демо-режиме
/// на локальных данных, как раньше.
abstract final class BackendConfig {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');

  /// Публичный ключ проекта: `sb_publishable_...` или старый `anon` ключ.
  /// Оба безопасно встраивать в приложение. Ключ `service_role`
  /// или `sb_secret_...` сюда класть нельзя.
  static const supabaseKey = String.fromEnvironment('SUPABASE_KEY');

  static bool get isCloudConfigured =>
      supabaseUrl.isNotEmpty && supabaseKey.isNotEmpty;
}
