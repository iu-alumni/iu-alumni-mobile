import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

enum AppButtonStyle { primary, secondary, text, gray }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.child,
    required this.onTap,
    this.buttonStyle = AppButtonStyle.primary,
    this.is48Height = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    super.key,
  });

  final Widget child;
  final void Function() onTap;
  final AppButtonStyle buttonStyle;
  final bool is48Height;
  final EdgeInsets padding;

  Color get _buttonColor => switch (buttonStyle) {
        AppButtonStyle.primary => AppColors.primary,
        AppButtonStyle.secondary => AppColors.darkGray,
        AppButtonStyle.text => Colors.transparent,
        AppButtonStyle.gray => AppColors.gray90,
      };

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: is48Height
            ? const BoxConstraints(maxHeight: 48, minHeight: 48)
            : const BoxConstraints(),
        child: Material(
          color: _buttonColor,
          borderRadius: BorderRadius.circular(100),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: is48Height ? padding : const EdgeInsets.all(16),
              child: Center(child: child),
            ),
          ),
        ),
      );
}
