import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_card.dart';

class OpenBotCard extends StatelessWidget {
  const OpenBotCard({super.key});

  @override
  Widget build(BuildContext context) => AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Join the telegram bot',
              style: AppTextStyles.subtitle,
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
              child: Text(
                'Open the bot',
                style: AppTextStyles.actionSB.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}
