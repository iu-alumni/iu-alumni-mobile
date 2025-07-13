import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static const _default = TextStyle(
    color: AppColors.darkGray,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.01,
  );
  static const body = _default;
  static final caption = _default.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  static final actionM = _default.copyWith(fontSize: 17);
  static final actionSB = actionM.copyWith(fontWeight: FontWeight.w600);
  static final subtitle = _default.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static final largeTitle = _default.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 34,
    letterSpacing: -0.02,
  );
}
