import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_alumni_mobile/presentation/blocs/code_verification/code_verification_cubit.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_text_styles.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_button.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_scaffold.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_text_field.dart';
import 'package:ui_alumni_mobile/presentation/router/app_router.gr.dart';

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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Restore verification',
      body: AppListBody(
        children: [
          AppTextField(
            onChange: (a) => _email = a,
            initialText: null,
            hintText: 'Email',
          ),
          const SizedBox(height: 16),
          AppButton(
            child: Text(
              'Enter the code',
              style: AppTextStyles.actionSB.copyWith(color: Colors.white),
            ),
            onTap: () {
              context.read<CodeVerificationCubit>().setEmail(_email);
              context.pushRoute(const CodeVerificationSubRoute());
            },
          ),
        ],
      ),
    );
  }
}
