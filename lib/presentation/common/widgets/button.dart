import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class Button extends StatelessWidget {
  const Button({
    required this.child,
    required this.onTap,
    this.borderRadius,
    super.key,
  });

  final Widget child;
  final void Function() onTap;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) => Material(
        color: AppColors.primary,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      );
}
