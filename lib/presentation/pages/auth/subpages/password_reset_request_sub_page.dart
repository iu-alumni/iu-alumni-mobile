import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/password_reset/password_reset_request_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_text_field.dart';

@RoutePage()
class PasswordResetRequestSubPage extends StatefulWidget {
  const PasswordResetRequestSubPage({super.key});

  @override
  State<PasswordResetRequestSubPage> createState() =>
      _PasswordResetRequestSubPageState();
}

class _PasswordResetRequestSubPageState
    extends State<PasswordResetRequestSubPage> {
  var _email = '';

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PasswordResetRequestCubit, LoadedState<Unit>>(
        builder: (context, state) {
          if (state case LoadedStateData()) {
            return AppScaffold(
              title: 'Check your email',
              topSafeArea: false,
              body: AppListBody(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'If your email is registered, a password reset link has been sent. '
                    'Check your inbox and click the link to set a new password.',
                    style: AppTextStyles.caption.copyWith(color: AppColors.gray50),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    onTap: () {
                      context.read<PasswordResetRequestCubit>().reset();
                    },
                    buttonStyle: AppButtonStyle.secondary,
                    child: Text(
                      'Send again',
                      style: AppTextStyles.actionM.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
          return AppScaffold(
            title: 'Forgot password',
            topSafeArea: false,
            body: AppListBody(
              children: [
                Text(
                  'Enter your Innopolis email and we will send you a link to reset your password.',
                  style: AppTextStyles.caption.copyWith(color: AppColors.gray50),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  initialText: null,
                  onChange: (t) => _email = t,
                  hintText: 'Innopolis Email',
                  inputType: TextInputType.emailAddress,
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  child: switch (state) {
                    LoadedStateError(:final error) => Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        error,
                        style: AppTextStyles.caption
                            .copyWith(color: AppColors.error),
                      ),
                    ),
                    _ => const SizedBox(),
                  },
                ),
                const SizedBox(height: 16),
                AppButton(
                  onTap: () => context
                      .read<PasswordResetRequestCubit>()
                      .requestReset(_email),
                  child: switch (state) {
                    LoadedStateLoading() =>
                      const AppLoader(color: Colors.white),
                    _ => Text(
                      'Send reset link',
                      style:
                          AppTextStyles.actionSB.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  },
                ),
              ],
            ),
          );
        },
      );
}
