import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/models/event.dart';
import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/users/users_repository.dart';

typedef OneEventState = Option<EventModel>;

class OneEventCubit extends Cubit<OneEventState> {
  OneEventCubit(this._repository, this._usersRepository) : super(const None());

  final EventsRepository _repository;
  final UsersRepository _usersRepository;

  void loadEvent(String uid) async {
    final myProfile = await _usersRepository.loadMe();
    final event = await _repository.getOneEvent(
      uid,
      myProfile.map((p) => p.profileId),
    );
    emit(event);
  }

  void createEvent() {
    final newEvent = _repository.createEvent();
    emit(Option.of(newEvent));
  }

  void modify(EventModel Function(EventModel) withPrev) {
    final newState = state.map(withPrev);
    newState.map(_repository.modifyEvent);
    emit(newState);
  }

  void delete() {
    state.map((s) => s.eventId).map(_repository.deleteEvent);
  }

  Future<void> commit() async {
    state.map(_repository.modifyEvent);
    await _repository.save();
  }

  Future<void> participate() async => state.map(
        (s) async {
          final myProfile = await _usersRepository.loadMe();
          return myProfile.map(
            (p) async {
              final event = await _repository.participate(
                s.eventId,
                p.profileId,
              );
              emit(Option.of(event));
            },
          );
        },
      );
}
