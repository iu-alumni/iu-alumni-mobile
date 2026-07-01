import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ui_alumni_mobile/application/repositories/users/users_repository_impl.dart';
import 'package:ui_alumni_mobile/data/profile/profile_gateway.dart';
import 'package:ui_alumni_mobile/data/token/token_provider.dart';
import 'package:ui_alumni_mobile/data/users/users_gateway.dart';
import 'package:ui_alumni_mobile/application/models/profile.dart';
import 'package:ui_alumni_mobile/application/models/paginated_result.dart';
import '../../../helpers/test_data.dart';
import 'users_repository_impl_test.mocks.dart';

void _provideDummies() {
  provideDummy<Option<Profile>>(None());
  provideDummy<PaginatedResult<Profile>>(PaginatedResult(items: [], nextCursor: null));
  provideDummy<Either<String, Profile>>(Right(TestData.profile()));
}

@GenerateMocks([ProfileGateway, UsersGateway, TokenProvider])
void main() {
  _provideDummies();

  late UsersRepositoryImpl repository;
  late MockProfileGateway mockProfileGateway;
  late MockUsersGateway mockUsersGateway;
  late MockTokenProvider mockTokenProvider;

  setUp(() {
    mockProfileGateway = MockProfileGateway();
    mockUsersGateway = MockUsersGateway();
    mockTokenProvider = MockTokenProvider();
    repository = UsersRepositoryImpl(
      mockProfileGateway,
      mockTokenProvider,
      mockUsersGateway,
    );
  });

  group('UsersRepositoryImpl', () {
    group('loadMe', () {
      test('should load profile from gateway when not cached', () async {
        final profile = TestData.profile();
        when(mockProfileGateway.loadProfile())
            .thenAnswer((_) async => Right(profile));

        final result = await repository.loadMe();

        expect(result.isSome(), true);
        result.match(
          () => fail('Expected Some but got None'),
          (value) => expect(value, profile),
        );
        verify(mockProfileGateway.loadProfile()).called(1);
      });

      test('should return None if gateway returns Left (error)', () async {
        when(mockProfileGateway.loadProfile())
            .thenAnswer((_) async => const Left('Error loading profile'));

        final result = await repository.loadMe();

        expect(result.isNone(), true);
        verify(mockProfileGateway.loadProfile()).called(1);
      });
    });

    group('update', () {
      test('should update profile successfully', () async {
        final profile = TestData.profile();
        when(mockProfileGateway.update(profile))
            .thenAnswer((_) async => true);

        final result = await repository.update(profile);

        expect(result, true);
        verify(mockProfileGateway.update(profile)).called(1);
      });

      test('should return false when update fails', () async {
        final profile = TestData.profile();
        when(mockProfileGateway.update(profile))
            .thenAnswer((_) async => false);

        final result = await repository.update(profile);

        expect(result, false);
        verify(mockProfileGateway.update(profile)).called(1);
      });
    });

    group('logout', () {
      test('should clear token', () {
        repository.logout();
        verify(mockTokenProvider.clear()).called(1);
      });
    });

    group('getAllUsers', () {
      test('should load from gateway when no cache', () async {
        final profile = TestData.profile();
        final page = PaginatedResult<Profile>(
          items: [profile],
          nextCursor: 'cursor123',
        );
        when(mockUsersGateway.getAllUsers(cursor: null, limit: 50))
            .thenAnswer((_) async => page);

        final result = await repository.getAllUsers();

        expect(result.items, [profile]);
        expect(result.nextCursor, 'cursor123');
        verify(mockUsersGateway.getAllUsers(cursor: null, limit: 50)).called(1);
      });

      test('should load from gateway when cursor is provided', () async {
        final profile = TestData.profile();
        final page = PaginatedResult<Profile>(
          items: [profile],
          nextCursor: 'cursor456',
        );
        when(mockUsersGateway.getAllUsers(cursor: 'cursor123', limit: 50))
            .thenAnswer((_) async => page);

        final result = await repository.getAllUsers(cursor: 'cursor123');

        expect(result.items, [profile]);
        expect(result.nextCursor, 'cursor456');
        verify(mockUsersGateway.getAllUsers(cursor: 'cursor123', limit: 50)).called(1);
      });
    });

    group('getUsersAtLocation', () {
      test('should load users from gateway', () async {
        final profile = TestData.profile();
        final page = PaginatedResult<Profile>(
          items: [profile],
          nextCursor: 'cursor123',
        );
        when(mockUsersGateway.getUsersAtLocation('Innopolis', cursor: null, limit: 50))
            .thenAnswer((_) async => page);

        final result = await repository.getUsersAtLocation('Innopolis');

        expect(result.items, [profile]);
        expect(result.nextCursor, 'cursor123');
        verify(mockUsersGateway.getUsersAtLocation('Innopolis', cursor: null, limit: 50)).called(1);
      });
    });

    group('getUsersByIds', () {
      test('should load users from gateway', () async {
        final profile = TestData.profile();
        when(mockUsersGateway.getUsersByIds([profile.profileId]))
            .thenAnswer((_) async => [profile]);

        final result = await repository.getUsersByIds([profile.profileId]);

        expect(result, [profile]);
        verify(mockUsersGateway.getUsersByIds([profile.profileId])).called(1);
      });
    });
  });
}