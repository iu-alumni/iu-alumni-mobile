import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/titled_item.dart';

class EditingTitle extends StatelessWidget {
  const EditingTitle({super.key});

  @override
  Widget build(BuildContext context) => TitledItem(
        // icon: Icons.title,
        title: 'Title',
        child: AppTextField(
          initialText: context
              .read<OneEventCubit>()
              .state
              .event
              .map((s) => s.title)
              .match(() => '', identity),
          onChange: (text) => context
              .read<OneEventCubit>()
              .modify((e) => e.copyWith(title: text)),
          hintText: 'How is the event called?',
        ),
      );
}
