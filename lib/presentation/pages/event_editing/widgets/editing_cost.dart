import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../application/models/cost.dart';
import '../../../../util/currency_formatter.dart';
import '../../../../util/num_formatter.dart';
import '../../../blocs/models/one_event_state.dart';
import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/titled_item.dart';
import 'currency_dialog.dart';

class EditingCost extends StatelessWidget {
  const EditingCost({super.key});

  void _selectCurrency(BuildContext context) async {
    final newCurrency = await showDialog<Currency>(
      context: context,
      builder: (context) => const CurrencyDialog(),
    );
    if (newCurrency != null && context.mounted) {
      context.read<OneEventCubit>().modify(
            (e) => e.copyWith(
              cost: e.cost.copyWith(currency: newCurrency),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialCost = context
        .read<OneEventCubit>()
        .state
        .event
        .map((e) => e.cost.number.format)
        .match(() => '', identity);
    return TitledItem(
      icon: Icons.attach_money_outlined,
      title: 'Cost',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AppTextField(
              initialText: initialCost,
              hintText: 'Free',
              inputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChange: (text) => context.read<OneEventCubit>().modify(
                    (e) => e.copyWith(
                      cost: e.cost.copyWith(
                        number: double.tryParse(text) ?? 0,
                      ),
                    ),
                  ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              onTap: () => _selectCurrency(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: BlocBuilder<OneEventCubit, OneEventState>(
                  builder: (context, state) {
                    final curr = state.event
                        .map((e) => e.cost.currency.format)
                        .match(() => '', identity);
                    return Text(curr);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
