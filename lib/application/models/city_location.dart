import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_location.freezed.dart';
part 'city_location.g.dart';

@freezed
abstract class CityLocation with _$CityLocation {
  const factory CityLocation({required String country, required String city}) =
      _CityLocation;

  factory CityLocation.fromJson(Map<String, dynamic> json) =>
      _$CityLocationFromJson(json);
}
