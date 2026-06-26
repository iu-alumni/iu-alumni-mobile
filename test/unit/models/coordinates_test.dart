import 'package:flutter_test/flutter_test.dart';
import 'package:ui_alumni_mobile/application/models/coordinates.dart';

void main() {
  group('Coordinates', () {
    test('should parse from JSON', () {
      const json = {
        'lat': 55.7558,
        'lng': 37.6173,
      };

      final coords = Coordinates.fromJson(json);

      expect(coords.lat, 55.7558);
      expect(coords.lng, 37.6173);
    });

    test('should convert to JSON', () {
      const coords = Coordinates(55.7558, 37.6173);

      final json = coords.toJson();

      expect(json['lat'], 55.7558);
      expect(json['lng'], 37.6173);
    });
  });
}