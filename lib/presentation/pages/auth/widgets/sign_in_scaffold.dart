import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_cubit.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../router/app_router.gr.dart';

class SignInScaffold extends StatefulWidget {
  const SignInScaffold({
    required this.sinkEmail,
    required this.sinkPassword,
    required this.email,
    required this.password,
    required this.forward,
    super.key,
  });

  final void Function(String) sinkEmail;
  final void Function(String) sinkPassword;
  final String Function() email;
  final String Function() password;
  final void Function() forward;

  @override
  State<SignInScaffold> createState() => _SignInScaffoldState();
}

class _SignInScaffoldState extends State<SignInScaffold> {
  void _auth() => context.read<AuthCubit>().authorize(
        widget.email(),
        widget.password(),
      );

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, LoadedState>(
        listener: (context, state) {
          if (state case LoadedStateData()) {
            context.router.replaceAll([const RootRoute()]);
          }
        },
        child: AppScaffold(
          title: 'Sign in',
          leadingButton: null,
          topSafeArea: false,
          body: AppListBody(children: [
            BlocBuilder<AuthCubit, LoadedState>(
              buildWhen: (p, c) =>
                  p is LoadedStateError != c is LoadedStateError,
              builder: (context, state) => AppTextField(
                initialText: null,
                onChange: widget.sinkEmail,
                hintText: 'Innopolis Email',
                inputType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 8),
            AppTextField(
              initialText: null,
              onChange: widget.sinkPassword,
              hintText: 'Password',
              inputType: TextInputType.visiblePassword,
              obscureText: true,
              maxLines: 1,
            ),
            const _ErrorText(),
            const SizedBox(height: 16),
            AppButton(
              onTap: _auth,
              child: BlocBuilder<AuthCubit, LoadedState>(
                builder: (context, state) => switch (state) {
                  LoadedStateLoading() => const AppLoader(
                      color: Colors.white,
                    ),
                  _ => Text(
                      'Sign in',
                      style: AppTextStyles.actionSB.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                },
              ),
            ),
            const SizedBox(height: 8),
            AppButton(
              onTap: widget.forward,
              buttonStyle: AppButtonStyle.secondary,
              child: Text(
                'Register',
                style: AppTextStyles.actionM.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
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
