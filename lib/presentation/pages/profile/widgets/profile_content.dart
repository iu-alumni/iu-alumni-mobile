import 'package:flutter/widgets.dart';

import '../../../../application/models/profile.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/titled_item.dart';
import '../../root/root_page.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({required this.profile, super.key});

  final Profile profile;

  static const _horPadding = EdgeInsets.symmetric(horizontal: 40);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: _horPadding,
            child: Text(
              '${profile.firstName.trim()} ${profile.lastName.trim()}',
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: _horPadding,
            child: Text(
              profile.graduationYear,
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          ),
          ...[
            if (profile.biography case final bio?)
              Padding(
                padding: _horPadding,
                child: TitledItem(
                  title: 'Biography',
                  child: Text(
                    bio,
                    style: AppTextStyles.body,
                  ),
                ),
              ),
            if (profile.location case final location?)
              Padding(
                padding: _horPadding,
                child: TitledItem(
                  title: 'Location',
                  child: Text(
                    location,
                    style: AppTextStyles.body,
                  ),
                ),
              ),
          ].expand((e) => [const SizedBox(height: 16), e]),
          const SizedBox(height: RootPage.navigationBarHeight + 16),
        ],
      );
}
