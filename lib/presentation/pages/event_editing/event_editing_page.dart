import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/events/events_repository.dart';
import '../../blocs/events_list/events_list_cubit.dart';
import '../../blocs/one_event/one_event_cubit.dart';
import 'widgets/event_editing_content.dart';

@RoutePage()
class EventEditingPage extends StatefulWidget implements AutoRouteWrapper {
  const EventEditingPage({required this.eventId, super.key});

  final String eventId;

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => OneEventCubit(
          context.read<EventsRepository>(),
        ),
        child: this,
      );
}

class _EventEditingPageState extends State<EventEditingPage> {
  late final EventsListCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<EventsListCubit>();
    context.read<OneEventCubit>().loadEvent(widget.eventId);
    super.initState();
  }

  @override
  void dispose() {
    _cubit.update(widget.eventId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<OneEventCubit, OneEventState>(
          buildWhen: (p, c) => p.isNone() != c.isNone(),
          builder: (context, eventState) => eventState.match(
            () => const Center(child: CircularProgressIndicator()),
            (event) => const SafeArea(
              top: false,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: EventEditingContent(),
              ),
            ),
          ),
        ),
      );
}
