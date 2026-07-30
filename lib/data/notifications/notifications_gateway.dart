import '../../application/models/paginated_result.dart';
import '../models/notification_data_model.dart';

abstract interface class NotificationsGateway {
  Future<PaginatedResult<NotificationDataModel>> loadNotifications({
    String? cursor,
    int limit,
  });
  Future<int> loadUnreadCount();
}
