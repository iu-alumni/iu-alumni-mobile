import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/button.dart';

class OpenBotCard extends StatelessWidget {
  const OpenBotCard({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Join the telegram bot',
                style: AppTextStyles.h4,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              Text.rich(
                style: AppTextStyles.body,
                TextSpan(
                  children: [
                    const TextSpan(text: 'Receive '),
                    TextSpan(
                      text: 'notifications',
                      style: AppTextStyles.body.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' about events and participants via Telegram and share your ',
                    ),
                    TextSpan(
                      text: 'app experience',
                      style: AppTextStyles.body.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const TextSpan(text: ' to help the project develop'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              AppButton(
                buttonStyle: AppButtonStyle.secondary,
                onTap: () => launchUrl(
                  Uri.parse('https://t.me/IU_Alumni_Notification_Bot'),
                  mode: LaunchMode.externalApplication,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Open the bot',
                    style: AppTextStyles.buttonText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
