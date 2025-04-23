import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/models/event.dart';
import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';

typedef EventsListState = LoadedState<IList<EventModel>>;
typedef EventsListData = LoadedStateData<IList<EventModel>>;
typedef EventsListError = LoadedStateError<IList<EventModel>>;

class EventsListCubit extends Cubit<EventsListState> {
  EventsListCubit(this._eventsRepository, this._usersRepository)
      : super(const EventsListState.init());

  final EventsRepository _eventsRepository;
  final UsersRepository _usersRepository;

  Future<void> loadEvents() async {
    emit(const EventsListState.loading());
    final myProfile = await _usersRepository.loadMe();
    final events = await _eventsRepository.getEvents(
      myProfile.map((p) => p.profileId),
    );
    emit(EventsListState.data(IList(events)));
  }

  // The same as [update] but adds the event right away to save some time
  Future<void> add(String eventId) async {
    if (state case EventsListData currState) {
      final myProfile = await _usersRepository.loadMe();
      final maybeEvent = await _eventsRepository.getOneEvent(
        eventId,
        myProfile.map((p) => p.profileId),
      );
      maybeEvent.map(
        (event) => emit(
          currState.copyWith(
            data: currState.data.add(event),
          ),
        ),
      );
    }
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
      final myProfile = await _usersRepository.loadMe();
      final maybeEvent = await _eventsRepository.getOneEvent(
        eventId,
        myProfile.map((p) => p.profileId),
      );
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
