import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_alumni_mobile/presentation/router/app_router.gr.dart';

import '../../../blocs/models/registration_state.dart';
import '../../../blocs/registration/registration_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
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
  static const _topDesc =
      'To retain a safe and supportive community, we need to make sure you are a real alumnus';

  late final RegistrationCubit _registrationCubit;
  late final _error = ValueNotifier<String?>(null);

  @override
  void initState() {
    _registrationCubit = context.read<RegistrationCubit>();
    _registrationCubit.setEmail(widget.email);
    _registrationCubit.setPassword(widget.password);
    super.initState();
  }

  @override
  void dispose() {
    _error.dispose();
    super.dispose();
  }

  Future<void> _pickGradYear() async {
    final year = await GraduationYearPicker.show(context);
    if (year != null) {
      _registrationCubit.setGradYear(year);
    }
  }

  void _submit() {
    final validation = _registrationCubit.dataIsValid();
    validation.fold(
      (e) => _error.value = e,
      (_) {
        _error.value = null;
        _registrationCubit.registerViaEmail();
      },
    );
  }

  void _listen(BuildContext context, RegistrationState state) {
    if (state.verification case LoadedStateData(:final data)) {
      if (data) {
        // manual verification pending
        _showMessage(
          context,
          'Registration successful. Your account is pending manual verification by an administrator.',
        );
        context.router.popUntilRoot();
        return;
      }
      // auto verification: link sent to email
      _showMessage(
        context,
        'Registration successful! Please check your email for a confirmation link to activate your account.',
      );
      context.router.popUntilRoot();
    }
  }

  void _showMessage(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 6),
          behavior: SnackBarBehavior.floating,
        ),
      );

  @override
  Widget build(BuildContext context) => BlocListener<RegistrationCubit, RegistrationState>(
    listener: _listen,
    child: PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _registrationCubit.toInitial();
        }
      },
      child: AppScaffold(
        title: 'Registration',
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
              hintText: 'Telegram alias (optional)',
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
            ValueListenableBuilder(
              valueListenable: _error,
              builder: (context, text, _) => text == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        text.trim(),
                        textAlign: TextAlign.start,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
            ),
            BlocBuilder<RegistrationCubit, RegistrationState>(
              buildWhen: (p, c) => p.verification != c.verification,
              builder: (context, state) {
                if (state.verification case LoadedStateError(:final error)) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      error.trim(),
                      textAlign: TextAlign.start,
                      style: AppTextStyles.caption.copyWith(color: AppColors.error),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 16),
            AppButton(
              onTap: _submit,
              buttonStyle: AppButtonStyle.secondary,
              child: BlocBuilder<RegistrationCubit, RegistrationState>(
                buildWhen: (p, c) => p.verification != c.verification,
                builder: (context, state) {
                  if (state.verification case LoadedStateLoading()) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  }
                  return Text(
                    'Register',
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
}
