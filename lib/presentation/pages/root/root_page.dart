import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Badge;
// ignore: implementation_imports — relying on the public auto_route export
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/models/badge.dart';
import '../../../application/repositories/map/map_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../blocs/badges/badges_cubit.dart';
import '../../blocs/models/badges_state.dart';
import '../../blocs/root/root_page_cubit.dart';
import '../../blocs/pin_locations/pin_locations_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/app_button.dart';
import '../events_list/events_list_page.dart';
import '../map/map_page.dart';
import '../profile/profile_page.dart';
import '../profile/widgets/badge_earned_popup.dart';

@RoutePage()
class RootPage extends StatefulWidget implements AutoRouteWrapper {
  const RootPage({super.key});

  static const navigationBarHeight = 56;

  @override
  State<RootPage> createState() => _RootPageState();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => RootPageCubit()),
      BlocProvider(
        create: (context) => PinLocationsCubit(context.read<MapRepository>()),
      ),
    ],
    child: this,
  );
}

class _RootPageState extends State<RootPage> {
  late final Widget _eventsPage = const EventsListPage();
  late final Widget _mapPage = const MapPage();
  late final Widget _profilePage = const ProfilePage();

  // Popup-chain state. RootPage sits INSIDE the Navigator, so showDialog
  // works here whereas it'd fail from MaterialApp.builder above the router.
  final Set<String> _badgesShown = {};
  bool _popupInFlight = false;

  static List<Badge> _newly(BadgesState s) => switch (s.badges) {
    LoadedStateData<BadgesData>(:final data) => data.newlyEarned,
    _ => const <Badge>[],
  };

  Future<void> _drainBadgePopups(BuildContext context, BadgesState s) async {
    if (_popupInFlight) {
      return;
    }
    final fresh = _newly(s).where((b) => !_badgesShown.contains(b.code)).toList();
    if (fresh.isEmpty) {
      return;
    }
    _popupInFlight = true;
    final cubit = context.read<BadgesCubit>();
    final rootCubit = context.read<RootPageCubit>();
    var jumpToProfile = false;
    try {
      for (final badge in fresh) {
        if (!context.mounted) {
          break;
        }
        final viewProfile = await BadgeEarnedPopup.show(context, cubit, [badge]);
        _badgesShown.add(badge.code);
        if (viewProfile) {
          jumpToProfile = true;
        }
      }
    } finally {
      if (mounted) {
        _popupInFlight = false;
      }
    }
    if (jumpToProfile && mounted) {
      // Pop any routes pushed on top of RootPage (e.g. the event details
      // page) so the profile tab is actually visible after the switch.
      final router = context.router;
      while (router.canPop()) {
        await router.maybePop();
      }
      if (mounted) {
        rootCubit.navigateTo(RootPageState.profilePage);
      }
    }
  }

  late final _tabs =
      [
            (Icons.location_pin, RootPageState.mapPage, 'map'),
            (Icons.calendar_month, RootPageState.eventsListPage, 'events'),
            (Icons.person, RootPageState.profilePage, 'profile'),
          ]
          .map(
            (d) => Expanded(
              child: BlocBuilder<RootPageCubit, RootPageState>(
                builder: (context, currentPage) => AppButton(
                  padding: EdgeInsets.zero,
                  buttonStyle: currentPage == d.$2
                      ? AppButtonStyle.primary
                      : AppButtonStyle.secondary,
                  onTap: () {
                    context.read<Reporter>().reportTabChanged(d.$3);
                    context.read<RootPageCubit>().navigateTo(d.$2);
                  },
                  child: Transform.scale(
                    scale: 4,
                    child: Icon(d.$1, color: Colors.white, size: 8),
                  ),
                ),
              ),
            ),
          )
          .toList();

  @override
  Widget build(BuildContext context) => BlocListener<BadgesCubit, BadgesState>(
    listenWhen: (p, c) {
      final codes = _newly(c).map((b) => b.code).toSet();
      return codes.difference(_badgesShown).isNotEmpty;
    },
    listener: _drainBadgePopups,
    child: Stack(
    children: [
      Positioned.fill(
        child: BlocBuilder<RootPageCubit, RootPageState>(
          builder: (context, page) => switch (page) {
            RootPageState.eventsListPage => _eventsPage,
            RootPageState.mapPage => _mapPage,
            RootPageState.profilePage => _profilePage,
          },
        ),
      ),
      Positioned.fill(
        top: null,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: SizedBox(
              height: 48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.darkGray,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(children: _tabs),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
    ),
  );
}
