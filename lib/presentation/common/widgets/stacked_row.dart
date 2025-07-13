import 'package:flutter/material.dart';
import 'package:ui_alumni_mobile/application/models/profile.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_colors.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_text_styles.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/profile_pic.dart';

class StackedRow extends StatelessWidget {
  const StackedRow({required this.profiles});

  final Iterable<Profile> profiles;

  Iterable<Widget> get _profileWidgets => profiles.map(
    (p) => DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: BoxBorder.all(color: AppColors.gray90, strokeAlign: 1),
      ),
      child: ProfilePic(profile: p, size: 48),
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (profiles.isEmpty) {
      return const SizedBox();
    }
    final widgets = profiles.length <= 6
        ? _profileWidgets
        : [
            ..._profileWidgets.take(5),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.darkGray,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                '+${profiles.length - 5}',
                style: AppTextStyles.caption.copyWith(color: Colors.white),
              ),
            ),
          ];
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 48,
        maxWidth: 32 + widgets.length * 16,
      ),
      child: Stack(
        children: [
          ...[
            for (final (i, w) in widgets.indexed)
              Positioned(left: i * 16, child: w),
          ],
        ],
      ),
    );
  }
}
