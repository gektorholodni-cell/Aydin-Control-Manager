import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/mock_notifications_data.dart';

class MockNotificationsRepository implements NotificationsRepository {
  const MockNotificationsRepository();

  @override
  List<AppNotification> getNotifications() => mockNotifications;
}
