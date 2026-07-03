import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/models/register_request.dart';
import '../../../application/repositories/auth/auth_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../common/models/loaded_state.dart';
import '../models/registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this._authRepository, this._reporter)
    : super(const RegistrationState(verification: LoadedState.init()));

  final AuthRepository _authRepository;
  final Reporter _reporter;

  String? _validateEmail(String email) =>
      (email.contains('@innopolis.university') ||
          email.contains('@innopolis.ru'))
      ? null
      : 'The email must contain either "innopolis.university" or "innopolis.ru"';

  String? _validatePassword(String pass) => pass.length < 8
      ? 'The password needs to contain at least 8 characters'
      : null;

  String? _validateTelegram(String? telegram) {
    if (telegram == null || telegram.isEmpty) return null;
    return telegram.length < 3
        ? 'Telegram alias must contain at least 3 characters'
        : null;
  }

  String? _trimmed(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  String _missingFieldsMessage(List<String> fields) {
    if (fields.length == 1) {
      return 'Please enter your ${fields.single}';
    }

    final allButLast = fields.take(fields.length - 1).join(', ');
    return 'Please enter your $allButLast, and ${fields.last}';
  }

  Either<String, RegisterRequest> _verificationData({required bool manual}) {
    final firstName = _trimmed(state.firstName);
    final lastName = _trimmed(state.lastName);
    final email = _trimmed(state.email);
    final password = state.password;
    final telegram = _trimmed(state.telegram);

    final missingFields = [
      if (firstName == null) 'first name',
      if (lastName == null) 'last name',
      if (email == null) 'university email',
      if (state.graduationYear == null) 'graduation year',
      if (password == null || password.isEmpty) 'password',
    ];

    if (missingFields.isNotEmpty) {
      return Left(_missingFieldsMessage(missingFields));
    }

    if (_validateTelegram(telegram) case final e?) {
      return Left(e);
    }

    return Right(
      RegisterRequest(
        firstName: firstName!,
        lastName: lastName!,
        gradYear: '${state.graduationYear}',
        email: email!,
        telegram: telegram,
        password: password!,
        manualVerification: manual,
      ),
    );
  }

  void toInitial() =>
      emit(const RegistrationState(verification: LoadedState.init()));

  void _register(bool manual) => verificationRequest(manual)
      .toTaskEither()
      .flatMap(
        (r) => TaskEither(() async {
          emit(state.copyWith(verification: const LoadedState.loading()));
          final result = await _authRepository.register(r);
          if (result case Left(:final value)) {
            _reporter.reportAuthError(value, AppLocation.verificationScreen);
          }
          return result;
        }),
      )
      .match(
        (e) => emit(state.copyWith(verification: LoadedState.error(e))),
        (d) => emit(state.copyWith(verification: LoadedState.data(d.isLeft()))),
      )
      .run();

  Either<String, RegisterRequest> verificationRequest(bool manual) =>
      _verificationData(manual: manual)
          .flatMap<RegisterRequest>(
            (r) => switch (_validateEmail(r.email)) {
              final e? => Left(e),
              _ => Either.of(r),
            },
          )
          .flatMap<RegisterRequest>(
            (r) => switch (_validatePassword(r.password)) {
              final e? => Left(e),
              _ => Either.of(r),
            },
          );

  Either<String, Unit> dataIsValid() =>
      verificationRequest(true).map((_) => unit);

  void registerManually() => _register(true);

  void registerViaEmail() => _register(false);

  void setEmail(String email) => emit(state.copyWith(email: email));

  void setPassword(String password) => emit(state.copyWith(password: password));

  void setGradYear(int year) => emit(state.copyWith(graduationYear: year));

  void setFirstName(String firstName) =>
      emit(state.copyWith(firstName: firstName));

  void setLastName(String lastName) => emit(state.copyWith(lastName: lastName));

  void setTelegram(String telegram) => emit(state.copyWith(telegram: telegram));

  void dispose() => _authRepository.cleanEmail();
}
