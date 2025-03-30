import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:fpdart/fpdart.dart';
import 'map_state.dart';

class MovingMarkerCubit extends Cubit<MapState> {
  Timer? _timer;

  static const _initialPosition = LatLng(55.755793, 37.617134);

  static const double _deltaLatPerSec = (10 / 3600) / 111;

  MovingMarkerCubit() : super(MapState.initial(position: _initialPosition)) {
    _startMoving();
  }

  void _startMoving() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final currentPosition = state.when(
        initial: identity,
        moving: identity,
        error: (_) => _initialPosition,
      );

      final newPosition = LatLng(
        currentPosition.latitude + _deltaLatPerSec,
        currentPosition.longitude,
      );

      emit(MapState.moving(position: newPosition));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
