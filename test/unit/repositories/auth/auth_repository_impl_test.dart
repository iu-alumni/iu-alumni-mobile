import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:ui_alumni_mobile/application/repositories/auth/auth_repository_impl.dart';
import 'package:ui_alumni_mobile/data/auth/auth_gateway.dart';
import 'package:ui_alumni_mobile/application/models/register_request.dart';
import '../../../helpers/test_data.dart';
import 'auth_repository_impl_test.mocks.dart';

// ✅ Добавляем provideDummy для Either
void _provideDummies() {
  provideDummy<Either<String, Unit>>(const Right(unit));
  provideDummy<Either<String?, Unit>>(const Right(unit));
  provideDummy<Either<String, Either<Unit, Unit>>>(const Right(Right(unit)));
}

@GenerateMocks([AuthGateway])
void main() {
  // ✅ Вызываем provideDummies ДО создания моков
  _provideDummies();

  late AuthRepositoryImpl repository;
  late MockAuthGateway mockGateway;

  setUp(() {
    mockGateway = MockAuthGateway();
    repository = AuthRepositoryImpl(mockGateway);
  });

  Future<void> registerAndSaveEmail() async {
    final request = TestData.registerRequest();
    when(mockGateway.register(request))
        .thenAnswer((_) async => const Right(Right(unit)));
    await repository.register(request);
  }

  group('AuthRepositoryImpl', () {
    group('authorize', () {
      test('should return success on valid credentials', () async {
        when(mockGateway.authorize(TestData.email, TestData.password))
            .thenAnswer((_) async => const Right(unit));

        final result = await repository.authorize(TestData.email, TestData.password);

        expect(result, const Right(unit));
        verify(mockGateway.authorize(TestData.email, TestData.password)).called(1);
      });

      test('should return error on invalid credentials', () async {
        const error = 'Invalid credentials';
        when(mockGateway.authorize(TestData.email, TestData.password))
            .thenAnswer((_) async => const Left(error));

        final result = await repository.authorize(TestData.email, TestData.password);

        expect(result, const Left(error));
        verify(mockGateway.authorize(TestData.email, TestData.password)).called(1);
      });
    });

    group('register', () {
      final request = TestData.registerRequest();

      test('should succeed and save email', () async {
        when(mockGateway.register(request))
            .thenAnswer((_) async => const Right(Right(unit)));

        final result = await repository.register(request);

        expect(result, const Right(Right(unit)));
        verify(mockGateway.register(request)).called(1);
      });

      test('should return error on failure', () async {
        const error = 'Email already exists';
        when(mockGateway.register(request))
            .thenAnswer((_) async => const Left(error));

        final result = await repository.register(request);

        expect(result, const Left(error));
        verify(mockGateway.register(request)).called(1);
      });
    });

    group('sendCode', () {
      test('should succeed when email is saved', () async {
        await registerAndSaveEmail();

        when(mockGateway.sendCode(TestData.email))
            .thenAnswer((_) async => const Right(unit));

        final result = await repository.sendCode();

        expect(result, const Right(unit));
        verify(mockGateway.sendCode(TestData.email)).called(1);
      });

      test('should fail when email is not saved', () async {
        final result = await repository.sendCode();

        expect(result.isLeft(), true);
        expect(
          result.fold((l) => l, (r) => r),
          contains('Registration email was not saved somehow'),
        );
        verifyNever(mockGateway.sendCode(any));
      });
    });

    group('verifyCode', () {
      test('should succeed when email is saved', () async {
        await registerAndSaveEmail();

        when(mockGateway.verifyCode(email: TestData.email, code: TestData.code))
            .thenAnswer((_) async => const Right(unit));

        final result = await repository.verifyCode(TestData.code);

        expect(result, const Right(unit));
        verify(mockGateway.verifyCode(email: TestData.email, code: TestData.code)).called(1);
      });

      test('should fail when email is not saved', () async {
        final result = await repository.verifyCode(TestData.code);

        expect(result.isLeft(), true);
        expect(
          result.fold((l) => l, (r) => r),
          contains('Registration email was not saved somehow'),
        );
        verifyNever(mockGateway.verifyCode(email: anyNamed('email'), code: anyNamed('code')));
      });
    });

    group('cleanEmail', () {
      test('should clear saved email', () async {
        await registerAndSaveEmail();

        repository.cleanEmail();

        final result = await repository.sendCode();
        expect(result.isLeft(), true);
        verifyNever(mockGateway.sendCode(any));
      });
    });

    group('setEmail', () {
      test('should manually set email', () async {
        const manualEmail = 'manual@innopolis.university';
        when(mockGateway.sendCode(manualEmail))
            .thenAnswer((_) async => const Right(unit));

        repository.setEmail(manualEmail);

        final result = await repository.sendCode();
        expect(result, const Right(unit));
        verify(mockGateway.sendCode(manualEmail)).called(1);
      });
    });
  });
}