import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../application/models/cost.dart';
import '../../../../application/models/event.dart';
import '../../../../util/currency_presenter.dart';
import '../../../../util/numbers_presenter.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/button.dart';

class EventViewingContent extends StatefulWidget {
  const EventViewingContent({required this.event, super.key});

  final EventModel event;

  @override
  State<EventViewingContent> createState() => _EventViewingContentState();
}

class _EventViewingContentState extends State<EventViewingContent> {
  late final _formatter = DateFormat('dd/MM/YYYY');

  String _costToStr(CostModel cost) =>
      '${cost.number.humanReadable} ${cost.currency.present}';

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _Cover(event: widget.event),
          const SizedBox(height: 40),
          ...[
            _Item(
              icon: Icons.description_outlined,
              name: 'Description',
              content: widget.event.description,
            ),
            _Item(
              icon: Icons.location_pin,
              name: 'Location',
              content: widget.event.location,
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

class _Cover extends StatelessWidget {
  const _Cover({required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    final horPadding = const EdgeInsets.symmetric(horizontal: 24);
    final secondaryWhite = Colors.white.withValues(alpha: 0.5);
    return Stack(
      children: [
        // TODO cover image
        const Positioned.fill(child: ColoredBox(color: Colors.black38)),
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black12.withAlpha(0), Colors.white],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: 24,
              ),
            ],
          ),
        ),
        SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: horPadding,
                child: Text(
                  event.title,
                  style: AppTextStyles.h2.copyWith(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: horPadding,
                child: Row(
                  children: [
                    Icon(Icons.location_pin, color: secondaryWhite),
                    const SizedBox(width: 8),
                    Text(
                      event.location,
                      style: AppTextStyles.h4.copyWith(color: secondaryWhite),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 140),
              Padding(
                padding: horPadding,
                child: Button(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Count me in!',
                      style: AppTextStyles.buttonText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.name, required this.content, required this.icon});

  final String name;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.blueGray,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  name,
                  style: AppTextStyles.h4.copyWith(color: AppColors.blueGray),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: AppTextStyles.body,
            textAlign: TextAlign.start,
          ),
        ],
      );
}
