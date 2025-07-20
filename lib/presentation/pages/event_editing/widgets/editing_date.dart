import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:intl/intl.dart';

import '../../../blocs/models/one_event_state.dart';
import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/titled_item.dart';

class EditingDate extends StatefulWidget {
  const EditingDate({super.key});

  @override
  State<EditingDate> createState() => _EditingDateState();
}

class _EditingDateState extends State<EditingDate> {
  late final _dateFormatter = DateFormat('dd.MM.yyyy');
  late final _timeFormatter = DateFormat('HH:mm');

  Future<void> _selectDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (newDate != null && context.mounted) {
      context.read<OneEventCubit>().modify(
        (e) => e.copyWith(
          occurringAt: newDate.copyWith(
            hour: e.occurringAt.hour,
            minute: e.occurringAt.minute,
          ),
        ),
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 0),
    );
    if (newTime != null && context.mounted) {
      context.read<OneEventCubit>().modify(
        (e) => e.copyWith(
          occurringAt: e.occurringAt.copyWith(
            hour: newTime.hour,
            minute: newTime.minute,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => TitledItem(
    title: 'When',
    child: BlocBuilder<OneEventCubit, OneEventState>(
      buildWhen: (p, c) =>
          p.event.map((e) => e.occurringAt) !=
          c.event.map((e) => e.occurringAt),
      builder: (context, state) => Row(
        spacing: 8,
        children: [
          Expanded(
            child: AppButton(
              buttonStyle: AppButtonStyle.gray,
              child: Text(
                state.event
                    .map((e) => _dateFormatter.format(e.occurringAt))
                    .match(() => '', identity),
                style: AppTextStyles.body,
              ),
              onTap: () => _selectDate(context),
            ),
          ),
          Expanded(
            child: AppButton(
              buttonStyle: AppButtonStyle.gray,
              child: Text(
                state.event
                    .map((e) => _timeFormatter.format(e.occurringAt))
                    .match(() => '', identity),
                style: AppTextStyles.body,
              ),
              onTap: () => _selectTime(context),
            ),
          ),
        ],
      ),
    ),
  );
}
