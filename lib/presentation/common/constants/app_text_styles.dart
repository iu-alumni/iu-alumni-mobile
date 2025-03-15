import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static const _default = TextStyle(
    color: AppColors.darkGray,
    // fontFamily:  set this up later
    fontSize: 18,
  );
  static final h2 = _default.copyWith(
    fontSize: 48,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  static final h3 = _default.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  static final h4 = _default.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  static final h6 = _default.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  static final caption = _default.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
  static final smallBody = _default.copyWith(
    fontSize: 12,
    height: 1.3,
  );
  static final buttonText = _default.copyWith(
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static final body = _default;
}
