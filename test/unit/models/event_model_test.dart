import 'package:flutter_test/flutter_test.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:ui_alumni_mobile/application/models/cost.dart';
import 'package:ui_alumni_mobile/application/models/event.dart';
import 'package:ui_alumni_mobile/application/models/user_status.dart';
import '../../helpers/test_data.dart';

void main() {
  group('EventModel', () {
    group('construction', () {
      test('should create with all fields', () {
        final event = TestData.eventModel(
          title: TestData.title,
          description: TestData.description,
          coverBytes: TestData.cover,
          location: TestData.location,
        );

        expect(event.eventId, TestData.eventId);
        expect(event.title, TestData.title);
        expect(event.description, TestData.description);
        expect(event.coverBytes, TestData.cover);
        expect(event.location, TestData.location);
        expect(event.cost.number, TestData.cost);
        expect(event.occurringAt, TestData.dateTime);
        expect(event.onlineEvent, false);
        expect(event.participantsIds, TestData.participants.toISet());
        expect(event.pendingApproval, false);
      });

      test('should allow optional fields as null', () {
        final event = TestData.eventModel(
          title: null,
          description: null,
          coverBytes: null,
          location: null,
        );

        expect(event.title, null);
        expect(event.description, null);
        expect(event.coverBytes, null);
        expect(event.location, null);
      });

      test('should handle empty participants', () {
        final event = TestData.eventModel(
          participantsIds: const <String>{}.toISet(),
        );

        expect(event.participantsIds.isEmpty, true);
      });

      test('should handle online event', () {
        final event = TestData.eventModel(onlineEvent: true);
        expect(event.onlineEvent, true);
      });

      test('should handle pending approval', () {
        final event = TestData.eventModel(pendingApproval: true);
        expect(event.pendingApproval, true);
      });
    });

    group('userStatus', () {
      test('should be author', () {
        final event = TestData.eventModel(
          userStatus: const UserStatus.author(),
        );
        expect(event.userStatus, const UserStatus.author());
      });

      test('should be notAuthor with participant', () {
        final event = TestData.eventModel(
          userStatus: UserStatus.notAuthor(
            authorId: TestData.anotherUserId,
            participant: true,
          ),
        );
        expect(
          event.userStatus,
          UserStatus.notAuthor(
            authorId: TestData.anotherUserId,
            participant: true,
          ),
        );
      });

      test('should be notAuthor without participant', () {
        final event = TestData.eventModel(
          userStatus: UserStatus.notAuthor(
            authorId: TestData.anotherUserId,
            participant: false,
          ),
        );
        expect(
          event.userStatus,
          UserStatus.notAuthor(
            authorId: TestData.anotherUserId,
            participant: false,
          ),
        );
      });
    });
  });
}