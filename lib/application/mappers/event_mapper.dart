import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../data/models/event_data_model.dart';
import '../../data/models/event_request_data_model.dart';
import '../models/cost.dart';
import '../models/event.dart';
import '../models/user_status.dart';

abstract class EventMapper {
  static EventModel Function(EventDataModel) eventFromData(String? myId) =>
      (data) => EventModel(
            eventId: data.eventId,
            userStatus: data.ownerId == myId
                ? const UserStatus.author()
                : UserStatus.notAuthor(
                    authorId: data.ownerId,
                    participant: data.participantsIds.contains(myId),
                  ),
            title: data.title,
            description: data.description,
            coverBytes: data.cover,
            location: data.location,
            // TODO update
            cost: CostModel(
              number: data.cost.toDouble(),
              currency: Currency.rub,
            ),
            occurringAt: data.datetime,
            onlineEvent: data.isOnline,
            participantsIds: data.participantsIds.toISet(),
          );

  static EventRequestDataModel eventRequestFromModel(EventModel model) =>
      EventRequestDataModel(
        title: model.title ?? 'Untitled',
        description: model.description ?? '',
        location: model.location ?? '',
        datetime: model.occurringAt,
        cost: model.cost.number.toInt(),
        isOnline: model.onlineEvent,
        cover: model.coverBytes,
      );
}
