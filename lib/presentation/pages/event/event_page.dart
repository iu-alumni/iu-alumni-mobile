import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/events/events_repository.dart';
import '../../blocs/one_event/one_event_cubit.dart';
import 'widgets/event_content.dart';

@RoutePage()
class EventPage extends StatefulWidget implements AutoRouteWrapper {
  const EventPage({required this.eventId, super.key});

  final String eventId;

  @override
  State<EventPage> createState() => _EventPageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => OneEventCubit(
          context.read<EventsRepository>(),
        ),
        child: this,
      );
}

class _EventPageState extends State<EventPage> {
  @override
  void initState() {
    context.read<OneEventCubit>().loadEvent(widget.eventId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<OneEventCubit, OneEventState>(
          builder: (context, eventState) => eventState.match(
            () => const Center(child: CircularProgressIndicator()),
            (event) => SafeArea(
              top: false,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: EventViewingContent(event: event),
              ),
            ),
          ),
        ),
      );
}
