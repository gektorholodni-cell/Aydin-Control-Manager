import 'package:flutter/foundation.dart';

import '../../../core/backend/cloud_backend.dart';
import '../../../core/constants/app_routes.dart';

/// Куда вести пользователя после входа в облачном режиме:
/// в настройку компании, если её ещё нет, иначе на главный экран
/// (предварительно загрузив данные компании).
Future<String> resolvePostSignInRoute() async {
  final backend = CloudBackend.instance;
  final membership = await backend.loadMembership();
  if (membership == null) {
    return AppRoutes.companySetup;
  }
  try {
    await backend.syncAll();
  } catch (error) {
    // Ошибка загрузки данных не должна мешать входу: главный экран
    // повторит загрузку сам.
    debugPrint('syncAll after sign-in failed: $error');
  }
  return AppRoutes.home;
}
