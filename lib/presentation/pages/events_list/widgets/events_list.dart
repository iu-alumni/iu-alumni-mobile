import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../application/models/event.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/widgets/event_card.dart';
import '../../root/root_page.dart';

class EventsList extends StatefulWidget {
  const EventsList({required this.events, super.key});

  final IList<EventModel> events;

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  static const _innoColors = [
    AppColors.gray90,
    Color(0xffc4f3ba),
    Color(0xffFAD4B3),
    Color(0xffADDEFF),
  ];

  Color _colorFor(int index) => _innoColors[index % _innoColors.length];

  @override
  Widget build(BuildContext context) => MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ).copyWith(
          bottom: RootPage.navigationBarHeight + 16,
        ),
        itemCount: widget.events.length,
        itemBuilder: (context, i) => EventCard(
          color: _colorFor(i),
          event: widget.events.get(i),
        ),
      );
}
