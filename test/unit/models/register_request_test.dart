import 'package:flutter_test/flutter_test.dart';
import 'package:ui_alumni_mobile/application/models/register_request.dart';
import '../../helpers/test_data.dart';

void main() {
  group('RegisterRequest', () {
    test('should serialize to JSON with correct keys and values', () {
      final request = TestData.registerRequest(
        telegram: '@johndoe',
        manualVerification: false,
      );

      final json = request.toJson();

      expect(json['first_name'], TestData.firstName);
      expect(json['last_name'], TestData.lastName);
      expect(json['graduation_year'], TestData.graduationYear);
      expect(json['email'], TestData.email);
      expect(json['password'], TestData.password);
      expect(json['telegram_alias'], '@johndoe');
      expect(json['manual_verification'], false);
    });

    test('should serialize with null telegram', () {
      final request = TestData.registerRequest(
        telegram: null,
        manualVerification: false,
      );

      final json = request.toJson();

      expect(json['first_name'], TestData.firstName);
      expect(json['last_name'], TestData.lastName);
      expect(json['graduation_year'], TestData.graduationYear);
      expect(json['email'], TestData.email);
      expect(json['password'], TestData.password);
      expect(json['telegram_alias'], null);
      expect(json['manual_verification'], false);
    });

    test('should serialize with manual verification true', () {
      final request = TestData.registerRequest(
        telegram: '@johndoe',
        manualVerification: true,
      );

      final json = request.toJson();

      expect(json['manual_verification'], true);
    });

    test('should serialize with custom email', () {
      const customEmail = 'custom@innopolis.university';
      final request = TestData.registerRequest(
        email: customEmail,
        telegram: '@johndoe',
        manualVerification: false,
      );

      final json = request.toJson();

      expect(json['email'], customEmail);
    });

    test('should serialize with custom telegram', () {
      const customTelegram = '@custom';
      final request = TestData.registerRequest(
        telegram: customTelegram,
        manualVerification: false,
      );

      final json = request.toJson();

      expect(json['telegram_alias'], customTelegram);
    });
  });
}