import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_alumni_mobile/presentation/router/app_router.gr.dart';

import '../../../blocs/models/registration_state.dart';
import '../../../blocs/registration/registration_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_text_field.dart';
import '../widgets/year_picker.dart';

@RoutePage()
class RegistrationSubPage extends StatefulWidget {
  const RegistrationSubPage({
    required this.email,
    required this.password,
    super.key,
  });

  final String email;
  final String password;

  @override
  State<RegistrationSubPage> createState() => _RegistrationSubPageState();
}

class _RegistrationSubPageState extends State<RegistrationSubPage> {
  static const _bottomDesc =
      'You would need to enter a 6-digit code sent to your university mail address. This is the quickest and safest way for us to know you are a real alumnus. If you don’t have access to the mail address, proceed with manual verification';
  static const _topDesc =
      'To retain safe and supportive community, we need to make sure you are a real alumnus';

  late final RegistrationCubit _registrationCubit;

  @override
  void initState() {
    _registrationCubit = context.read<RegistrationCubit>();
    _registrationCubit.setEmail(widget.email);
    _registrationCubit.setPassword(widget.password);
    super.initState();
  }

  Future<void> _pickGradYear() async {
    final year = await GraduationYearPicker.show(context);
    if (year != null) {
      _registrationCubit.setGradYear(year);
    }
  }

  void _listen(BuildContext context, RegistrationState state) {
    if (state.verification case LoadedStateData(:final data)) {
      if (data) {
        context.maybePop();
        _showVerificationInitiated();
        return;
      }
      context.pushRoute(const CodeVerificationSubRoute());
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
  Widget build(BuildContext context) => PopScope(
    onPopInvokedWithResult: (didPop, result) {
      if (didPop) {
        _registrationCubit.toInitial();
      }
    },
    child: BlocListener<RegistrationCubit, RegistrationState>(
      listener: _listen,
      child: AppScaffold(
        title: 'Register',
        topSafeArea: false,
        body: AppListBody(
          children: [
            const Text(
              _topDesc,
              style: AppTextStyles.body,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            AppTextField(
              initialText: null,
              onChange: _registrationCubit.setFirstName,
              hintText: 'First name',
              inputType: TextInputType.name,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            AppTextField(
              initialText: null,
              onChange: _registrationCubit.setLastName,
              hintText: 'Last name',
              inputType: TextInputType.name,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            AppTextField(
              initialText: widget.email,
              onChange: _registrationCubit.setEmail,
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
              onChange: _registrationCubit.setTelegram,
              hintText: 'Telegram alias',
              inputType: TextInputType.text,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            AppTextField(
              initialText: widget.password,
              onChange: _registrationCubit.setPassword,
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
              onTap: _registrationCubit.registerViaEmail,
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
              onTap: _registrationCubit.registerManually,
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
            const SizedBox(height: 16),
          ],
        ),
      ),
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
