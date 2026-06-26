import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:uuid/uuid.dart';

import 'package:ui_alumni_mobile/application/models/user_status.dart';
import 'package:ui_alumni_mobile/application/models/event.dart';
import 'package:ui_alumni_mobile/application/models/profile.dart';
import 'package:ui_alumni_mobile/application/models/paginated_result.dart';
import 'package:ui_alumni_mobile/application/repositories/events/events_repository_impl.dart';
import 'package:ui_alumni_mobile/data/events/events_gateway.dart';
import 'package:ui_alumni_mobile/data/models/event_data_model.dart';
import 'package:ui_alumni_mobile/data/models/event_request_data_model.dart';
import 'package:ui_alumni_mobile/application/repositories/users/users_repository.dart';
import 'package:ui_alumni_mobile/application/mappers/event_mapper.dart';

import '../../../helpers/test_data.dart';
import 'events_repository_impl_test.mocks.dart';

void _provideDummies() {
  provideDummy<Option<Profile>>(None());
  provideDummy<Option<String>>(None());
}

@GenerateMocks([EventsGateway, UsersRepository, Uuid])
void main() {
  _provideDummies();

  late EventsRepositoryImpl repository;
  late MockEventsGateway mockGateway;
  late MockUsersRepository mockUsersRepository;
  late MockUuid mockUuid;

  setUp(() {
    mockGateway = MockEventsGateway();
    mockUsersRepository = MockUsersRepository();
    mockUuid = MockUuid();
    repository = EventsRepositoryImpl(mockUuid, mockGateway, mockUsersRepository);
  });

  group('EventsRepositoryImpl', () {
    group('createEvent', () {
      test('should create a new event with unique id', () {
        const expectedId = 'test-uuid-123';
        when(mockUuid.v4()).thenReturn(expectedId);

        final event = repository.createEvent();

        expect(event.eventId, expectedId);
        expect(event.userStatus, const UserStatus.author());
        expect(event.title, null);
        expect(event.description, null);
        expect(event.location, null);
        expect(event.pendingApproval, true);
        verify(mockUuid.v4()).called(1);
      });
    });

    group('modifyEvent and save', () {
      test('should save new event successfully', () async {
        const eventId = 'event123';
        when(mockUuid.v4()).thenReturn(eventId);

        // ✅ 1. Сначала загружаем кэш
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(items: [], nextCursor: null));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(items: [], nextCursor: null));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => Some(TestData.profile()));

        await repository.getEvents();

        // ✅ 2. Создаём и модифицируем событие
        final event = repository.createEvent();
        final modifiedEvent = event.copyWith(
          title: 'Test Event',
          description: 'Test Description',
          location: 'Room 101',
        );
        repository.modifyEvent(modifiedEvent);

        when(mockGateway.addEvent(any))
            .thenAnswer((_) async => Some(eventId));

        final result = await repository.save();

        expect(result.isSome(), true);
        result.match(
          () => fail('Expected Some but got None'),
          (id) => expect(id, eventId),
        );
        verify(mockGateway.addEvent(any)).called(1);
      });

      test('should update existing event successfully', () async {
        const eventId = 'event123';
        when(mockUuid.v4()).thenReturn(eventId);

        // ✅ 1. Загружаем кэш
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(items: [], nextCursor: null));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(items: [], nextCursor: null));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => Some(TestData.profile()));

        await repository.getEvents();

        // ✅ 2. Создаём и сохраняем событие
        final event = repository.createEvent();
        final modifiedEvent = event.copyWith(
          title: 'Test Event',
          description: 'Test Description',
          location: 'Room 101',
        );
        repository.modifyEvent(modifiedEvent);

        when(mockGateway.addEvent(any))
            .thenAnswer((_) async => Some(eventId));

        await repository.save();

        // ✅ 3. Обновляем событие
        final updatedEvent = event.copyWith(
          title: 'Updated Title',
          description: 'Updated Description',
        );
        repository.modifyEvent(updatedEvent);

        when(mockGateway.updateEvent(eventId, any))
            .thenAnswer((_) async => true);

        final result = await repository.save();

        expect(result.isSome(), true);
        result.match(
          () => fail('Expected Some but got None'),
          (id) => expect(id, eventId),
        );
        verify(mockGateway.updateEvent(eventId, any)).called(1);
      });

      test('should return None when no event modified', () async {
        final result = await repository.save();
        expect(result.isNone(), true);
      });
    });

    group('deleteEvent', () {
      test('should delete event successfully', () async {
        const eventId = 'event123';
        when(mockUuid.v4()).thenReturn(eventId);

        // ✅ 1. Загружаем кэш
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(items: [], nextCursor: null));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(items: [], nextCursor: null));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => Some(TestData.profile()));

        await repository.getEvents();

        // ✅ 2. Создаём и сохраняем событие
        final event = repository.createEvent();
        repository.modifyEvent(event.copyWith(
          title: 'Test Event',
          description: 'Test Description',
          location: 'Room 101',
        ));

        when(mockGateway.addEvent(any))
            .thenAnswer((_) async => Some(eventId));

        await repository.save();

        when(mockGateway.deleteEvent(eventId))
            .thenAnswer((_) async => true);

        await repository.deleteEvent(eventId);

        verify(mockGateway.deleteEvent(eventId)).called(1);
      });

      test('should restore event if deletion fails', () async {
        const eventId = 'event123';
        when(mockUuid.v4()).thenReturn(eventId);

        // ✅ 1. Загружаем кэш
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(items: [], nextCursor: null));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(items: [], nextCursor: null));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => Some(TestData.profile()));

        await repository.getEvents();

        // ✅ 2. Создаём и сохраняем событие
        final event = repository.createEvent();
        repository.modifyEvent(event.copyWith(
          title: 'Test Event',
          description: 'Test Description',
          location: 'Room 101',
        ));

        when(mockGateway.addEvent(any))
            .thenAnswer((_) async => Some(eventId));

        await repository.save();

        when(mockGateway.deleteEvent(eventId))
            .thenAnswer((_) async => false);

        await repository.deleteEvent(eventId);

        // Event should still be in cache
        final cached = await repository.getOneEvent(eventId);
        expect(cached.isSome(), true);
        cached.match(
          () => fail('Expected Some but got None'),
          (e) => expect(e.eventId, eventId),
        );
      });
    });

    group('getOneEvent', () {
      test('should return None for non-existent event', () async {
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(items: [], nextCursor: null));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(items: [], nextCursor: null));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => None());

        await repository.getEvents();

        final result = await repository.getOneEvent('nonexistent');
        expect(result.isNone(), true);
      });
    });

    group('getEvents', () {
      test('should load events from gateway when cache is empty', () async {
        final eventData = TestData.eventData();
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [eventData],
              nextCursor: null,
            ));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [],
              nextCursor: null,
            ));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => None());

        final events = await repository.getEvents();

        expect(events.isNotEmpty, true);
        expect(events.first.eventId, eventData.eventId);
        verify(mockGateway.loadEvents(cursor: null, limit: 100)).called(1);
      });

      test('should load pending events from gateway', () async {
        final eventData = TestData.eventData();
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [],
              nextCursor: null,
            ));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [eventData],
              nextCursor: null,
            ));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => None());

        final events = await repository.getEvents();

        expect(events.isNotEmpty, true);
        verify(mockGateway.loadPendingEvents(cursor: null, limit: 100)).called(1);
      });

      test('should use cache on subsequent calls', () async {
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [],
              nextCursor: null,
            ));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [],
              nextCursor: null,
            ));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => None());

        await repository.getEvents();
        await repository.getEvents();

        verify(mockGateway.loadEvents(cursor: null, limit: 100)).called(1);
      });
    });

    group('refreshEvents', () {
      test('should reload events from gateway', () async {
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [],
              nextCursor: null,
            ));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [],
              nextCursor: null,
            ));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => None());

        await repository.refreshEvents();

        verify(mockGateway.loadEvents(cursor: null, limit: 100)).called(1);
      });
    });

    group('participate', () {
      test('should participate in event successfully', () async {
        const eventId = 'event123';
        const userId = 'user123';

        // Setup cache with event
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [TestData.eventData(eventId: eventId)],
              nextCursor: null,
            ));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [],
              nextCursor: null,
            ));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => Some(TestData.profile(id: userId)));

        await repository.getEvents();

        when(mockGateway.participate(eventId, userId))
            .thenAnswer((_) async => true);

        final result = await repository.participate(eventId);

        expect(result.isSome(), true);
        verify(mockGateway.participate(eventId, userId)).called(1);
      });
    });

    group('leave', () {
      test('should leave event successfully', () async {
        const eventId = 'event123';
        const userId = 'user123';

        // Setup cache with event
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [TestData.eventData(eventId: eventId)],
              nextCursor: null,
            ));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [],
              nextCursor: null,
            ));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => Some(TestData.profile(id: userId)));

        await repository.getEvents();

        when(mockGateway.leave(eventId, userId))
            .thenAnswer((_) async => true);

        final result = await repository.leave(eventId);

        expect(result.isSome(), true);
        verify(mockGateway.leave(eventId, userId)).called(1);
      });
    });

    group('getEventsIOwn', () {
      test('should fetch events I own from cache', () async {
        const userId = 'user123';
        final eventData = TestData.eventData(ownerId: userId);

        // Setup cache
        when(mockGateway.loadEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [eventData],
              nextCursor: null,
            ));
        when(mockGateway.loadPendingEvents(cursor: anyNamed('cursor'), limit: anyNamed('limit')))
            .thenAnswer((_) async => PaginatedResult(
              items: [],
              nextCursor: null,
            ));
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => Some(TestData.profile(id: userId)));

        await repository.getEvents();

        final events = await repository.getEventsIOwn();

        expect(events.isNotEmpty, true);
        expect(events.first.eventId, eventData.eventId);
      });
    });

    group('getEventsWhereParticipate', () {
      test('should fetch events where user participates', () async {
        const userId = 'user123';
        final eventData = TestData.eventData(participantsIds: [userId]);

        when(mockGateway.eventsWhereParticipate(userId))
            .thenAnswer((_) async => [eventData]);
        when(mockUsersRepository.loadMe())
            .thenAnswer((_) async => Some(TestData.profile(id: userId)));

        final events = await repository.getEventsWhereParticipate(userId);

        expect(events.isNotEmpty, true);
        verify(mockGateway.eventsWhereParticipate(userId)).called(1);
      });
    });
  });
}