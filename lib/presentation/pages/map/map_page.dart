import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui_alumni_mobile/presentation/common/constants/app_text_styles.dart';
import 'package:ui_alumni_mobile/presentation/router/app_router.gr.dart';

import '../../../application/repositories/map/map_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../blocs/pin_locations/pin_locations_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/models/loaded_state.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapController _mapController;

  @override
  void initState() {
    _mapController = MapController();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => context.read<PinLocationsCubit>().update(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _open(NamedCoordinates nc, CityData city) {
    context.read<Reporter>().reportOpenMapLocation(nc.city, AppLocation.mapTab);
    context.pushRoute(CityDataRoute(coords: nc, cityData: city));
  }

  List<Marker> _markers(MapInfo info) => [
    for (final city in info.entries)
      Marker(
        width: 500,
        height: 500,
        alignment: Alignment.center,
        point: LatLng(city.key.coord.lat, city.key.coord.lng),
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(100),
              color: AppColors.darkGray,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () => _open(city.key, city.value),
                child: Text(
                  city.key.city,
                  style: AppTextStyles.caption.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        // Innopolis LatLng
        initialCenter: LatLng(55.752117, 48.744552),
        initialZoom: 3,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.innopolis.alumni',
        ),
        BlocBuilder<PinLocationsCubit, PinLocationsState>(
          builder: (context, mapInfo) => MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              size: const Size(48, 48),
              maxClusterRadius: 50,
              markers: switch (mapInfo) {
                LoadedStateData(:final data) => _markers(data),
                _ => [],
              },
              builder: (context, markers) =>
                  _ClusterMarker(markersLength: markers.length.toString()),
            ),
          ),
        ),
      ],
    ),
  );
}

class _ClusterMarker extends StatelessWidget {
  const _ClusterMarker({required this.markersLength});

  final String markersLength;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: AppColors.darkGray,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        '+$markersLength',
        style: AppTextStyles.caption.copyWith(color: Colors.white),
      ),
    ),
  );
}
