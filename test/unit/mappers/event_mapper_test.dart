import 'package:flutter_test/flutter_test.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:ui_alumni_mobile/application/mappers/event_mapper.dart';
import 'package:ui_alumni_mobile/application/models/cost.dart';
import 'package:ui_alumni_mobile/application/models/event.dart';
import 'package:ui_alumni_mobile/application/models/user_status.dart';
import 'package:ui_alumni_mobile/data/models/event_data_model.dart';
import '../../helpers/test_data.dart';

void main() {
  group('EventMapper', () {
    const testMyId = TestData.userId;
    const testAnotherId = TestData.anotherUserId;

    group('eventFromData', () {
      test('should map to EventModel when user is author and event is approved', () {
        final data = TestData.eventData(
          ownerId: testMyId,
          approved: true,
        );
        final result = EventMapper.eventFromData(testMyId)(data);

        expect(result.eventId, TestData.eventId);
        expect(result.userStatus, const UserStatus.author());
        expect(result.title, TestData.title);
        expect(result.location, TestData.location);
        expect(result.participantsIds, TestData.participants.toISet());
        expect(result.pendingApproval, false);
      });

      test('should map to EventModel when user is participant', () {
        const userMyId = 'user1';
        final data = TestData.eventData(
          ownerId: testAnotherId,
          participantsIds: ['user1', 'user2'],
        );
        final result = EventMapper.eventFromData(userMyId)(data);

        expect(
          result.userStatus,
          UserStatus.notAuthor(
            authorId: testAnotherId,
            participant: true,
          ),
        );
      });

      test('should map to EventModel when user is not participant', () {
        const userMyId = 'user3';
        final data = TestData.eventData(
          ownerId: testAnotherId,
          participantsIds: ['user1', 'user2'],
        );
        final result = EventMapper.eventFromData(userMyId)(data);

        expect(
          result.userStatus,
          UserStatus.notAuthor(
            authorId: testAnotherId,
            participant: false,
          ),
        );
      });

      test('should set pendingApproval true when approved is false', () {
        final data = TestData.eventData(approved: false);
        final result = EventMapper.eventFromData(testMyId)(data);
        expect(result.pendingApproval, true);
      });

      test('should set pendingApproval true when approved is null', () {
        final data = TestData.eventData(approved: null);
        final result = EventMapper.eventFromData(testMyId)(data);
        expect(result.pendingApproval, true);
      });

      test('should set pendingApproval false when approved is true', () {
        final data = TestData.eventData(approved: true);
        final result = EventMapper.eventFromData(testMyId)(data);
        expect(result.pendingApproval, false);
      });

      test('should set coverBytes from cover field', () {
        const testCover = 'base64_cover_data';
        final data = TestData.eventData(cover: testCover);
        final result = EventMapper.eventFromData(testMyId)(data);
        expect(result.coverBytes, testCover);
      });

      test('should handle null cover', () {
        final data = TestData.eventData(cover: null);
        final result = EventMapper.eventFromData(testMyId)(data);
        expect(result.coverBytes, null);
      });
    });

    group('eventRequestFromModel', () {
      test('should convert EventModel to EventRequestDataModel', () {
        final model = TestData.eventModel(
          title: TestData.title,
          description: TestData.description,
          location: TestData.location,
        );
        final result = EventMapper.eventRequestFromModel(model);

        expect(result.title, TestData.title);
        expect(result.description, TestData.description);
        expect(result.location, TestData.location);
        expect(result.datetime, TestData.dateTime);
        expect(result.cost, 0);
        expect(result.isOnline, false);
        expect(result.cover, null);
      });

      test('should use default values for null fields', () {
        final model = TestData.eventModel(
          title: null,
          description: null,
          location: null,
          coverBytes: null,
          onlineEvent: true,
        );
        final result = EventMapper.eventRequestFromModel(model);

        expect(result.title, 'Untitled');
        expect(result.description, '');
        expect(result.location, '');
        expect(result.isOnline, true);
        expect(result.cover, null);
      });

      test('should convert coverBytes to cover', () {
        const testCover = 'base64_cover_data';
        final model = TestData.eventModel(coverBytes: testCover);
        final result = EventMapper.eventRequestFromModel(model);
        expect(result.cover, testCover);
      });

      test('should handle online event', () {
        final model = TestData.eventModel(onlineEvent: true);
        final result = EventMapper.eventRequestFromModel(model);
        expect(result.isOnline, true);
      });
    });
  });
}