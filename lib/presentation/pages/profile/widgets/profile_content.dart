import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../application/models/profile.dart';
import '../../../../application/repositories/reporter/reporter.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/profile_pic.dart';
import '../../../common/widgets/titled_item.dart';
import '../../root/root_page.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    required this.profile,
    required this.personal,
    super.key,
  });

  final Profile profile;
  final bool personal;

  static const _horPadding = EdgeInsets.symmetric(horizontal: 24);

  void _openTelegram(BuildContext context) {
    context.read<Reporter>().reportUserTelegramOpen(
          profile,
          AppLocation.profileScreen,
        );
    if (profile.telegramAlias case final tg?) {
      launchUrl(
        Uri.parse('https://t.me/$tg'),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void _copyTelegram(BuildContext context) {
    context.read<Reporter>().reportUserTelegramCopy(
          profile,
          AppLocation.profileScreen,
        );
    if (profile.telegramAlias case final tg?) {
      Clipboard.setData(ClipboardData(text: tg));
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          ProfilePic(profile: profile),
          const SizedBox(height: 16),
          Text(
            '${profile.firstName.trim()} ${profile.lastName.trim()}',
            style: AppTextStyles.h3,
            textAlign: TextAlign.center,
          ),
          Text(
            profile.graduationYear,
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
          ...[
            if (profile.biography case final bio?)
              TitledItem(
                title: 'Biography',
                child: Text(
                  bio,
                  style: AppTextStyles.body,
                ),
              ),
            if (profile.location case final location?)
              TitledItem(
                title: 'Location',
                child: Text(
                  location,
                  style: AppTextStyles.body,
                ),
              ),
            if (profile.telegramAlias case final telegram?)
              TitledItem(
                title: 'Telegram',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AppButton(
                        buttonStyle: AppButtonStyle.text,
                        child: Text(
                          '@$telegram',
                          style: AppTextStyles.body.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () => _copyTelegram(context),
                      ),
                    ),
                    const SizedBox(width: 2),
                    AppButton(
                      buttonStyle: AppButtonStyle.text,
                      onTap: () => _openTelegram(context),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.open_in_new,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // AppButton(onTap: () => launchUrl(
            //             Uri.parse(''),
            //             mode: LaunchMode.externalApplication,
            //           ), child: child,),
          ].expand(
            (e) => [
              const SizedBox(height: 16),
              Padding(padding: _horPadding, child: e),
            ],
          ),
          const SizedBox(height: RootPage.navigationBarHeight + 16),
        ],
      );
}
