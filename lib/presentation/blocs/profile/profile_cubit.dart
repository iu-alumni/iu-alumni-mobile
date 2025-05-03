import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/models/event.dart';
import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._usersRepository, this._eventsRepository)
      : super(
          ProfileState(
            profile: const LoadedState.init(),
            ownedEvents: const LoadedState.init(),
            participatedEvents: const LoadedState.init(),
          ),
        );

  final UsersRepository _usersRepository;
  final EventsRepository _eventsRepository;

  void loadProfile() async {
    emit(state.copyWith(profile: const LoadedState.loading()));
    final profile = await _usersRepository.loadMe();
    emit(
      profile.match(
        () => state.copyWith(
          profile: const LoadedState.error('Could not load'),
        ),
        (p) => state.copyWith(profile: LoadedState.data(p)),
      ),
    );
  }

  void loadOwnedEvents() async {
    emit(state.copyWith(ownedEvents: const LoadedState.loading()));
    final profile = await _usersRepository.loadMe();
    final events = await _eventsRepository.getEventsIOwn(
      profile.map((p) => p.profileId),
    );
    emit(state.copyWith(ownedEvents: LoadedState.data(IList(events))));
  }

  void updateOwnedEvents() {
    if (state.ownedEvents is LoadedStateInit) {
      // Could be loaded later when needed
      return;
    }
    // Update otherwise
    loadOwnedEvents();
  }

  void loadParticipatedEvents() async {
    emit(state.copyWith(participatedEvents: const LoadedState.loading()));
    final profile = await _usersRepository.loadMe();
    profile.match(
      () => emit(
        state.copyWith(
          participatedEvents: LoadedState.data(<EventModel>[].lock),
        ),
      ),
      (p) async {
        final events = await _eventsRepository.getEventsIParticipateIn(
          p.profileId,
        );
        emit(
          state.copyWith(participatedEvents: LoadedState.data(IList(events))),
        );
      },
    );
  }

  void updateParticipatedEvents() {
    if (state.participatedEvents is LoadedStateInit) {
      // Could be loaded later when needed
      return;
    }
    // Update otherwise
    loadParticipatedEvents();
  }

  void logout() {
    _usersRepository.logout();
  }
}
