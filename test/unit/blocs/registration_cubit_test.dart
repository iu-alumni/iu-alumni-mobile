import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ui_alumni_mobile/application/models/register_request.dart';
import 'package:ui_alumni_mobile/application/repositories/auth/auth_repository.dart';
import 'package:ui_alumni_mobile/application/repositories/reporter/reporter_mock.dart';
import 'package:ui_alumni_mobile/presentation/blocs/registration/registration_cubit.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<Either<String, Unit>> authorize(String login, String password) async =>
      const Right(unit);

  @override
  void cleanEmail() {}

  @override
  Future<Either<String, Either<Unit, Unit>>> register(
    RegisterRequest request,
  ) async =>
      const Right(Right(unit));

  @override
  Future<Either<String?, Unit>> sendCode() async => const Right(unit);

  @override
  void setEmail(String email) {}

  @override
  Future<Either<String?, Unit>> verifyCode(String code) async =>
      const Right(unit);
}

String _leftMessage(Either<String, RegisterRequest> result) =>
    result.fold((error) => error, (_) => fail('Expected validation error'));

RegisterRequest _rightRequest(Either<String, RegisterRequest> result) =>
    result.fold((error) => fail(error), (request) => request);

void main() {
  late _FakeAuthRepository authRepository;
  late RegistrationCubit cubit;

  setUp(() {
    authRepository = _FakeAuthRepository();
    cubit = RegistrationCubit(authRepository, ReporterMock());
  });

  tearDown(() => cubit.close());

  void fillRequiredFields() {
    cubit
      ..setFirstName('Ada')
      ..setLastName('Lovelace')
      ..setEmail('ada@innopolis.university')
      ..setGradYear(2024)
      ..setPassword('password123');
  }

  group('RegistrationCubit validation', () {
    test('returns clear missing-field message for blank required fields', () {
      cubit
        ..setFirstName('   ')
        ..setLastName('')
        ..setEmail('  ')
        ..setPassword('');

      final result = cubit.verificationRequest(false);

      expect(result.isLeft(), isTrue);
      expect(
        _leftMessage(result),
        'Please enter your first name, last name, university email, '
        'graduation year, and password',
      );
    });

    test('trims required fields and omits blank optional Telegram alias', () {
      cubit
        ..setFirstName('  Ada  ')
        ..setLastName('  Lovelace  ')
        ..setEmail('  ada@innopolis.university  ')
        ..setGradYear(2024)
        ..setTelegram('   ')
        ..setPassword('password123');

      final request = _rightRequest(cubit.verificationRequest(false));

      expect(request?.firstName, 'Ada');
      expect(request?.lastName, 'Lovelace');
      expect(request?.email, 'ada@innopolis.university');
      expect(request?.telegram, isNull);
    });

    test('returns clear message for too-short Telegram alias', () {
      fillRequiredFields();
      cubit.setTelegram('@a');

      final result = cubit.verificationRequest(false);

      expect(result.isLeft(), isTrue);
      expect(
        _leftMessage(result),
        'Telegram alias must contain at least 3 characters',
      );
    });
  });
}
