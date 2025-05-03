import 'package:equatable/equatable.dart';

class Coordinates extends Equatable {
  const Coordinates(this.lat, this.lng);

  final double lat;
  final double lng;

  @override
  List<Object?> get props => [lat, lng];
}
