import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../application/repositories/reporter/reporter.dart';
import '../../blocs/events_list/events_list_cubit.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_loader.dart';
import '../../common/widgets/app_scaffold.dart';
import '../../router/app_router.gr.dart';
import 'widgets/events_list.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  @override
  void initState() {
    context.read<EventsListCubit>().loadEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        title: 'Events',
        leadingButton: null,
        actions: [
          AppButton(
            is48Height: true,
            child: Text(
              'Create',
              style: AppTextStyles.actionSB.copyWith(color: Colors.white),
            ),
            onTap: () {
              context
                  .read<Reporter>()
                  .reportCreateEventTap(AppLocation.eventsTab);
              context.pushRoute(EventEditingRoute(eventId: const None()));
            },
          ),
        ],
        body: AppChildBody(
          padding: EdgeInsets.zero,
          child: BlocBuilder<EventsListCubit, EventsListState>(
            builder: (context, eventsState) => switch (eventsState) {
              EventsListData d when d.data.isEmpty => Center(
                  child: Text('No events', style: AppTextStyles.caption),
                ),
              EventsListData d => EventsList(events: d.data),
              EventsListError e => Center(
                  child: Text(e.error, style: AppTextStyles.caption),
                ),
              _ => const Center(child: AppLoader(inCard: true)),
            },
          ),
        ),
      );
}
