import 'package:flutter_test/flutter_test.dart';
import '../../../lib/application/models/profile.dart';
import '../../helpers/test_data.dart';

void main() {
  group('Profile', () {
    group('fromJson', () {
      test('should parse complete JSON', () {
        final json = TestData.profileJson(
          location: TestData.location,
          biography: 'Software Engineer',
          telegramAlias: '@johndoe',
          avatar: 'https://avatar.url',
          isTelegramVerified: true,
          showLocation: true,
        );

        final profile = Profile.fromJson(json);

        expect(profile.profileId, TestData.userId);
        expect(profile.firstName, TestData.firstName);
        expect(profile.lastName, TestData.lastName);
        expect(profile.graduationYear, TestData.graduationYear);
        expect(profile.location, TestData.location);
        expect(profile.biography, 'Software Engineer');
        expect(profile.telegramAlias, '@johndoe');
        expect(profile.avatar, 'https://avatar.url');
        expect(profile.isTelegramVerified, true);
        expect(profile.showLocation, true);
      });

      test('should parse JSON with null values', () {
        final json = TestData.profileJson(
          location: null,
          biography: null,
          telegramAlias: null,
          avatar: null,
          showLocation: false,
          isTelegramVerified: false,
        );

        final profile = Profile.fromJson(json);

        expect(profile.location, null);
        expect(profile.biography, null);
        expect(profile.telegramAlias, null);
        expect(profile.avatar, null);
        expect(profile.showLocation, false);
        expect(profile.isTelegramVerified, false);
      });

      test('should parse minimal JSON', () {
        final json = TestData.profileJson();

        final profile = Profile.fromJson(json);

        expect(profile.profileId, TestData.userId);
        expect(profile.firstName, TestData.firstName);
        expect(profile.lastName, TestData.lastName);
        expect(profile.graduationYear, TestData.graduationYear);
        expect(profile.location, null);
        expect(profile.biography, null);
      });
    });

    group('fullName', () {
      test('should combine first and last name', () {
        final profile = TestData.profile();
        expect(profile.fullName, '${TestData.firstName} ${TestData.lastName}');
      });

      test('should handle different names', () {
        final profile = TestData.profile(
          firstName: 'Jane',
          lastName: 'Smith',
        );
        expect(profile.fullName, 'Jane Smith');
      });
    });
  });
}