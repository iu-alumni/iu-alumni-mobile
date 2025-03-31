import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../blocs/auth/auth_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/alumni_logo.dart';
import '../../common/widgets/app_text_field.dart';
import '../../common/widgets/button.dart';
import '../../router/app_router.gr.dart';

@RoutePage()
class AuthPage extends StatefulWidget implements AutoRouteWrapper {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => AuthCubit(context.read<AuthRepository>()),
        child: this,
      );
}

class _AuthPageState extends State<AuthPage> {
  var _login = '';
  var _password = '';

  void _auth() => context.read<AuthCubit>().authorize(_login, _password);

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, LoadedState>(
        listener: (context, state) {
          if (state case LoadedStateData()) {
            context.replaceRoute(const RootRoute());
          }
          if (state case LoadedStateError()) {
            context.pushRoute(
              VerificationRoute(
                initialEmail: _login,
                initialPassword: _password,
              ),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 80),
                  const AlumniLogo(),
                  const SizedBox(height: 160),
                  Text('Sing In', style: AppTextStyles.h3),
                  const SizedBox(height: 16),
                  AppTextField(
                    initialText: null,
                    onChange: (text) => _login = text,
                    hintText: 'email@innopolis.university',
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    initialText: null,
                    onChange: (text) => _password = text,
                    hintText: 'password',
                    inputType: TextInputType.visiblePassword,
                    obscureText: true,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    onTap: _auth,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: BlocBuilder<AuthCubit, LoadedState>(
                          builder: (context, state) {
                        if (state case LoadedStateLoading()) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        return Text(
                          'Continue',
                          style: AppTextStyles.buttonText,
                          textAlign: TextAlign.center,
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    onTap: _auth,
                    buttonStyle: AppButtonStyle.text,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Forgot password?',
                        style: AppTextStyles.buttonText.copyWith(
                          color: AppColors.darkGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
