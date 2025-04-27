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
    state.event.map(_repository.modifyEvent);
    emit(state.copyWith(saveState: const LoadedState.loading()));
    final success = await _repository.save();
    emit(
      state.copyWith(
        saveState: success
            ? const LoadedState.data(unit)
            : const LoadedState.error('Could not save the event'),
      ),
    );
  }

  Future<void> participate() async => state.event.map(
        (s) async {
          final myProfile = await _usersRepository.loadMe();
          return myProfile.map(
            (p) async {
              final event = await _repository.participate(
                s.eventId,
                p.profileId,
              );
              emit(state.copyWith(event: Option.of(event)));
            },
          );
        },
      );

  Future<void> leave() async => state.event.map(
        (s) async {
          final myProfile = await _usersRepository.loadMe();
          return myProfile.map(
            (p) async {
              final event = await _repository.leave(
                s.eventId,
                p.profileId,
              );
              emit(state.copyWith(event: Option.of(event)));
            },
          );
        },
      );
}
