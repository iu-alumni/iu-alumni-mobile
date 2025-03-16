import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class TitledItem extends StatelessWidget {
  const TitledItem({
    required this.name,
    required this.icon,
    required this.child,
    super.key,
  });

  final String name;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.blueGray,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  name,
                  style: AppTextStyles.h4.copyWith(color: AppColors.blueGray),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
