import '../../data/models/notification_data_model.dart';
import '../models/notification.dart';

abstract class NotificationMapper {
  static NotificationModel fromData(NotificationDataModel data) =>
      NotificationModel(
        id: data.id,
        eventId: data.eventId,
        title: data.title,
        location: data.location,
        datetime: data.datetime,
        read: data.read,
      );
}
