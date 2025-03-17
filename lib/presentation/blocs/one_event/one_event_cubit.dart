import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/models/event.dart';
import '../../../application/repositories/events/events_repository.dart';

typedef OneEventState = Option<EventModel>;

class OneEventCubit extends Cubit<OneEventState> {
  OneEventCubit(this._repository) : super(const None());

  final EventsRepository _repository;

  void loadEvent(String uid) async {
    final event = await _repository.getOneEvent(uid);
    emit(event);
  }

  void createEvent() {
    final newEvent = _repository.createEvent();
    emit(Option.of(newEvent));
  }

  void modify(EventModel Function(EventModel) withPrev) {
    final newState = state.map(withPrev);
    emit(newState);
  }

  Future<void> commit() async {
    state.map(_repository.modifyEvent);
    await _repository.save();
  }
}
