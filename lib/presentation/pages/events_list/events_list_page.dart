import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../blocs/events_list/events_list_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/widgets/button.dart';
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
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Header(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text('Soon', style: AppTextStyles.h3),
            ),
            Expanded(
              child: BlocBuilder<EventsListCubit, EventsListState>(
                builder: (context, eventsState) => switch (eventsState) {
                  EventsListData d when d.data.isEmpty => const _CenterText(
                      text: 'No Events',
                    ),
                  EventsListData d => EventsList(events: d.data),
                  EventsListError e => _CenterText(text: e.error),
                  _ => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                },
              ),
            ),
          ],
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24)
            .copyWith(top: 16, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Events', style: AppTextStyles.h2),
            AppButton(
              onTap: () => context.pushRoute(
                EventEditingRoute(eventId: const None()),
              ),
              borderRadius: BorderRadius.circular(24),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
}

class _CenterText extends StatelessWidget {
  const _CenterText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          text,
          style: AppTextStyles.h3,
        ),
      );
}
