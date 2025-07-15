import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ui_alumni_mobile/application/models/profile.dart';
import 'package:ui_alumni_mobile/application/repositories/map/map_repository.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_colors.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_text_styles.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_button.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_scaffold.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/nav_button.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/profile_pic.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/stacked_row.dart';
import 'package:ui_alumni_mobile/presentation/pages/events_list/widgets/events_list.dart';
import 'package:ui_alumni_mobile/presentation/router/app_router.gr.dart';

@RoutePage()
class CityDataPage extends StatelessWidget {
  const CityDataPage({required this.cityData, required this.coords, super.key});

  final CityData cityData;
  final NamedCoordinates coords;

  @override
  Widget build(BuildContext context) => AppScaffold(
    title: coords.city,
    actions: [
      AppButton(
        child: Text(
          'Create an event',
          style: AppTextStyles.actionSB.copyWith(color: Colors.white),
        ),
        onTap: () => context.replaceRoute(
          EventEditingRoute(
            eventId: const None(),
            location: Option.of(coords.fullLocation),
          ),
        ),
      ),
    ],
    body: AppChildBody(
      padding: EdgeInsets.zero,
      child: Column(
        spacing: 8,
        children: [
          if (cityData.profiles.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _InCity(profiles: cityData.profiles),
            ),
          Expanded(child: EventsList(events: cityData.events, refresh: null)),
        ],
      ),
    ),
  );
}

class _InCity extends StatelessWidget {
  const _InCity({required this.profiles});

  final Iterable<Profile> profiles;

  @override
  Widget build(BuildContext context) => AppButton(
    buttonStyle: AppButtonStyle.gray,
    onTap: () => showCupertinoSheet(
      context: context,
      pageBuilder: (context) => AppScaffold(
        title: 'In city',
        leadingButton: const NavButton(content: NavButtonContent.close),
        body: AppListBody(
          children: profiles
              .map(
                (p) => AppButton(
                  buttonStyle: AppButtonStyle.text,
                  child: Row(
                    spacing: 8,
                    children: [
                      ProfilePic(profile: p, size: 48),
                      Expanded(
                        child: Text(p.fullName, style: AppTextStyles.body),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.gray50,
                      ),
                    ],
                  ),
                  onTap: () =>
                      context.pushRoute(ProfileRoute(profile: Option.of(p))),
                ),
              )
              .toList(),
        ),
      ),
    ),
    child: Row(
      spacing: 8,
      children: [
        Expanded(
          child: Text(
            'In city',
            style: AppTextStyles.subtitle,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        StackedRow(profiles: profiles),
        const Icon(Icons.arrow_forward_ios, color: AppColors.gray50),
      ],
    ),
  );
}
