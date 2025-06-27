import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

enum NavButtonStyle { semitransparent, solid }

enum NavButtonContent { back, close }

class NavButton extends StatelessWidget {
  const NavButton({
    super.key,
    this.style = NavButtonStyle.solid,
    this.content = NavButtonContent.back,
    this.onTap,
  });

  final NavButtonStyle style;
  final NavButtonContent content;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48, maxHeight: 48),
        child: Material(
          color: AppColors.gray90.withValues(
            alpha: style == NavButtonStyle.semitransparent ? 0.7 : 1,
          ),
          borderRadius: BorderRadius.circular(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter.grouped(
              enabled: style == NavButtonStyle.semitransparent,
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: onTap ?? context.maybePop,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (content == NavButtonContent.back) ...[
                      const SizedBox(width: 12),
                      const Icon(Icons.arrow_back, color: AppColors.darkGray),
                      const SizedBox(width: 2),
                    ] else
                      const SizedBox(width: 16),
                    Text(
                      switch (content) {
                        NavButtonContent.back => 'Back',
                        NavButtonContent.close => 'Close',
                      },
                      style: AppTextStyles.actionSB,
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
