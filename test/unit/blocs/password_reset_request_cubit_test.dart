import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ui_alumni_mobile/application/repositories/auth/password_reset_repository.dart';
import 'package:ui_alumni_mobile/presentation/blocs/password_reset/password_reset_request_cubit.dart';
import 'package:ui_alumni_mobile/presentation/common/models/loaded_state.dart';
import 'package:ui_alumni_mobile/presentation/common/utils/university_email.dart';

class _FakePasswordResetRepository implements PasswordResetRepository {
  String? requestedEmail;

  @override
  Future<Either<String, Unit>> requestReset(String email) async {
    requestedEmail = email;
    return const Right(unit);
  }

  @override
  Future<Either<String, Unit>> confirmReset({
    required String token,
    required String newPassword,
  }) async =>
      const Right(unit);
}

void main() {
  late _FakePasswordResetRepository repository;
  late PasswordResetRequestCubit cubit;

  setUp(() {
    repository = _FakePasswordResetRepository();
    cubit = PasswordResetRequestCubit(repository);
  });

  tearDown(() => cubit.close());

  test('rejects non-Innopolis email before requesting reset link', () async {
    await cubit.requestReset('person@example.com');

    expect(
      cubit.state,
      const LoadedState<Unit>.error(universityEmailDomainError),
    );
    expect(repository.requestedEmail, isNull);
  });

  test('trims and submits Innopolis email', () async {
    await cubit.requestReset('  person@innopolis.university  ');

    expect(cubit.state, const LoadedState<Unit>.data(unit));
    expect(repository.requestedEmail, 'person@innopolis.university');
  });
}
