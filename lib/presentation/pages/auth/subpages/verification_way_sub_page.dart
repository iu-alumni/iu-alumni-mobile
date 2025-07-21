import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_alumni_mobile/presentation/blocs/models/registration_state.dart';
import 'package:ui_alumni_mobile/presentation/blocs/registration/registration_cubit.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_colors.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_text_styles.dart';
import 'package:ui_alumni_mobile/presentation/common/models/loaded_state.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_button.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_loader.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_scaffold.dart';

import 'package:ui_alumni_mobile/presentation/router/app_router.gr.dart';

@RoutePage()
class VerificationWaySubPage extends StatelessWidget {
  const VerificationWaySubPage({super.key});

  static const _desc =
      'You would need to enter a 6-digit code sent to your university mail address. This is the quickest and safest way for us to know you are a real alumnus. If you don’t have access to the mail address, pick manual verification';

  void _listen(BuildContext context, RegistrationState state) {
    if (state.verification case LoadedStateData(:final data)) {
      if (data) {
        _showVerificationInitiated(context);
        context.router.popUntilRoot();
        return;
      }
      context.replaceRoute(const CodeVerificationSubRoute());
    }
  }

  void _showVerificationInitiated(
    BuildContext context,
  ) => showCupertinoModalPopup(
    context: context,
    builder: (context) => Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Registration successful. Your account is pending manual verification',
            style: AppTextStyles.subtitle,
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final regCubit = context.read<RegistrationCubit>();
    return BlocListener<RegistrationCubit, RegistrationState>(
      listener: _listen,
      child: AppScaffold(
        title: 'Verification',
        body: AppListBody(
          children: [
            const Text(
              _desc,
              style: AppTextStyles.body,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            AppButton(
              onTap: regCubit.registerViaEmail,
              child: BlocBuilder<RegistrationCubit, RegistrationState>(
                buildWhen: (p, c) => p.verification != c.verification,
                builder: (context, verState) {
                  if (verState.verification case LoadedStateLoading()) {
                    return const Center(child: AppLoader(color: Colors.white));
                  }
                  return Text(
                    'Verify via email',
                    style: AppTextStyles.actionSB.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            AppButton(
              onTap: regCubit.registerManually,
              buttonStyle: AppButtonStyle.secondary,
              child: BlocBuilder<RegistrationCubit, RegistrationState>(
                buildWhen: (p, c) => p.verification != c.verification,
                builder: (context, verState) {
                  if (verState.verification case LoadedStateLoading()) {
                    return const Center(child: AppLoader(color: Colors.white));
                  }
                  return Text(
                    'Verify manually',
                    style: AppTextStyles.actionM.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            const _ErrorText(),
          ],
        ),
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationCubit, RegistrationState>(
        buildWhen: (p, c) => p.verification != c.verification,
        builder: (context, state) => AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: switch (state.verification) {
            LoadedStateError(:final error) => Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                error.trim(),
                style: AppTextStyles.caption.copyWith(color: AppColors.error),
              ),
            ),
            _ => const SizedBox(),
          },
        ),
      );
}
