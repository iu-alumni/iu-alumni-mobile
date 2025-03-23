import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/repositories/events/events_repository.dart';
import 'events_list_state.dart';

class EventsListCubit extends Cubit<EventsListState> {
  EventsListCubit(this._repository) : super(const EventsListState.none());

  final EventsRepository _repository;

  Future<void> loadEvents() async {
    emit(const EventsListState.loading());
    final events = await _repository.getEvents();
    emit(EventsListState.data(events: IList(events)));
  }

  // The same as [update] but adds the event right away to save some time
  Future<void> add(String eventId) async {
    final currState = state;
    if (currState is! EventsListStateData) {
      return;
    }
    final maybeEvent = await _repository.getOneEvent(eventId);
    maybeEvent.map(
      (event) => emit(
        currState.copyWith(
          events: currState.events.add(event),
        ),
      ),
    );
  }

  void remove(String eventId) {
    final currState = state;
    if (currState is! EventsListStateData) {
      return;
    }
    emit(
      currState.copyWith(
        events: currState.events.removeWhere((e) => e.eventId == eventId),
      ),
    );
  }

  Future<void> update(String eventId) async {
    final currState = state;
    if (currState is! EventsListStateData) {
      return;
    }
    final maybeEvent = await _repository.getOneEvent(eventId);
    maybeEvent.map((event) {
      final index = currState.events.indexWhere((e) => e.eventId == eventId);
      final newEvents = switch (index) {
        // The event is newly added
        -1 => currState.events.add(event),
        _ => currState.events.replace(index, event),
      };
      emit(currState.copyWith(events: newEvents));
    });
  }
}
