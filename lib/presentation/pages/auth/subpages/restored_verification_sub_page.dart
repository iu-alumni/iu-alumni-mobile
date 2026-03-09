import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_colors.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_text_styles.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_button.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_loader.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_scaffold.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_text_field.dart';

import '../../../application/repositories/auth/auth_repository.dart';

@RoutePage()
class RestoredVerificationSubPage extends StatefulWidget {
  const RestoredVerificationSubPage({super.key});

  @override
  State<RestoredVerificationSubPage> createState() =>
      _RestoredVerificationSubPageState();
}

class _RestoredVerificationSubPageState
    extends State<RestoredVerificationSubPage> {
  var _email = '';
  var _loading = false;
  String? _message;
  bool _success = false;

  Future<void> _resend() async {
    if (_email.isEmpty) return;
    setState(() {
      _loading = true;
      _message = null;
    });
    final repo = context.read<AuthRepository>();
    repo.setEmail(_email);
    final result = await repo.sendCode();
    if (!mounted) return;
    setState(() {
      _loading = false;
      result.fold(
        (error) {
          _message = error ?? 'Failed to resend. Please try again.';
          _success = false;
        },
        (_) {
          _message = 'Verification link sent! Please check your email.';
          _success = true;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Resend verification',
    body: AppListBody(
      children: [
        AppTextField(
          onChange: (a) => _email = a,
          initialText: null,
          hintText: 'Email',
        ),
        if (_message case final msg?)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              msg,
              style: AppTextStyles.caption.copyWith(
                color: _success ? Colors.green : AppColors.error,
              ),
            ),
          ),
        const SizedBox(height: 16),
        AppButton(
          onTap: _loading ? () {} : _resend,
          child: _loading
              ? const AppLoader(color: Colors.white)
              : Text(
                  'Resend verification email',
                  style: AppTextStyles.actionSB.copyWith(color: Colors.white),
                ),
        ),
      ],
    ),
  );
}
