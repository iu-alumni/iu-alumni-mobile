import '../../data/models/event_data_model.dart';
import '../../data/models/event_request_data_model.dart';
import '../models/cost.dart';
import '../models/event.dart';

abstract class EventMapper {
  static EventModel eventFromData(EventDataModel data) => EventModel(
        eventId: data.eventId,
        title: data.title,
        description: data.description,
        coverUrl: data.cover,
        location: data.location,
        // TODO update
        cost: CostModel(number: data.cost, currency: Currency.rub),
        occurringAt: data.datetime,
        onlineEvent: data.isOnline,
      );

  static EventRequestDataModel eventRequestFromModel(EventModel model) =>
      EventRequestDataModel(
        title: model.title,
        description: model.description,
        location: model.location,
        datetime: model.occurringAt,
        cost: model.cost.number,
        isOnline: model.onlineEvent,
        cover: model.coverUrl ?? '',
      );
}
