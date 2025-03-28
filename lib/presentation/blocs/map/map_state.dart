import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.initial({
    required LatLng position,
  }) = _Initial;

  const factory MapState.moving({
    required LatLng position,
  }) = _Moving;

  const factory MapState.error({
    required String message,
  }) = _Error;
}
