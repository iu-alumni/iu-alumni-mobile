import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

import '../../../gen/assets.gen.dart'; 

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapController _mapController;

  List<LatLng> get _mapPoints => const [
        LatLng(55.755793, 37.617134),
        LatLng(55.095960, 38.765519),
        LatLng(56.129038, 40.406502),
        LatLng(54.513645, 36.261268),
        LatLng(54.193122, 37.617177),
        LatLng(54.629540, 39.741809),
      ];

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Screen')),
      body: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          initialCenter: LatLng(55.755793, 37.617134),
          initialZoom: 5,
        ),
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation,
            ),
            child: TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.flutter_map_example',
            ),
          ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              size: const Size(50, 50),
              maxClusterRadius: 50,
              markers: _getMarkers(_mapPoints),
              builder: (_, markers) {
                return _ClusterMarker(
                  markersLength: markers.length.toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Marker> _getMarkers(List<LatLng> mapPoints) {
  return List.generate(
    mapPoints.length,
    (index) => Marker(
      point: mapPoints[index],
      child: Image.asset(Assets.icons.map.profilePin.path),
      width: 50,
      height: 50,
      alignment: Alignment.center,
    ),
  );
}

class _ClusterMarker extends StatelessWidget {
  const _ClusterMarker({required this.markersLength});

  final String markersLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[200],
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue,
          width: 3,
        ),
      ),
      child: Center(
        child: Text(
          markersLength,
          style: TextStyle(
            color: Colors.blue[900],
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
