import 'package:flutter/material.dart';

import '../constants/app_text_styles.dart';

class TitledItem extends StatelessWidget {
  const TitledItem({
    required this.title,
    required this.child,
    // this.icon,
    this.titlePadding = EdgeInsets.zero,
    super.key,
  });

  final String title;
  // final IconData? icon;
  final Widget child;
  final EdgeInsets titlePadding;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: titlePadding,
            child: Row(
              children: [
                // if (icon case final i?) ...[
                //   Icon(
                //     i,
                //     color: AppColors.blueGray,
                //   ),
                //   const SizedBox(width: 4),
                // ],
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.subtitle,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
