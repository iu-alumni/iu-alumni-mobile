import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:latlong2/latlong.dart';

import '../../../application/models/coordinates.dart';
import '../../../application/models/event.dart';
import '../../../application/models/profile.dart';
import '../../../application/repositories/map/map_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../blocs/pin_locations/pin_locations_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/button.dart';
import '../../router/app_router.gr.dart';

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

  List<Coordinates> _locations(Coordinates x, int n, double r) {
    // This function is AI-generated!!! I hope it works
    if (n <= 0) {
      return [];
    }
    if (n == 1) {
      return [x];
    }

    // Earth's radius in kilometers (approximate)
    const earthRadius = 6371.0;

    // Convert radius from kilometers to radians
    final angularDistance = r / earthRadius;

    final points = <Coordinates>[];
    final angleIncrement = 2 * pi / n;

    for (int i = 0; i < n; i++) {
      final angle = i * angleIncrement;

      // Convert center coordinates to radians
      final centerLatRad = x.lat * pi / 180;
      final centerLonRad = x.lng * pi / 180;

      // Calculate new latitude
      final newLatRad = asin(sin(centerLatRad) * cos(angularDistance) +
          cos(centerLatRad) * sin(angularDistance) * cos(angle));

      // Calculate new longitude
      final newLonRad = centerLonRad +
          atan2(sin(angle) * sin(angularDistance) * cos(centerLatRad),
              cos(angularDistance) - sin(centerLatRad) * sin(newLatRad));

      // Convert back to degrees
      final newLat = newLatRad * 180 / pi;
      final newLon = newLonRad * 180 / pi;

      points.add(Coordinates(newLat, newLon));
    }

    return points;
  }

  void _openProfile(Profile profile) {
    context.read<Reporter>().reportOpenProfile(profile, AppLocation.mapTab);
    context.pushRoute(ProfileRoute(profile: Option.of(profile)));
  }

  void _openEvent(EventModel event) {
    context.read<Reporter>().reportOpenEvent(event, AppLocation.mapTab);
    context.pushRoute(EventRoute(eventId: event.eventId));
  }

  void _onPinTap(MapPin pin) => switch (pin) {
        ProfilePin(:final profile) => _openProfile(profile),
        EventPin(:final event) => _openEvent(event),
      };

  List<Marker> _markers(MapInfo info) {
    final _list = <Marker>[];
    for (final e in info.entries) {
      final locs = _locations(e.key, e.value.length, 2);
      for (final (i, p) in e.value.indexed) {
        final point = locs[i];
        _list.add(
          Marker(
            point: LatLng(point.lat, point.lng),
            child: AppButton(
              borderRadius: BorderRadius.circular(48),
              onTap: () => _onPinTap(p),
              child: switch (p) {
                ProfilePin() => const Icon(Icons.person, color: Colors.white),
                EventPin() => const Icon(Icons.event, color: Colors.white),
              },
            ),
            width: 48,
            height: 48,
            alignment: Alignment.center,
          ),
        );
      }
    }
    return _list;
  }

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
                  builder: (context, markers) => _ClusterMarker(
                    markersLength: markers.length.toString(),
                  ),
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
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: AppColors.lightPrimary,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary,
            width: 3,
          ),
        ),
        child: Center(
          child: Text(
            markersLength,
            style: const TextStyle(
              color: AppColors.darkGray,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      );
}
