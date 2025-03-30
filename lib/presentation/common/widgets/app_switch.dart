import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({required this.value, required this.onTap, super.key});

  final bool value;
  final void Function(bool) onTap;

  @override
  Widget build(BuildContext context) => Switch(
        inactiveThumbColor: AppColors.blueGray,
        inactiveTrackColor: AppColors.lightGray,
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.lightGray
              : AppColors.blueGray,
        ),
        activeColor: Colors.white,
        activeTrackColor: AppColors.blueGray,
        value: value,
        onChanged: onTap,
      );
}
