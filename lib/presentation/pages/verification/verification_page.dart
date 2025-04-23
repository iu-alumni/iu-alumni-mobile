import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/verification/verification_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/alumni_logo.dart';
import '../../common/widgets/app_text_field.dart';
import '../../common/widgets/button.dart';
import 'widgets/year_picker.dart';

@RoutePage()
class VerificationPage extends StatefulWidget implements AutoRouteWrapper {
  final String initialEmail;
  final String? initialPassword;

  const VerificationPage({
    required this.initialEmail,
    required this.initialPassword,
    super.key,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (ctx) => VerificationCubit(),
        child: this,
      );
}

// TODO verification page flow must change, not production ready
class _VerificationPageState extends State<VerificationPage> {
  late final _formatter = DateFormat('d.MM.yyyy');
  late final VerificationCubit _verificationCubit;

  late String? _login = widget.initialEmail;
  late String? _password = widget.initialPassword;

  @override
  void initState() {
    _verificationCubit = context.read<VerificationCubit>();
    super.initState();
  }

  void _verify() => switch ((_login, _password)) {
        (final a?, final b?) => _verificationCubit.verify(a, b),
        _ => null,
      };

  void _pickGradYear() async {
    final year = await GraduationYearPicker.show(context);
    if (year != null) {
      _verificationCubit.setGradYear(year);
    }
  }

  void _pickBirthDay() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      _verificationCubit.setBirthDate(date);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                const SizedBox(height: 160),
                Text('Verification', style: AppTextStyles.h3),
                const SizedBox(height: 16),
                AppTextField(
                  initialText: widget.initialEmail,
                  onChange: (text) => _login = text,
                  hintText: 'email@innopolis.university',
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  initialText: widget.initialPassword,
                  onChange: (text) => _password = text,
                  hintText: 'password',
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                  maxLines: 1,
                ),
                const SizedBox(height: 16),
                AppButton(
                  onTap: _pickGradYear,
                  buttonStyle: AppButtonStyle.input,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: BlocBuilder<VerificationCubit, VerificationState>(
                      buildWhen: (p, c) => p.graduationYear != c.graduationYear,
                      builder: (context, verData) {
                        final (content, isHint) =
                            switch (verData.graduationYear) {
                          final year? => ('$year', false),
                          _ => ('Graduation year', true),
                        };
                        return Text(
                          content,
                          style: AppTextStyles.body.copyWith(
                            color: isHint
                                ? AppColors.blueGray
                                : AppColors.darkGray,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AppButton(
                  onTap: _pickBirthDay,
                  buttonStyle: AppButtonStyle.input,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: BlocBuilder<VerificationCubit, VerificationState>(
                      buildWhen: (p, c) => p.birthDate != c.birthDate,
                      builder: (context, verData) {
                        final (content, isHint) = switch (verData.birthDate) {
                          final bd? => (_formatter.format(bd), false),
                          _ => ('Birthdate', true),
                        };
                        return Text(
                          content,
                          style: AppTextStyles.body.copyWith(
                            color: isHint
                                ? AppColors.blueGray
                                : AppColors.darkGray,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AppButton(
                  onTap: _verify,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
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
                          style: AppTextStyles.buttonText,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
