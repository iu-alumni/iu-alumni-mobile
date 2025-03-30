import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

enum AppButtonStyle { primary, secondary, text }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.child,
    required this.onTap,
    this.borderRadius,
    this.buttonStyle = AppButtonStyle.primary,
    super.key,
  });

  final Widget child;
  final void Function() onTap;
  final BorderRadiusGeometry? borderRadius;
  final AppButtonStyle buttonStyle;

  Color get _buttonColor => switch (buttonStyle) {
        AppButtonStyle.primary => AppColors.primary,
        AppButtonStyle.secondary => AppColors.darkGray,
        AppButtonStyle.text => Colors.transparent,
      };

  @override
  Widget build(BuildContext context) => Material(
        color: _buttonColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      );
}
