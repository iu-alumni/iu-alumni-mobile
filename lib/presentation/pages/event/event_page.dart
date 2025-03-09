import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/one_event/one_event_cubit.dart';
import 'widgets/event_content.dart';

@RoutePage()
class EventPage extends StatefulWidget {
  const EventPage({required this.eventId, super.key});

  final String eventId;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  void initState() {
    context.read<OneEventCubit>().setEvent(widget.eventId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<OneEventCubit, OneEventState>(
          builder: (context, eventState) => eventState.match(
            () => const Center(child: CircularProgressIndicator()),
            (event) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: EventViewingContent(event: event),
            ),
          ),
        ),
      );
}
