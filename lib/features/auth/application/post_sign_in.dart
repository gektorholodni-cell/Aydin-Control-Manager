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
  await backend.syncAll();
  return AppRoutes.home;
}
