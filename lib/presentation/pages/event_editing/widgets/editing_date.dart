import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:intl/intl.dart';

import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/titled_item.dart';

class EditingDate extends StatefulWidget {
  const EditingDate({super.key});

  @override
  State<EditingDate> createState() => _EditingDateState();
}

class _EditingDateState extends State<EditingDate> {
  late final _formatter = DateFormat('dd/MM/yyyy');

  void _selectDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (newDate != null && context.mounted) {
      context
          .read<OneEventCubit>()
          .modify((e) => e.copyWith(occurringAt: newDate));
    }
  }

  @override
  Widget build(BuildContext context) => TitledItem(
        icon: Icons.watch_later_outlined,
        name: 'When',
        child: Material(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            child: InkWell(
              onTap: () => _selectDate(context),
              child: BlocBuilder<OneEventCubit, OneEventState>(
                builder: (context, event) => Text(
                  event
                      .map((e) => _formatter.format(e.occurringAt))
                      .match(() => '', identity),
                  style: AppTextStyles.body,
                ),
              ),
            ),
          ),
        ),
      );
}
