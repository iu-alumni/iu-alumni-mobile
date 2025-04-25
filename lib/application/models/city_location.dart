import 'package:equatable/equatable.dart';

class CityLocation extends Equatable {
  const CityLocation(this.country, this.city);
  final String country;
  final String city;

  @override
  List<Object?> get props => [country, city];
}
