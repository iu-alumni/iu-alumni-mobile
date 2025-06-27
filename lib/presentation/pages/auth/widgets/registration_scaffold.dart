import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/models/verification_state.dart';
import '../../../blocs/verification/verification_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/nav_button.dart';
import '../../../router/app_router.gr.dart';
import 'year_picker.dart';

class RegistrationScaffold extends StatefulWidget {
  const RegistrationScaffold({
    required this.back,
    required this.email,
    required this.password,
    super.key,
  });

  final String email;
  final String password;
  final void Function() back;

  @override
  State<RegistrationScaffold> createState() => _RegistrationScaffoldState();
}

class _RegistrationScaffoldState extends State<RegistrationScaffold> {
  late final VerificationCubit _verificationCubit;

  @override
  void initState() {
    _verificationCubit = context.read<VerificationCubit>();
    _verificationCubit.setEmail(widget.email);
    _verificationCubit.setPassword(widget.password);
    super.initState();
  }

  void _pickGradYear() async {
    final year = await GraduationYearPicker.show(context);
    if (year != null) {
      _verificationCubit.setGradYear(year);
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<VerificationCubit, VerificationState>(
        listener: (context, state) {
          if (state.verification case LoadedStateData()) {
            context.router.replaceAll([const RootRoute()]);
          }
        },
        child: AppScaffold(
          leadingButton: NavButton(onTap: widget.back),
          title: 'Register',
          topSafeArea: false,
          body: AppListBody(children: [
            AppTextField(
              initialText: widget.email,
              onChange: _verificationCubit.setEmail,
              hintText: 'Email',
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            AppTextField(
              initialText: widget.password,
              onChange: _verificationCubit.setPassword,
              hintText: 'Password',
              inputType: TextInputType.visiblePassword,
              obscureText: true,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            AppButton(
              onTap: _pickGradYear,
              buttonStyle: AppButtonStyle.gray,
              child: BlocBuilder<VerificationCubit, VerificationState>(
                buildWhen: (p, c) => p.graduationYear != c.graduationYear,
                builder: (context, verData) {
                  final (content, isHint) = switch (verData.graduationYear) {
                    final year? => ('$year', false),
                    _ => ('Graduation year', true),
                  };
                  return Text(
                    content,
                    style: AppTextStyles.body.copyWith(
                      color: isHint ? AppColors.gray50 : AppColors.darkGray,
                    ),
                    textAlign: TextAlign.start,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            AppTextField(
              initialText: null,
              onChange: _verificationCubit.setFirstName,
              hintText: 'First name',
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            AppButton(
              onTap: _verificationCubit.verify,
              child: BlocBuilder<VerificationCubit, VerificationState>(
                buildWhen: (p, c) => p.verification != c.verification,
                builder: (context, verState) {
                  if (verState.verification case LoadedStateLoading()) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  return Text(
                    'Verify',
                    style: AppTextStyles.actionSB.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            const _ErrorText(),
          ]),
        ),
      );
}

class _ErrorText extends StatelessWidget {
  const _ErrorText();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) => AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: switch (state.verification) {
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
