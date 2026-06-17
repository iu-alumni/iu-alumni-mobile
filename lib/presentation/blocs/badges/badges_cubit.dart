import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/badges/badges_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/badges_state.dart';

class BadgesCubit extends Cubit<BadgesState> {
  BadgesCubit(this._repo) : super(const BadgesState());

  final BadgesRepository _repo;

  Future<void> loadMine() async {
    emit(state.copyWith(badges: const LoadedState.loading()));
    try {
      final data = await _repo.loadMyBadges();
      emit(state.copyWith(badges: LoadedState.data(data)));
    } catch (e) {
      emit(state.copyWith(badges: LoadedState.error(e.toString())));
    }
  }

  Future<void> loadFor(String alumniId) async {
    emit(state.copyWith(badges: const LoadedState.loading()));
    try {
      final data = await _repo.loadFor(alumniId);
      emit(state.copyWith(badges: LoadedState.data(data)));
    } catch (e) {
      emit(state.copyWith(badges: LoadedState.error(e.toString())));
    }
  }

  Future<void> markSeen(List<String> badgeCodes) async {
    await _repo.markSeen(badgeCodes);
  }
}
