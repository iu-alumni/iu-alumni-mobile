import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/code_verification/code_verification_cubit.dart';
import '../../../blocs/models/code_verification_state.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/nav_button.dart';
import '../../../router/app_router.gr.dart';

class CodeVerificationScaffold extends StatefulWidget {
  const CodeVerificationScaffold({required this.back, super.key});

  final void Function() back;

  @override
  State<CodeVerificationScaffold> createState() =>
      _CodeVerificationScaffoldState();
}

class _CodeVerificationScaffoldState extends State<CodeVerificationScaffold> {
  late final CodeVerificationCubit _cubit;

  static const _loader = AppLoader(color: Colors.white);

  @override
  void initState() {
    _cubit = context.read<CodeVerificationCubit>();
    super.initState();
  }

  void _listener(BuildContext context, CodeVerificationState state) {
    if (state.verification case LoadedStateData()) {
      final router = context.router;
      router.replaceAll([const RootRoute()]);
    }
  }

  void _sinkCode(String code) {
    _cubit.sinkCode(code);
    _cubit.checkCode();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<CodeVerificationCubit, CodeVerificationState>(
        listener: _listener,
        child: AppScaffold(
          leadingButton: NavButton(onTap: widget.back),
          title: 'Verification',
          body: AppListBody(children: [
            AppTextField(
              onChange: _sinkCode,
              initialText: null,
              hintText: 'XXXXXX',
              inputType: TextInputType.number,
              maxLines: 1,
            ),
            _ErrorText(mapError: (s) => s.verification),
            const SizedBox(height: 24),
            AppButton(
              onTap: _cubit.verify,
              child: BlocBuilder<CodeVerificationCubit, CodeVerificationState>(
                buildWhen: (p, c) => p.verification != c.verification,
                builder: (context, state) => switch (state.verification) {
                  LoadedStateLoading() => _loader,
                  _ => Text(
                      'Verify',
                      style: AppTextStyles.actionSB.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                },
              ),
            ),
            const SizedBox(height: 8),
            AppButton(
              onTap: _cubit.resend,
              buttonStyle: AppButtonStyle.secondary,
              child: BlocBuilder<CodeVerificationCubit, CodeVerificationState>(
                buildWhen: (p, c) => p.resend != c.resend,
                builder: (context, state) => switch (state.resend) {
                  LoadedStateLoading() => _loader,
                  _ => Text(
                      'Resend the code',
                      style: AppTextStyles.actionM.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                },
              ),
            ),
            _ErrorText(mapError: (s) => s.verification),
          ]),
        ),
      );
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({required this.mapError});

  final LoadedState Function(CodeVerificationState) mapError;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CodeVerificationCubit, CodeVerificationState>(
        buildWhen: (p, c) => mapError(p) != mapError(c),
        builder: (context, state) => AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: switch (mapError(state)) {
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
