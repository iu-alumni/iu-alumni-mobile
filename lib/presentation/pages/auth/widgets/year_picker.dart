import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/app_button.dart';

class GraduationYearPicker extends StatelessWidget {
  const GraduationYearPicker({super.key});

  static const _firstYear = 2015;

  static Future<int?> show(BuildContext context) async => showDialog<int>(
        context: context,
        builder: (_) => const GraduationYearPicker(),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Material(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    DateTime.now().year - _firstYear,
                    (d) {
                      final year = _firstYear + d;
                      return AppButton(
                        onTap: () => context.maybePop(year),
                        buttonStyle: AppButtonStyle.text,
                        child: Text(
                          '$year',
                          style: AppTextStyles.actionSB,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
