import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../application/models/cost.dart';
import '../../../../util/currency_formatter.dart';
import '../../../common/constants/app_text_styles.dart';

class CurrencyDialog extends StatelessWidget {
  const CurrencyDialog({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                ...Currency.values.map(_Currency.new),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
}

class _Currency extends StatelessWidget {
  const _Currency(this.currency);

  final Currency currency;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => context.maybePop(currency),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            currency.format,
            style: AppTextStyles.actionM,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
