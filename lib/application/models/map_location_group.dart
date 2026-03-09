import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_location_group.freezed.dart';
part 'map_location_group.g.dart';

/// A single map pin returned by `GET /profile/map`.
///
/// Represents all alumni at a given city, already resolved to coordinates
/// so the mobile client does not need a separate cities lookup.
@freezed
abstract class MapLocationGroup with _$MapLocationGroup {
  const factory MapLocationGroup({
    required String country,
    required String city,
    required double lat,
    required double lng,
    required int count,
  }) = _MapLocationGroup;

  factory MapLocationGroup.fromJson(Map<String, dynamic> json) =>
      _$MapLocationGroupFromJson(json);
}
