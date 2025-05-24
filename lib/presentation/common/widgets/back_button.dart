import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'button.dart';

class AppSmallButton extends StatelessWidget {
  const AppSmallButton({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) => Padding(
        // 16 + 8 around the text = 24 horizontal
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppButton(
          buttonStyle: AppButtonStyle.text,
          onTap: context.maybePop,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            child: Text(
              text ?? 'Back',
              style: AppTextStyles.buttonText.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      );
}
