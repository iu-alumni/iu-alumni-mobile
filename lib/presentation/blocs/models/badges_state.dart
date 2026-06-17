import 'package:flutter/foundation.dart';

import '../../../application/models/badge.dart';
import '../../common/models/loaded_state.dart';

@immutable
class BadgesState {
  const BadgesState({this.badges = const LoadedState.init()});

  final LoadedState<BadgesData> badges;

  BadgesState copyWith({LoadedState<BadgesData>? badges}) =>
      BadgesState(badges: badges ?? this.badges);
}
