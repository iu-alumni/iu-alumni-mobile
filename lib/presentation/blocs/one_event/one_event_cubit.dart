import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/models/event.dart';
import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/one_event_state.dart';

class OneEventCubit extends Cubit<OneEventState> {
  OneEventCubit(this._repository, this._usersRepository, this._reporter)
      : super(
          OneEventState(
            saveState: const LoadedState.init(),
            event: const None(),
            userStatusLoading: false,
            participants: const LoadedState.init(),
          ),
        );

  final EventsRepository _repository;
  final UsersRepository _usersRepository;
  final Reporter _reporter;

  Future<void> loadEvent(String uid) async {
    final event = await _repository.getOneEvent(uid);
    emit(state.copyWith(event: event));
  }

  void loadParticipants() => state.event.map((e) async {
        emit(state.copyWith(participants: const LoadedState.loading()));
        final participants = await _usersRepository.getUsersByIds(
          e.participantsIds,
        );
        emit(state.copyWith(participants: LoadedState.data(participants)));
      });

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
    state.event.map(
      (event) => _reporter.reportDeleteEvent(
        event,
        AppLocation.eventEditingScreen,
      ),
    );
    state.event.map((s) => s.eventId).map(_repository.deleteEvent);
  }

  Future<void> save() async {
    state.event.map(
      (event) => _reporter.reportSaveEvent(
        event,
        AppLocation.eventEditingScreen,
      ),
    );
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

  Future<void> participate() => state.event.match(
        () async {},
        (s) async {
          _reporter.reportParticipate(s, AppLocation.eventScreen);
          emit(state.copyWith(userStatusLoading: true));
          final myProfile = await _usersRepository.loadMe();
          return myProfile.match(
            () => emit(state.copyWith(userStatusLoading: false)),
            (p) async {
              final event = await _repository.participate(s.eventId);
              emit(
                state.copyWith(
                  event: event.match(() => state.event, Option.of),
                  userStatusLoading: false,
                ),
              );
            },
          );
        },
      );

  Future<void> leave() => state.event.match(
        () async {},
        (s) async {
          _reporter.reportLeave(s, AppLocation.eventScreen);
          emit(state.copyWith(userStatusLoading: true));
          final myProfile = await _usersRepository.loadMe();
          return myProfile.match(
            () => emit(state.copyWith(userStatusLoading: false)),
            (p) async {
              final event = await _repository.leave(s.eventId);
              emit(
                state.copyWith(
                  event: event.match(() => state.event, Option.of),
                  userStatusLoading: false,
                ),
              );
            },
          );
        },
      );
}
