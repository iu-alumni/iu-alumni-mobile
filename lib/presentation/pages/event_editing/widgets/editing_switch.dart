import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../blocs/models/one_event_state.dart';
import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/widgets/app_switch.dart';
import '../../../common/widgets/titled_item.dart';

class EditingSwitch extends StatelessWidget {
  const EditingSwitch({super.key});

  @override
  Widget build(BuildContext context) => TitledItem(
        // icon: Icons.video_call,
        title: 'Online event',
        child: Align(
          alignment: Alignment.topLeft,
          child: BlocBuilder<OneEventCubit, OneEventState>(
            builder: (context, eventState) => AppSwitch(
              value: eventState.event
                  .map((e) => e.onlineEvent)
                  .match(() => false, identity),
              onTap: (_) => context
                  .read<OneEventCubit>()
                  .modify((e) => e.copyWith(onlineEvent: !e.onlineEvent)),
            ),
          ),
        ),
      );
}
