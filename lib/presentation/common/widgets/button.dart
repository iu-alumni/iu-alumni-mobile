import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.child, required this.onTap});

  final Widget child;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      );
}
