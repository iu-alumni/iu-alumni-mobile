import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({required this.value, required this.onTap, super.key});

  final bool value;
  final void Function(bool) onTap;

  @override
  Widget build(BuildContext context) => Switch(
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: AppColors.gray80,
        activeColor: Colors.white,
        activeTrackColor: AppColors.primary,
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primary
              : Colors.white,
        ),
        value: value,
        onChanged: onTap,
      );
}
