import '../../models/notification.dart';

abstract interface class NotificationsRepository {
  /// Fetches every page of notifications. Note: per the backend, this marks
  /// all currently-unread notifications as read as a side effect.
  Future<Iterable<NotificationModel>> getNotifications();

  Future<int> getUnreadCount();
}
