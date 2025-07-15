import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../application/models/event.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/widgets/event_card.dart';
import '../../root/root_page.dart';

class EventsList extends StatefulWidget {
  const EventsList({required this.events, required this.refresh, super.key});

  final Iterable<EventModel> events;
  final Future<void> Function()? refresh;

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  late final _refreshController = RefreshController();

  static const _innoColors = [
    AppColors.gray90,
    Color(0xffc4f3ba),
    Color(0xffFAD4B3),
    Color(0xffADDEFF),
  ];

  Color _colorFor(int index) => _innoColors[index % _innoColors.length];

  Future<void> _onRefresh() async {
    await widget.refresh?.call();
    _refreshController.refreshCompleted();
  }

  late final _child = MasonryGridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 16,
    ).copyWith(bottom: RootPage.navigationBarHeight + 16),
    itemCount: widget.events.length,
    itemBuilder: (context, i) =>
        EventCard(color: _colorFor(i), event: widget.events.elementAt(i)),
  );

  @override
  Widget build(BuildContext context) => widget.refresh != null
      ? SmartRefresher(
          physics: const BouncingScrollPhysics(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          header: const ClassicHeader(),
          child: _child,
        )
      : _child;
}
