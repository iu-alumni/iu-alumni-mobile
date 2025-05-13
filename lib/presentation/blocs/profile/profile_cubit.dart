import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/models/event.dart';
import '../../../application/models/profile.dart';
import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._usersRepository, this._eventsRepository) : super(_initial);

  static final _initial = ProfileState(
    profile: const LoadedState.init(),
    ownedEvents: const LoadedState.init(),
    participatedEvents: const LoadedState.init(),
    myOwn: true,
  );

  final UsersRepository _usersRepository;
  final EventsRepository _eventsRepository;

  void dispose() => emit(
        ProfileState(
          profile: const LoadedState.init(),
          ownedEvents: const LoadedState.init(),
          participatedEvents: const LoadedState.init(),
          myOwn: false,
        ),
      );

  void loadProfile(Option<Profile> profile) async {
    emit(state.copyWith(profile: const LoadedState.loading()));
    final myProfile = await _usersRepository.loadMe();
    return emit(profile.match(
      () => state.copyWith(
        myOwn: true,
        profile: myProfile.match(
          () => const LoadedState.error('Could not load your profile'),
          LoadedState.data,
        ),
      ),
      (p) => switch (myProfile) {
        Some(value: final mp) when mp.profileId == p.profileId =>
          state.copyWith(
            myOwn: true,
            profile: LoadedState.data(mp),
          ),
        _ => state.copyWith(
            myOwn: false,
            profile: LoadedState.data(p),
          ),
      },
    ));
  }

  void updateProfileData() async {
    // It is currently reasonable to update the profile data only if it is your
    // own profile
    if (state.myOwn) {
      loadProfile(const None());
    }
  }

  void loadOwnedEvents() async {
    if (!state.myOwn) {
      // No need to download your events if this isn't your account anyway
      return;
    }
    emit(state.copyWith(ownedEvents: const LoadedState.loading()));
    final events = await _eventsRepository.getEventsIOwn();
    emit(state.copyWith(ownedEvents: LoadedState.data(IList(events))));
  }

  void updateOwnedEvents() async {
    if (state.ownedEvents is LoadedStateInit) {
      // Could be loaded later
      return;
    }
    return loadOwnedEvents();
  }

  void loadParticipatedEvents() async {
    emit(state.copyWith(participatedEvents: const LoadedState.loading()));
    final events = await switch (state.profile) {
      LoadedStateData(:final data) =>
        _eventsRepository.getEventsWhereParticipate(data.profileId),
      _ => Future.value(const Iterable<EventModel>.empty()),
    };
    emit(
      state.copyWith(participatedEvents: LoadedState.data(IList(events))),
    );
  }

  void updateParticipatedEvents() async {
    if (state.participatedEvents is LoadedStateInit) {
      // Could be loaded later
      return;
    }
    return loadParticipatedEvents();
  }

  void logout() {
    _usersRepository.logout();
  }
}
