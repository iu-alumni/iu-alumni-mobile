import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/models/telegram_otp_login_state.dart';
import '../../../blocs/telegram_otp_login/telegram_otp_login_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../router/app_router.gr.dart';

@RoutePage()
class TelegramOtpVerifySubPage extends StatelessWidget {
  const TelegramOtpVerifySubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TelegramOtpLoginCubit>();
    return BlocListener<TelegramOtpLoginCubit, TelegramOtpLoginState>(
      listenWhen: (p, c) => p.verify != c.verify,
      listener: (context, state) {
        if (state.verify case LoadedStateData()) {
          context.router.replaceAll([const RootRoute()]);
        }
      },
      child: AppScaffold(
        title: 'Enter Telegram code',
        topSafeArea: false,
        body: AppListBody(
          children: [
            const _InfoText(),
            const SizedBox(height: 16),
            AppTextField(
              onChange: (code) {
                cubit.sinkCode(code);
                cubit.checkCode();
              },
              initialText: null,
              hintText: 'XXXXXX',
              inputType: TextInputType.number,
              maxLines: 1,
            ),
            BlocBuilder<TelegramOtpLoginCubit, TelegramOtpLoginState>(
              buildWhen: (p, c) => p.verify != c.verify,
              builder: (context, state) => AnimatedSize(
                duration: const Duration(milliseconds: 250),
                child: switch (state.verify) {
                  LoadedStateError(:final error) => Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      error,
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.error),
                    ),
                  ),
                  _ => const SizedBox(),
                },
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              onTap: () => context
                  .read<TelegramOtpLoginCubit>()
                  .verifyOtp(),
              child: BlocBuilder<TelegramOtpLoginCubit, TelegramOtpLoginState>(
                buildWhen: (p, c) => p.verify != c.verify,
                builder: (context, state) => switch (state.verify) {
                  LoadedStateLoading() =>
                    const AppLoader(color: Colors.white),
                  _ => Text(
                    'Verify',
                    style: AppTextStyles.actionSB
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                },
              ),
            ),
            const SizedBox(height: 8),
            AppButton(
              onTap: () {
                cubit.reset();
                Navigator.pop(context);
              },
              buttonStyle: AppButtonStyle.text,
              child: Text(
                'Request a new code',
                style: AppTextStyles.actionM,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText();

  @override
  Widget build(BuildContext context) => Text(
    'A 6-digit code was sent to your Telegram. It expires in 10 minutes.',
    style: AppTextStyles.caption.copyWith(color: AppColors.gray50),
    textAlign: TextAlign.center,
  );
}
