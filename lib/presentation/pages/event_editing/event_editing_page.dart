import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../application/repositories/events/events_repository.dart';
import '../../blocs/events_list/events_list_cubit.dart';
import '../../blocs/one_event/one_event_cubit.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/widgets/button.dart';
import 'widgets/event_editing_content.dart';

@RoutePage()
class EventEditingPage extends StatefulWidget implements AutoRouteWrapper {
  const EventEditingPage({required this.eventId, super.key});

  final Option<String> eventId;

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
  late final OneEventCubit _oneEventCubit;

  @override
  void initState() {
    _oneEventCubit = context.read<OneEventCubit>();
    widget.eventId.match(_oneEventCubit.createEvent, _oneEventCubit.loadEvent);
    super.initState();
  }

  void _save() async {
    await _oneEventCubit.commit();
    if (!context.mounted) {
      return;
    }
    final eventsListCubit = context.read<EventsListCubit>();
    widget.eventId.match(
      // If the ID was unknown originally, the event is newly created and exists
      // only in the OneEventCubit. This ID should be utilized to add it from
      // the repository after committing
      () => _oneEventCubit.state.map(
        (thisEvent) => eventsListCubit.add(thisEvent.eventId),
      ),
      // If the ID is known, it is an existing event, so update it
      eventsListCubit.update,
    );
    context.maybePop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Button(
            onTap: _save,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Post event',
                style: AppTextStyles.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        body: BlocBuilder<OneEventCubit, OneEventState>(
          buildWhen: (p, c) => p.isNone() != c.isNone(),
          builder: (context, eventState) => eventState.match(
            () => const Center(child: CircularProgressIndicator()),
            (event) => const SafeArea(
              top: false,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    // Button height + padding
                    padding: EdgeInsets.only(bottom: 107),
                    physics: BouncingScrollPhysics(),
                    child: EventEditingContent(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
