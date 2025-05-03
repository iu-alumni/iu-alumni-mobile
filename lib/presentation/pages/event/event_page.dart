import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../blocs/models/one_event_state.dart';
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
          context.read<UsersRepository>(),
          context.read<Reporter>(),
        ),
        child: this,
      );
}

class _EventPageState extends State<EventPage> {
  @override
  void initState() {
    _loadEventData();
    super.initState();
  }

  void _loadEventData() async {
    await context.read<OneEventCubit>().loadEvent(widget.eventId);
    // if (!context.mounted) {
    //   return;
    // }
    // context.read<OneEventCubit>().loadParticipants();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<OneEventCubit, OneEventState>(
        listenWhen: (p, c) =>
            p.event.map((e) => e.participantsIds) !=
            c.event.map((e) => e.participantsIds),
        listener: (context, _) =>
            context.read<OneEventCubit>().loadParticipants(),
        child: Scaffold(
          body: BlocBuilder<OneEventCubit, OneEventState>(
            buildWhen: (p, c) => p.event != c.event,
            builder: (context, eventState) => eventState.event.match(
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
        ),
      );
}
