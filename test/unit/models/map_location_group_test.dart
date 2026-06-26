import 'package:flutter_test/flutter_test.dart';
import 'package:ui_alumni_mobile/application/models/map_location_group.dart';

void main() {
  group('MapLocationGroup', () {
    test('should parse from JSON', () {
      const json = {
        'country': 'Russia',
        'city': 'Innopolis',
        'lat': 55.7558,
        'lng': 37.6173,
        'count': 42,
      };

      final group = MapLocationGroup.fromJson(json);

      expect(group.country, 'Russia');
      expect(group.city, 'Innopolis');
      expect(group.lat, 55.7558);
      expect(group.lng, 37.6173);
      expect(group.count, 42);
    });

    test('should convert to JSON', () {
      const group = MapLocationGroup(
        country: 'Russia',
        city: 'Innopolis',
        lat: 55.7558,
        lng: 37.6173,
        count: 42,
      );

      final json = group.toJson();

      expect(json['country'], 'Russia');
      expect(json['city'], 'Innopolis');
      expect(json['lat'], 55.7558);
      expect(json['lng'], 37.6173);
      expect(json['count'], 42);
    });
  });
}