import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_colors.dart';

import '../../../blocs/auth/auth_cubit.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../router/app_router.gr.dart';

@RoutePage()
class SignInSubPage extends StatefulWidget {
  const SignInSubPage({super.key});

  @override
  State<SignInSubPage> createState() => _SignInSubPageState();
}

class _SignInSubPageState extends State<SignInSubPage> {
  var _email = '';
  var _password = '';

  void _auth() => context.read<AuthCubit>().authorize(_email, _password);

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
      body: AppListBody(
        children: [
          BlocBuilder<AuthCubit, LoadedState>(
            buildWhen: (p, c) => p is LoadedStateError != c is LoadedStateError,
            builder: (context, state) => AppTextField(
              initialText: null,
              onChange: (t) => _email = t,
              hintText: 'Innopolis Email',
              inputType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 8),
          AppTextField(
            initialText: null,
            onChange: (t) => _password = t,
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
                LoadedStateLoading() => const AppLoader(color: Colors.white),
                _ => Text(
                  'Sign in',
                  style: AppTextStyles.actionSB.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              },
            ),
          ),
          const SizedBox(height: 8),
          AppButton(
            onTap: () => context.pushRoute(
              RegistrationSubRoute(email: _email, password: _password),
            ),
            buttonStyle: AppButtonStyle.secondary,
            child: Text(
              'Register',
              style: AppTextStyles.actionM.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
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
        LoadedStateError(:final error) => Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            error,
            style: AppTextStyles.caption.copyWith(color: AppColors.error),
          ),
        ),
        _ => const SizedBox(),
      },
    ),
  );
}
