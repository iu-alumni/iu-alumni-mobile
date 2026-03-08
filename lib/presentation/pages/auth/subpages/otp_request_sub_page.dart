import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/models/otp_login_state.dart';
import '../../../blocs/otp_login/otp_login_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../router/app_router.gr.dart';

@RoutePage()
class OtpRequestSubPage extends StatefulWidget {
  const OtpRequestSubPage({super.key, this.email = ''});

  final String email;

  @override
  State<OtpRequestSubPage> createState() => _OtpRequestSubPageState();
}

class _OtpRequestSubPageState extends State<OtpRequestSubPage> {
  late var _email = widget.email;
  var _password = '';

  @override
  Widget build(BuildContext context) => BlocListener<OtpLoginCubit, OtpLoginState>(
    listenWhen: (p, c) => p.request != c.request,
    listener: (context, state) {
      if (state.request case LoadedStateData()) {
        context.pushRoute(const OtpVerifySubRoute());
      }
    },
    child: AppScaffold(
      title: 'Login with email code',
      topSafeArea: false,
      body: AppListBody(
        children: [
          AppTextField(
            initialText: _email.isNotEmpty ? _email : null,
            onChange: (t) => _email = t,
            hintText: 'Innopolis Email',
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8),
          AppTextField(
            initialText: null,
            onChange: (t) => _password = t,
            hintText: 'Password',
            inputType: TextInputType.visiblePassword,
            obscureText: true,
            maxLines: 1,
          ),
          BlocBuilder<OtpLoginCubit, OtpLoginState>(
            buildWhen: (p, c) => p.request != c.request,
            builder: (context, state) => AnimatedSize(
              duration: const Duration(milliseconds: 250),
              child: switch (state.request) {
                LoadedStateError(:final error) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    error,
                    style:
                        AppTextStyles.caption.copyWith(color: AppColors.error),
                  ),
                ),
                _ => const SizedBox(),
              },
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            onTap: () => context.read<OtpLoginCubit>().requestOtp(
              email: _email,
              password: _password,
            ),
            child: BlocBuilder<OtpLoginCubit, OtpLoginState>(
              buildWhen: (p, c) => p.request != c.request,
              builder: (context, state) => switch (state.request) {
                LoadedStateLoading() => const AppLoader(color: Colors.white),
                _ => Text(
                  'Send code',
                  style:
                      AppTextStyles.actionSB.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              },
            ),
          ),
        ],
      ),
    ),
  );
}
