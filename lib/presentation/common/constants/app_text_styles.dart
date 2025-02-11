import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static const _default = TextStyle(
    color: AppColors.darkGray,
    // fontFamily:  set this up later
    fontSize: 18,
  );
  static final h3 = _default.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 1.34,
  );
  static final buttonText = _default.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
