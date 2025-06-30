import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../blocs/events_list/events_list_cubit.dart';
import '../../blocs/models/one_event_state.dart';
import '../../blocs/one_event/one_event_cubit.dart';
import '../../blocs/profile/profile_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_loader.dart';
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
          context.read<UsersRepository>(),
          context.read<Reporter>(),
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

  void _delete() {
    _oneEventCubit.delete();
    widget.eventId.map(context.read<EventsListCubit>().remove);
    // Mark this one is updated
    context.read<ProfileCubit>().updateOwnedEvents();
    context.router.popUntilRoot();
  }

  void _updateAndLeave() {
    final eventsListCubit = context.read<EventsListCubit>();
    final profileCubit = context.read<ProfileCubit>();
    widget.eventId.match(
      // If the ID was unknown originally, the event is newly created and exists
      // only in the OneEventCubit. Update the events list from the repository
      () async {
        await eventsListCubit.loadEvents();
        // Mark this one is updated
        profileCubit.updateOwnedEvents();
      },
      // If the ID is known, it is an existing event, so update it
      (eid) async {
        await eventsListCubit.update(eid);
        // Mark this one is updated
        profileCubit.updateOwnedEvents();
      },
    );
    context.maybePop();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<OneEventCubit, OneEventState>(
        listenWhen: (p, c) => p.saveState != c.saveState,
        listener: (context, state) => switch (state.saveState) {
          LoadedStateData() => _updateAndLeave(),
          _ => null,
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _ErrorText(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppButton(
                          onTap: _oneEventCubit.save,
                          child: BlocBuilder<OneEventCubit, OneEventState>(
                            buildWhen: (p, c) => p.saveState != c.saveState,
                            builder: (context, state) =>
                                switch (state.saveState) {
                              LoadedStateLoading() => const AppLoader(
                                  color: Colors.white,
                                ),
                              _ => Text(
                                  widget.eventId.match(
                                    () => 'Post event',
                                    (_) => 'Done',
                                  ),
                                  style: AppTextStyles.actionSB.copyWith(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                            },
                          ),
                        ),
                      ),
                      ...widget.eventId.match(
                        () => [],
                        (_) => [
                          const SizedBox(width: 8),
                          AppButton(
                            onTap: _delete,
                            buttonStyle: AppButtonStyle.text,
                            child: const Icon(
                              Icons.delete,
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: BlocBuilder<OneEventCubit, OneEventState>(
            buildWhen: (p, c) => p.event.isNone() != c.event.isNone(),
            builder: (context, eventState) => eventState.event.match(
              () => const Center(child: CircularProgressIndicator()),
              (event) => const SafeArea(
                top: false,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 16),
                      child: EventEditingContent(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _ErrorText extends StatelessWidget {
  const _ErrorText();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OneEventCubit, OneEventState>(
        buildWhen: (p, c) => p.saveState != c.saveState,
        builder: (context, state) => AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: switch (state.saveState) {
            LoadedStateError(:final error) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  error,
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.start,
                ),
              ),
            _ => const SizedBox(),
          },
        ),
      );
}
