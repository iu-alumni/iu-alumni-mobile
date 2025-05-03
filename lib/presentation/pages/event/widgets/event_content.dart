import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:intl/intl.dart';

import '../../../../application/models/cost.dart';
import '../../../../application/models/event.dart';
import '../../../../application/models/user_status.dart';
import '../../../../application/repositories/reporter/reporter.dart';
import '../../../../util/currency_formatter.dart';
import '../../../../util/num_formatter.dart';
import '../../../blocs/models/one_event_state.dart';
import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/event_cover.dart';
import '../../../common/widgets/titled_item.dart';
import '../../../router/app_router.gr.dart';
import 'participants_card.dart';

class EventViewingContent extends StatefulWidget {
  const EventViewingContent({required this.event, super.key});

  final EventModel event;

  @override
  State<EventViewingContent> createState() => _EventViewingContentState();
}

class _EventViewingContentState extends State<EventViewingContent> {
  late final _formatter = DateFormat('dd/MM/yyyy');

  String _costToStr(CostModel cost) =>
      '${cost.number.format} ${cost.currency.format}';

  @override
  Widget build(BuildContext context) {
    final location = widget.event.location;
    final desc = widget.event.description;
    return Column(
      children: [
        _Cover(event: widget.event),
        const SizedBox(height: 16),
        ...[
          const ParticipantsCard(),
          if (desc != null && desc.isNotEmpty)
            _Item(
              icon: Icons.description_outlined,
              name: 'Description',
              content: Left(widget.event.description ?? ''),
            ),
          if (location != null && location.isNotEmpty)
            _Item(
              icon: Icons.location_pin,
              name: 'Location',
              content: Left(location),
            ),
          _Item(
            icon: Icons.attach_money_outlined,
            name: 'Cost',
            content: Left(_costToStr(widget.event.cost)),
          ),
          _Item(
            icon: Icons.watch_later_outlined,
            name: 'When',
            content: Left(_formatter.format(widget.event.occurringAt)),
          ),
        ].map(
          (w) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: w,
          ),
        ),
      ],
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.event});

  final EventModel event;

  void _edit(BuildContext context) async {
    context.read<Reporter>().reportEditEventTap(event, AppLocation.eventScreen);
    await context.pushRoute(
      EventEditingRoute(eventId: Option.of(event.eventId)),
    );
    if (!context.mounted) {
      return;
    }
    context.read<OneEventCubit>().loadEvent(event.eventId);
  }

  void _participate(BuildContext context) =>
      context.read<OneEventCubit>().participate();

  void _leave(BuildContext context) => context.read<OneEventCubit>().leave();

  @override
  Widget build(BuildContext context) => EventCover(
        imageBytes: event.coverBytes,
        title: event.title,
        location: event.location,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppButton(
            buttonStyle: switch (event.userStatus) {
              UserNotAuthor(:final participant) when participant =>
                AppButtonStyle.destructive,
              _ => AppButtonStyle.primary,
            },
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: BlocBuilder<OneEventCubit, OneEventState>(
                buildWhen: (p, c) => p.userStatusLoading != c.userStatusLoading,
                builder: (context, state) => state.userStatusLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        switch (event.userStatus) {
                          UserAuthor() => 'Edit',
                          UserNotAuthor(:final participant) when participant =>
                            'I won\'t come',
                          UserNotAuthor() => 'Participate',
                        },
                        style: AppTextStyles.buttonText,
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
            onTap: () => switch (event.userStatus) {
              UserAuthor() => _edit(context),
              UserNotAuthor(:final participant) when participant =>
                _leave(context),
              UserNotAuthor() => _participate(context),
            },
          ),
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({required this.name, required this.content, required this.icon});

  final String name;
  final Either<String, Widget> content;
  final IconData icon;

  @override
  Widget build(BuildContext context) => TitledItem(
        title: name,
        icon: icon,
        child: content.match(
          (text) => Text(
            text,
            style: AppTextStyles.body,
            textAlign: TextAlign.start,
          ),
          identity,
        ),
      );
}
