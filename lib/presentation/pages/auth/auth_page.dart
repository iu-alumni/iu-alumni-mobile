import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../blocs/auth/auth_cubit.dart';
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

  void _register() => context.pushRoute(
        VerificationRoute(
          initialEmail: _login,
          initialPassword: _password,
        ),
      );

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, LoadedState>(
        listener: (context, state) {
          if (state case LoadedStateData()) {
            context.router.replaceAll([const RootRoute()]);
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
                  const SizedBox(height: 80),
                  Text('Sing In', style: AppTextStyles.h3),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthCubit, LoadedState>(
                    buildWhen: (p, c) =>
                        p is LoadedStateError != c is LoadedStateError,
                    builder: (context, state) => AppTextField(
                      initialText: null,
                      onChange: (text) => _login = text,
                      hintText: 'Innopolis Email',
                      inputType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    initialText: null,
                    onChange: (text) => _password = text,
                    hintText: 'Password',
                    inputType: TextInputType.visiblePassword,
                    obscureText: true,
                    maxLines: 1,
                  ),
                  const _ErrorText(),
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
                            'Sign in',
                            style: AppTextStyles.buttonText,
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppButton(
                    onTap: _register,
                    buttonStyle: AppButtonStyle.secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Register',
                        style: AppTextStyles.buttonText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 8),
                  // AppButton(
                  //   onTap: _auth,
                  //   buttonStyle: AppButtonStyle.text,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(24),
                  //     child: Text(
                  //       'Forgot password?',
                  //       style: AppTextStyles.buttonText.copyWith(
                  //         color: AppColors.darkGray,
                  //       ),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _ErrorText extends StatelessWidget {
  const _ErrorText();

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthCubit, LoadedState>(
        builder: (context, state) => AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: switch (state) {
            LoadedStateError(:final error) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    error,
                    style: AppTextStyles.caption,
                  )
                ],
              ),
            _ => const SizedBox(),
          },
        ),
      );
}
