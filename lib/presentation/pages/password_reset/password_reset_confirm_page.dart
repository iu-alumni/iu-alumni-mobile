import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../application/repositories/auth/password_reset_repository.dart';
import '../../blocs/password_reset/password_reset_confirm_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_loader.dart';
import '../../common/widgets/app_scaffold.dart';
import '../../common/widgets/app_text_field.dart';
import '../../router/app_router.gr.dart';

@RoutePage()
class PasswordResetConfirmPage extends StatefulWidget
    implements AutoRouteWrapper {
  const PasswordResetConfirmPage({super.key, required this.token});

  final String token;

  @override
  State<PasswordResetConfirmPage> createState() =>
      _PasswordResetConfirmPageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    create: (context) =>
        PasswordResetConfirmCubit(context.read<PasswordResetRepository>()),
    child: this,
  );
}

class _PasswordResetConfirmPageState extends State<PasswordResetConfirmPage> {
  var _newPassword = '';
  var _confirmPassword = '';

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PasswordResetConfirmCubit, LoadedState<Unit>>(
        builder: (context, state) {
          if (state case LoadedStateData()) {
            return AppScaffold(
              title: 'Password updated',
              leadingButton: null,
              body: AppListBody(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Your password has been updated successfully. You can now log in with your new password.',
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.gray50),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    onTap: () =>
                        context.router.replaceAll([const AuthRoute()]),
                    child: Text(
                      'Back to login',
                      style: AppTextStyles.actionSB
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }
          return AppScaffold(
            title: 'Set new password',
            leadingButton: null,
            body: AppListBody(
              children: [
                AppTextField(
                  initialText: null,
                  onChange: (t) => _newPassword = t,
                  hintText: 'New password',
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                  maxLines: 1,
                ),
                const SizedBox(height: 8),
                AppTextField(
                  initialText: null,
                  onChange: (t) => _confirmPassword = t,
                  hintText: 'Confirm new password',
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                  maxLines: 1,
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
                  onTap: () =>
                      context.read<PasswordResetConfirmCubit>().confirmReset(
                        token: widget.token,
                        newPassword: _newPassword,
                        confirmPassword: _confirmPassword,
                      ),
                  child: switch (state) {
                    LoadedStateLoading() =>
                      const AppLoader(color: Colors.white),
                    _ => Text(
                      'Update password',
                      style: AppTextStyles.actionSB
                          .copyWith(color: Colors.white),
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
