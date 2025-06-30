import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/models/registration_state.dart';
import '../../../blocs/registration/registration_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/nav_button.dart';
import 'year_picker.dart';

class RegistrationScaffold extends StatefulWidget {
  const RegistrationScaffold({
    required this.back,
    required this.toVerification,
    required this.email,
    required this.password,
    super.key,
  });

  final String email;
  final String password;
  final void Function() back;
  final void Function() toVerification;

  @override
  State<RegistrationScaffold> createState() => _RegistrationScaffoldState();
}

class _RegistrationScaffoldState extends State<RegistrationScaffold> {
  static const _bottomDesc =
      'You would need to enter a 6-digit code sent to your university mail address. This is the quickest and safest way for us to know you are a real alumnus. If you don’t have access to the mail address, proceed with manual verification';
  static const _topDesc =
      'To retain safe and supportive community, we need to make sure you are a real alumnus';

  late final RegistrationCubit _verificationCubit;

  @override
  void initState() {
    _verificationCubit = context.read<RegistrationCubit>();
    _verificationCubit.setEmail(widget.email);
    _verificationCubit.setPassword(widget.password);
    super.initState();
  }

  @override
  void dispose() {
    _verificationCubit.dispose();
    super.dispose();
  }

  void _pickGradYear() async {
    final year = await GraduationYearPicker.show(context);
    if (year != null) {
      _verificationCubit.setGradYear(year);
    }
  }

  void _listen(BuildContext context, RegistrationState state) {
    if (state.verification case LoadedStateData(:final data)) {
      if (data) {
        widget.back();
        _showVerificationInitiated();
        return;
      }
      widget.toVerification();
    }
  }

  void _showVerificationInitiated() => showCupertinoModalPopup(
        context: context,
        builder: (context) => Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'We will check the provided data and come back with an answer soon! 👀',
                style: AppTextStyles.subtitle,
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) =>
      BlocListener<RegistrationCubit, RegistrationState>(
        listener: _listen,
        child: AppScaffold(
          leadingButton: NavButton(onTap: widget.back),
          title: 'Register',
          topSafeArea: false,
          body: AppListBody(children: [
            Text(
              _topDesc,
              style: AppTextStyles.body,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            AppTextField(
              initialText: null,
              onChange: _verificationCubit.setFirstName,
              hintText: 'First name',
              inputType: TextInputType.name,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            AppTextField(
              initialText: null,
              onChange: _verificationCubit.setLastName,
              hintText: 'Last name',
              inputType: TextInputType.name,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            AppTextField(
              initialText: widget.email,
              onChange: _verificationCubit.setEmail,
              hintText: 'University email',
              inputType: TextInputType.emailAddress,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            AppButton(
              onTap: _pickGradYear,
              buttonStyle: AppButtonStyle.gray,
              child: BlocBuilder<RegistrationCubit, RegistrationState>(
                buildWhen: (p, c) => p.graduationYear != c.graduationYear,
                builder: (context, verData) {
                  final (content, isHint) = switch (verData.graduationYear) {
                    final year? => ('$year', false),
                    _ => ('Graduation year', true),
                  };
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      content,
                      style: AppTextStyles.body.copyWith(
                        color: isHint ? AppColors.gray50 : AppColors.darkGray,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            AppTextField(
              initialText: null,
              onChange: _verificationCubit.setTelegram,
              hintText: 'Telegram alias',
              inputType: TextInputType.text,
              maxLines: 1,
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
            const _ErrorText(),
            const SizedBox(height: 24),
            Text(
              _bottomDesc,
              style: AppTextStyles.caption,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            AppButton(
              onTap: _verificationCubit.registerViaEmail,
              child: BlocBuilder<RegistrationCubit, RegistrationState>(
                buildWhen: (p, c) => p.verification != c.verification,
                builder: (context, verState) {
                  if (verState.verification case LoadedStateLoading()) {
                    return const Center(child: AppLoader(color: Colors.white));
                  }
                  return Text(
                    'Verify via email',
                    style: AppTextStyles.actionSB.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            AppButton(
              onTap: _verificationCubit.registerManually,
              buttonStyle: AppButtonStyle.secondary,
              child: BlocBuilder<RegistrationCubit, RegistrationState>(
                buildWhen: (p, c) => p.verification != c.verification,
                builder: (context, verState) {
                  if (verState.verification case LoadedStateLoading()) {
                    return const Center(child: AppLoader(color: Colors.white));
                  }
                  return Text(
                    'Verify manually',
                    style: AppTextStyles.actionM.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ]),
        ),
      );
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
                padding: const EdgeInsets.only(top: 24),
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
