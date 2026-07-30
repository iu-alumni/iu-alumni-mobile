import '../../../data/notifications/notifications_gateway.dart';
import '../../mappers/notification_mapper.dart';
import '../../models/notification.dart';
import 'notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._gateway);

  final NotificationsGateway _gateway;

  @override
  Future<Iterable<NotificationModel>> getNotifications() async {
    final items = <dynamic>[];
    String? cursor;
    do {
      final page = await _gateway.loadNotifications(cursor: cursor, limit: 100);
      items.addAll(page.items);
      cursor = page.nextCursor;
    } while (cursor != null);

    return items.map((d) => NotificationMapper.fromData(d));
  }

  @override
  Future<int> getUnreadCount() => _gateway.loadUnreadCount();
}
