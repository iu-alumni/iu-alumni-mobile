import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../blocs/models/verification_state.dart';
import '../../blocs/verification/verification_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/alumni_logo.dart';
import '../../common/widgets/app_text_field.dart';
import '../../common/widgets/button.dart';
import '../../router/app_router.gr.dart';
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
        create: (ctx) => VerificationCubit(
          ctx.read<AuthRepository>(),
          ctx.read<Reporter>(),
        ),
        child: this,
      );
}

// TODO verification page flow must change, not production ready
class _VerificationPageState extends State<VerificationPage> {
  late final VerificationCubit _verificationCubit;

  @override
  void initState() {
    _verificationCubit = context.read<VerificationCubit>();
    SchedulerBinding.instance.addPostFrameCallback((_) => _initCubit());
    super.initState();
  }

  void _initCubit() {
    _verificationCubit.setEmail(widget.initialEmail);
    if (widget.initialPassword case final pass?) {
      _verificationCubit.setPassword(pass);
    }
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
        child: Scaffold(
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
                  const SizedBox(height: 80),
                  Text('Verification', style: AppTextStyles.h3),
                  const SizedBox(height: 16),
                  AppTextField(
                    initialText: widget.initialEmail,
                    onChange: _verificationCubit.setEmail,
                    hintText: 'Email',
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    initialText: widget.initialPassword,
                    onChange: _verificationCubit.setPassword,
                    hintText: 'Password',
                    inputType: TextInputType.visiblePassword,
                    obscureText: true,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8),
                  AppButton(
                    onTap: _pickGradYear,
                    buttonStyle: AppButtonStyle.input,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: BlocBuilder<VerificationCubit, VerificationState>(
                        buildWhen: (p, c) =>
                            p.graduationYear != c.graduationYear,
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
                  const _ErrorText(),
                ],
              ),
            ),
          ),
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
