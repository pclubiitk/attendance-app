import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationMap extends StatelessWidget {
  final List<LatLng> locations;

  const LocationMap({Key? key, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       // Determine the initial center based on the first location in the list,
    // or a default location if `_locations` is empty.
    LatLng initialCenter = locations.isNotEmpty
        ? locations.first
        : LatLng(28.6139, 77.2090); // Default center (Delhi, India)

    return FlutterMap(
       options:  MapOptions(
      initialCenter: initialCenter,
      initialZoom: 17,
    ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: locations.map((location) {
            return Marker(
              width: 80.0,
              height: 80.0,
              point: location,
              child: const Icon(Icons.pin_drop, color: Colors.red),
            );
          }).toList(),
        ),
      ],
    );
  }
}
