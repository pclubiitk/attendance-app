import 'package:attendance_app/location/location_service.dart';
import 'package:attendance_app/location/map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position? _currentPosition;
  List<LatLng> _locations = [];
  bool _fetchingLocation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: _locations.isEmpty ? _buildPlaceholder() : LocationMap(locations: _locations),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _fetchingLocation ? null : _getCurrentLocation, // Disable button while fetching
            child: _fetchingLocation
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                    ],
                  )
                : const Icon(Icons.location_on),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: Text(
        'No locations yet. Press the button to get current location.',
        textAlign: TextAlign.center,
      ),
    );
  }

  void _getCurrentLocation() async {
    setState(() {
      _fetchingLocation = true;
    });

    try {
      Position position = await LocationService().determinePosition();
      setState(() {
        _currentPosition = position;
        _locations.add(LatLng(position.latitude, position.longitude));
        _fetchingLocation = false; // Fetching completed
      });
    } catch (e) {
      print(e);
      _showErrorDialog(e);
      setState(() {
        _fetchingLocation = false; // Fetching failed
      });
    }
  }

  void _printLocations() {
    for (var location in _locations) {
      print('Latitude: ${location.latitude}, Longitude: ${location.longitude}');
    }
  }

  void _showErrorDialog(Object e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Error'),
        content: Text('$e'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
