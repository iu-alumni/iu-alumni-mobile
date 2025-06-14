import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/models/event.dart';
import '../../../application/repositories/events/events_repository.dart';
import '../../common/models/loaded_state.dart';

typedef EventsListState = LoadedState<IList<EventModel>>;
typedef EventsListData = LoadedStateData<IList<EventModel>>;
typedef EventsListError = LoadedStateError<IList<EventModel>>;

class EventsListCubit extends Cubit<EventsListState> {
  EventsListCubit(this._eventsRepository) : super(const EventsListState.init());

  final EventsRepository _eventsRepository;

  Future<void> loadEvents() async {
    emit(const EventsListState.loading());
    final events = await _eventsRepository.getEvents();
    emit(EventsListState.data(IList(events)));
  }

  void remove(String eventId) {
    if (state case EventsListData currState) {
      emit(
        currState.copyWith(
          data: currState.data.removeWhere((e) => e.eventId == eventId),
        ),
      );
    }
  }

  Future<void> update(String eventId) async {
    if (state case EventsListData currState) {
      final maybeEvent = await _eventsRepository.getOneEvent(eventId);
      maybeEvent.map((event) {
        final index = currState.data.indexWhere((e) => e.eventId == eventId);
        final newEvents = switch (index) {
          // The event is newly added
          -1 => currState.data.add(event),
          _ => currState.data.replace(index, event),
        };
        emit(currState.copyWith(data: newEvents));
      });
    }
  }
}
