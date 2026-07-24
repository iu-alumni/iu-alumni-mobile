import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../application/repositories/reporter/reporter.dart';
import '../../blocs/events_list/events_list_cubit.dart';
import '../../blocs/notifications/notifications_cubit.dart';
import '../../blocs/notifications/notifications_state.dart';
import '../../common/constants/app_colors.dart';
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
    context.read<NotificationsCubit>().loadUnreadCount();
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
          context.read<Reporter>().reportCreateEventTap(AppLocation.eventsTab);
          context.pushRoute(EventEditingRoute(eventId: const None()));
        },
      ),
      AppButton(
        is48Height: true,
        buttonStyle: AppButtonStyle.gray,
        onTap: () => context.pushRoute(const NotificationsRoute()),
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          buildWhen: (p, c) => p.unreadCount != c.unreadCount,
          builder: (context, state) => Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_outlined, color: AppColors.darkGray),
              if (state.unreadCount > 0)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
    body: AppChildBody(
      padding: EdgeInsets.zero,
      child: BlocBuilder<EventsListCubit, EventsListState>(
        builder: (context, eventsState) => switch (eventsState) {
          final EventsListData d when d.data.isEmpty => Center(
            child: Text('No events', style: AppTextStyles.caption),
          ),
          final EventsListData d => EventsList(
            events: d.data,
            refresh: context.read<EventsListCubit>().refreshEvents,
          ),
          final EventsListError e => Center(
            child: Text(e.error, style: AppTextStyles.caption),
          ),
          _ => const Center(child: AppLoader(inCard: true)),
        },
      ),
    ),
  );
}
