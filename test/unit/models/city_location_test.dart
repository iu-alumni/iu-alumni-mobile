import 'package:flutter_test/flutter_test.dart';
import 'package:ui_alumni_mobile/application/models/city_location.dart';

void main() {
  group('CityLocation', () {
    test('should parse from JSON', () {
      const json = {
        'country': 'Russia',
        'city': 'Innopolis',
      };

      final location = CityLocation.fromJson(json);

      expect(location.country, 'Russia');
      expect(location.city, 'Innopolis');
    });

    test('should convert to JSON', () {
      const location = CityLocation(
        country: 'Russia',
        city: 'Innopolis',
      );

      final json = location.toJson();

      expect(json['country'], 'Russia');
      expect(json['city'], 'Innopolis');
    });
  });
}