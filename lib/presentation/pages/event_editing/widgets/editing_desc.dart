import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/titled_item.dart';

class EditingDesc extends StatelessWidget {
  const EditingDesc({super.key});

  @override
  Widget build(BuildContext context) => TitledItem(
        icon: Icons.description_outlined,
        title: 'Description',
        child: AppTextField(
          initialText: context
              .read<OneEventCubit>()
              .state
              .map((s) => s.description)
              .match(() => '', identity),
          onChange: (text) => context
              .read<OneEventCubit>()
              .modify((e) => e.copyWith(description: text)),
          hintText:
              'Briefly, describe what the event is about, what you are planning to do, etc.',
        ),
      );
}
