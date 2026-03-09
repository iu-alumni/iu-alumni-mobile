import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:ui_alumni_mobile/application/models/profile.dart';
import 'package:ui_alumni_mobile/application/repositories/map/map_repository.dart';
import 'package:ui_alumni_mobile/application/repositories/users/users_repository.dart';
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
class CityDataPage extends StatefulWidget {
  const CityDataPage({required this.cityData, required this.coords, super.key});

  final CityData cityData;
  final NamedCoordinates coords;

  @override
  State<CityDataPage> createState() => _CityDataPageState();
}

class _CityDataPageState extends State<CityDataPage> {
  final List<Profile> _profiles = [];
  String? _nextCursor;
  bool _isLoadingProfiles = false;
  bool _profilesLoaded = false;

  Future<void> _loadProfiles({bool loadMore = false}) async {
    if (_isLoadingProfiles) return;
    final cursor = loadMore ? _nextCursor : null;
    if (loadMore && cursor == null) return;

    setState(() => _isLoadingProfiles = true);
    try {
      final page = await context.read<UsersRepository>().getUsersAtLocation(
        widget.coords.fullLocation,
        cursor: cursor,
      );
      setState(() {
        if (!loadMore) _profiles.clear();
        _profiles.addAll(page.items);
        _nextCursor = page.nextCursor;
        _profilesLoaded = true;
      });
    } finally {
      if (mounted) setState(() => _isLoadingProfiles = false);
    }
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
    title: widget.coords.city,
    actions: [
      AppButton(
        child: Text(
          'Create an event',
          style: AppTextStyles.actionSB.copyWith(color: Colors.white),
        ),
        onTap: () => context.replaceRoute(
          EventEditingRoute(
            eventId: const None(),
            location: Option.of(widget.coords.fullLocation),
          ),
        ),
      ),
    ],
    body: AppChildBody(
      padding: EdgeInsets.zero,
      child: Column(
        spacing: 8,
        children: [
          if (widget.cityData.alumniCount > 0 || _profiles.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _InCityButton(
                alumniCount: widget.cityData.alumniCount,
                profiles: _profiles,
                isLoaded: _profilesLoaded,
                isLoading: _isLoadingProfiles,
                nextCursor: _nextCursor,
                onOpen: () async {
                  if (!_profilesLoaded) await _loadProfiles();
                },
                onLoadMore: () => _loadProfiles(loadMore: true),
              ),
            ),
          Expanded(
            child: EventsList(events: widget.cityData.events, refresh: null),
          ),
        ],
      ),
    ),
  );
}

class _InCityButton extends StatelessWidget {
  const _InCityButton({
    required this.alumniCount,
    required this.profiles,
    required this.isLoaded,
    required this.isLoading,
    required this.nextCursor,
    required this.onOpen,
    required this.onLoadMore,
  });

  final int alumniCount;
  final List<Profile> profiles;
  final bool isLoaded;
  final bool isLoading;
  final String? nextCursor;
  final Future<void> Function() onOpen;
  final Future<void> Function() onLoadMore;

  @override
  Widget build(BuildContext context) => AppButton(
    buttonStyle: AppButtonStyle.gray,
    onTap: () async {
      await onOpen();
      if (!context.mounted) return;
      showCupertinoSheet(
        context: context,
        pageBuilder: (context) => _InCitySheet(
          profiles: profiles,
          isLoading: isLoading,
          nextCursor: nextCursor,
          onLoadMore: onLoadMore,
        ),
      );
    },
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
        if (profiles.isNotEmpty)
          StackedRow(profiles: profiles)
        else if (alumniCount > 0)
          Text(
            '$alumniCount',
            style: AppTextStyles.caption.copyWith(color: AppColors.gray50),
          ),
        const Icon(Icons.arrow_forward_ios, color: AppColors.gray50),
      ],
    ),
  );
}

class _InCitySheet extends StatefulWidget {
  const _InCitySheet({
    required this.profiles,
    required this.isLoading,
    required this.nextCursor,
    required this.onLoadMore,
  });

  final List<Profile> profiles;
  final bool isLoading;
  final String? nextCursor;
  final Future<void> Function() onLoadMore;

  @override
  State<_InCitySheet> createState() => _InCitySheetState();
}

class _InCitySheetState extends State<_InCitySheet> {
  late List<Profile> _profiles;
  late bool _isLoading;
  late String? _nextCursor;

  @override
  void initState() {
    super.initState();
    _profiles = List.of(widget.profiles);
    _isLoading = widget.isLoading;
    _nextCursor = widget.nextCursor;
  }

  Future<void> _loadMore() async {
    if (_isLoading || _nextCursor == null) return;
    setState(() => _isLoading = true);
    await widget.onLoadMore();
    if (mounted) {
      setState(() {
        _profiles = List.of(widget.profiles);
        _nextCursor = widget.nextCursor;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'In city',
    leadingButton: const NavButton(content: NavButtonContent.close),
    body: AppListBody(
      children: [
        ..._profiles.map(
          (p) => AppButton(
            buttonStyle: AppButtonStyle.text,
            child: Row(
              spacing: 8,
              children: [
                ProfilePic(profile: p, size: 48),
                Expanded(child: Text(p.fullName, style: AppTextStyles.body)),
                const Icon(Icons.arrow_forward_ios, color: AppColors.gray50),
              ],
            ),
            onTap: () => context.pushRoute(ProfileRoute(profile: Option.of(p))),
          ),
        ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (_nextCursor != null)
          AppButton(
            buttonStyle: AppButtonStyle.gray,
            onTap: _loadMore,
            child: const Text('Load more'),
          ),
      ],
    ),
  );
}

