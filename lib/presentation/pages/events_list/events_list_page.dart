import 'package:flutter/material.dart';

import '../../../util/gap.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/widgets/alumni_logo.dart';
import '../../common/widgets/button.dart';
import '../root/root_page.dart';

class EventsListPage extends StatelessWidget {
  const EventsListPage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Header(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                    bottom: RootPage.navigationBarHeight + 16, top: 16),
                child: Column(
                  children: <Widget>[
                    const _Section(heading: 'Soon'),
                    const _Section(heading: 'Close to you'),
                    const _Section(heading: 'Others'),
                  ].gap((_) => const SizedBox(height: 80)),
                ),
              ),
            ),
          ],
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24)
            .copyWith(top: 16, bottom: 8),
        child: Row(
          children: [
            AlumniLogo(),
            Spacer(),
            Button(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      'Create event',
                      style: AppTextStyles.buttonText,
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}

class _Section extends StatelessWidget {
  const _Section({required this.heading});

  final String heading;
  // final List content;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(heading, style: AppTextStyles.h3),
          ),
          const SizedBox(height: 2),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                10,
                (_) => SizedBox(
                  width: 250,
                  height: 150,
                  child: ColoredBox(color: Colors.amber),
                ),
              ).gap((_) => const SizedBox(width: 16)),
            ),
          ),
        ],
      );
}
