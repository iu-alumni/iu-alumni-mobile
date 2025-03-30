import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/titled_item.dart';

class EditingLocation extends StatelessWidget {
  const EditingLocation({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OneEventCubit, OneEventState>(builder: (context, event) {
        final hasLocation =
            !event.map((e) => e.onlineEvent).match(() => true, identity);
        return AnimatedSize(
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 300),
          child: hasLocation
              ? TitledItem(
                  icon: Icons.location_pin,
                  name: 'Location',
                  // TODO
                  child: Text(
                    'Location Picker (TODO)',
                    style: AppTextStyles.body,
                  ),
                )
              : const SizedBox(),
        );
      });
}
