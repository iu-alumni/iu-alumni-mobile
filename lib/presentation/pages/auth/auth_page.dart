import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../../application/repositories/auth/otp_login_repository.dart';
import '../../../application/repositories/auth/password_reset_repository.dart';
import '../../../application/repositories/auth/telegram_otp_login_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/code_verification/code_verification_cubit.dart';
import '../../blocs/otp_login/otp_login_cubit.dart';
import '../../blocs/password_reset/password_reset_request_cubit.dart';
import '../../blocs/registration/registration_cubit.dart';
import '../../blocs/telegram_otp_login/telegram_otp_login_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/widgets/alumni_logo.dart';

@RoutePage()
class AuthPage extends StatefulWidget implements AutoRouteWrapper {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => RegistrationCubit(
          context.read<AuthRepository>(),
          context.read<Reporter>(),
        ),
      ),
      BlocProvider(
        create: (context) =>
            AuthCubit(context.read<AuthRepository>(), context.read<Reporter>()),
      ),
      BlocProvider(
        create: (context) =>
            CodeVerificationCubit(context.read<AuthRepository>()),
      ),
      BlocProvider(
        create: (context) =>
            OtpLoginCubit(context.read<OtpLoginRepository>()),
      ),
      BlocProvider(
        create: (context) =>
            TelegramOtpLoginCubit(context.read<TelegramOtpLoginRepository>()),
      ),
      BlocProvider(
        create: (context) => PasswordResetRequestCubit(
          context.read<PasswordResetRepository>(),
        ),
      ),
    ],
    child: this,
  );
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) => const ColoredBox(
    color: AppColors.primary,
    child: SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 48),
            child: AlumniLogo(),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              child: AutoRouter(),
            ),
          ),
        ],
      ),
    ),
  );
}
