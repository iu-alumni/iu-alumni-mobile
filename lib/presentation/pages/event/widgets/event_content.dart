import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:intl/intl.dart';

import '../../../../application/models/cost.dart';
import '../../../../application/models/event.dart';
import '../../../../util/currency_formatter.dart';
import '../../../../util/num_formatter.dart';
import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/event_cover.dart';
import '../../../common/widgets/titled_item.dart';
import '../../../router/app_router.gr.dart';

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
        const SizedBox(height: 40),
        ...[
          if (desc != null && desc.isNotEmpty)
            _Item(
              icon: Icons.description_outlined,
              name: 'Description',
              content: widget.event.description ?? '',
            ),
          if (location != null && location.isNotEmpty)
            _Item(
              icon: Icons.location_pin,
              name: 'Location',
              content: location,
            ),
          _Item(
            icon: Icons.attach_money_outlined,
            name: 'Cost',
            content: _costToStr(widget.event.cost),
          ),
          _Item(
            icon: Icons.watch_later_outlined,
            name: 'When',
            content: _formatter.format(widget.event.occurringAt),
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
    await context.pushRoute(
      EventEditingRoute(
        eventId: Option.of(event.eventId),
      ),
    );
    if (!context.mounted) {
      return;
    }
    context.read<OneEventCubit>().loadEvent(event.eventId);
  }

  @override
  Widget build(BuildContext context) => EventCover(
        imageBytes: event.coverBytes,
        title: event.title,
        location: event.location,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppButton(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Edit',
                style: AppTextStyles.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () => _edit(context),
          ),
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({required this.name, required this.content, required this.icon});

  final String name;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) => TitledItem(
        title: name,
        icon: icon,
        child: Text(
          content,
          style: AppTextStyles.body,
          textAlign: TextAlign.start,
        ),
      );
}
