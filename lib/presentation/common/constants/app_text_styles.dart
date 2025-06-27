import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static const _default = TextStyle(
    color: AppColors.darkGray,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.01,
  );
  static final body = _default;
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
    height: 0.95,
  );
  static final largeTitle = _default.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 34,
    height: 0.9,
    letterSpacing: -0.02,
  );
  // static final h2 = _default.copyWith(
  //   fontSize: 48,
  //   fontWeight: FontWeight.w600,
  //   height: 1.3,
  // );
  // static final h3 = _default.copyWith(
  //   fontSize: 36,
  //   fontWeight: FontWeight.w600,
  //   height: 1.3,
  // );
  // static final h4 = _default.copyWith(
  //   fontSize: 24,
  //   fontWeight: FontWeight.w600,
  //   height: 1.3,
  // );
  // static final h6 = _default.copyWith(
  //   fontSize: 14,
  //   fontWeight: FontWeight.w600,
  //   height: 1.3,
  // );

  // static final smallBody = _default.copyWith(
  //   fontSize: 12,
  //   height: 1.3,
  // );
  // static final buttonText = _default.copyWith(
  //   fontWeight: FontWeight.w600,
  //   color: Colors.white,
  // );
}
