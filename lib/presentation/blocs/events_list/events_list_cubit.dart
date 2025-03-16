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

  String? createEvent() {
    final currState = state;
    if (currState is! EventsListStateData) {
      return null;
    }
    final newEvent = _repository.createEvent();
    emit(
      currState.copyWith(
        events: currState.events.add(newEvent),
      ),
    );
    return newEvent.eventId;
  }

  Future<void> update(String eventId) async {
    final currState = state;
    if (currState is! EventsListStateData) {
      return;
    }
    final maybeEvent = await _repository.getOneEvent(eventId);
    maybeEvent.map((event) {
      final index = currState.events.indexWhere((e) => e.eventId == eventId);
      if (index == -1) {
        return;
      }
      emit(currState.copyWith(events: currState.events.replace(index, event)));
    });
  }
}
