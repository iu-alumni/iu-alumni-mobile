import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/repositories/map/map_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../blocs/root/root_page_cubit.dart';
import '../../blocs/pin_locations/pin_locations_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../events_list/events_list_page.dart';
import '../map/map_page.dart';
import '../profile/profile_page.dart';

@RoutePage()
class RootPage extends StatefulWidget implements AutoRouteWrapper {
  const RootPage({super.key});

  static const navigationBarHeight = 144;

  @override
  State<RootPage> createState() => _RootPageState();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => RootPageCubit()),
          BlocProvider(
            create: (context) => PinLocationsCubit(
              context.read<MapRepository>(),
            ),
          ),
        ],
        child: this,
      );
}

class _RootPageState extends State<RootPage> {
  late final Widget _eventsPage = const EventsListPage();
  late final Widget _mapPage = const MapPage();
  late final Widget _profilePage = const ProfilePage();

  late final _tabs = [
    (true, Icons.location_pin, RootPageState.mapPage, 'map'),
    (false, Icons.calendar_month, RootPageState.eventsListPage, 'events'),
    (true, Icons.person, RootPageState.profilePage, 'profile'),
  ]
      .map(
        (d) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _NavButton(
            small: d.$1,
            icon: d.$2,
            page: d.$3,
            tabName: d.$4,
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
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
            Positioned(
              left: 0,
              right: 0,
              bottom: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _tabs,
              ),
            )
          ],
        ),
      );
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.small,
    required this.icon,
    required this.page,
    required this.tabName,
  });

  final bool small;
  final IconData icon;
  final RootPageState page;
  final String tabName;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RootPageCubit, RootPageState>(
        builder: (context, currentPage) => AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.elliptical(16, 16)),
            color: currentPage == page ? AppColors.primary : AppColors.darkGray,
          ),
          duration: const Duration(milliseconds: 300),
          child: IconButton(
            onPressed: () {
              context.read<Reporter>().reportTabChanged(tabName);
              context.read<RootPageCubit>().navigateTo(page);
            },
            icon: Icon(
              icon,
              color: Colors.white,
              size: small ? 36 : 64,
            ),
          ),
        ),
      );
}
