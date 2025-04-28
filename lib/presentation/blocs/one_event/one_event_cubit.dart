import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/models/event.dart';
import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/one_event_state.dart';

class OneEventCubit extends Cubit<OneEventState> {
  OneEventCubit(this._repository, this._usersRepository)
      : super(
          OneEventState(
            saveState: const LoadedState.init(),
            event: const None(),
            userStatusLoading: false,
          ),
        );

  final EventsRepository _repository;
  final UsersRepository _usersRepository;

  void loadEvent(String uid) async {
    final myProfile = await _usersRepository.loadMe();
    final event = await _repository.getOneEvent(
      uid,
      myProfile.map((p) => p.profileId),
    );
    emit(state.copyWith(event: event));
  }

  void createEvent() {
    final newEvent = _repository.createEvent();
    emit(state.copyWith(event: Option.of(newEvent)));
  }

  void modify(EventModel Function(EventModel) withPrev) {
    final newEvent = state.event.map(withPrev);
    newEvent.map(_repository.modifyEvent);
    emit(state.copyWith(event: newEvent));
  }

  void delete() {
    state.event.map((s) => s.eventId).map(_repository.deleteEvent);
  }

  Future<void> save() async {
    emit(state.copyWith(saveState: const LoadedState.loading()));
    state.event.map(_repository.modifyEvent);
    final newId = await _repository.save();
    emit(
      state.copyWith(
        saveState: newId.match(
          () => const LoadedState.error('Could not save the event'),
          (_) => const LoadedState.data(unit),
        ),
        event: newId.match(
          () => state.event,
          (id) => state.event.map((e) => e.copyWith(eventId: id)),
        ),
      ),
    );
  }

  Future<void> participate() async => state.event.map(
        (s) async {
          emit(state.copyWith(userStatusLoading: true));
          final myProfile = await _usersRepository.loadMe();
          return myProfile.match(
            () => emit(state.copyWith(userStatusLoading: false)),
            (p) async {
              final event = await _repository.participate(
                s.eventId,
                p.profileId,
              );
              emit(
                state.copyWith(
                  event: Option.of(event),
                  userStatusLoading: false,
                ),
              );
            },
          );
        },
      );

  Future<void> leave() async => state.event.map(
        (s) async {
          emit(state.copyWith(userStatusLoading: true));
          final myProfile = await _usersRepository.loadMe();
          return myProfile.match(
            () => emit(state.copyWith(userStatusLoading: false)),
            (p) async {
              final event = await _repository.leave(
                s.eventId,
                p.profileId,
              );
              emit(
                state.copyWith(
                  event: Option.of(event),
                  userStatusLoading: false,
                ),
              );
            },
          );
        },
      );
}
