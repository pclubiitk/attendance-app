import 'dart:async';
import 'dart:developer';
import 'package:attendance_app/location/event_service.dart';
import 'package:attendance_app/model/event.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  Position? _currentPosition;
  LatLng? _locations;
  bool _fetchingLocation = false;
  bool _markingAttendance = false;
  CameraPosition? _initialLocation;
  double distance = 0.0;
  double _eventRadius = 400.0;
  StreamSubscription<Position>? positionStream;
  String? _currentAddress;
  Event? event;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  void _initialize() {
    _getCurrentLocation();
    _startLocationUpdates();
    _fetchEvent();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _updateLocation(Position position) {
    setState(() {
      _locations = LatLng(position.latitude, position.longitude);
      _initialLocation = CameraPosition(
        target: _locations!,
        zoom: 15,
      );
      if (event != null) {
        distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          event!.location.latitude,
          event!.location.longitude,
        );
      }
      _fetchingLocation = false; // Fetching completed
      log("Location: ${position.latitude}, ${position.longitude}");
      log("Distance: $distance");
    });
  }

  void _startLocationUpdates() {
    positionStream = Geolocator.getPositionStream().listen((position) {
      _updateLocation(position);
      _getAddressFromLatLng(position);
      log("Position updated: $position");
    });
  }

  void _getCurrentLocation() async {
    setState(() {
      _fetchingLocation = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition();
      _updateLocation(position);
    } catch (e) {
      log("Error getting current location: $e");
      _showErrorDialog(e);
      setState(() {
        _fetchingLocation = false; // Fetching failed
      });
    }
  }

  void _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      });
      log("Current address: $_currentAddress");
    } catch (e) {
      log("Error getting address: $e");
    }
  }

  void _markAttendance() async {
    setState(() {
      _markingAttendance = true;
    });

    try {
      // Add attendance marking logic here
      // await AttendanceService().markAttendance();
      await Future.delayed(const Duration(seconds: 2));
      log('Attendance marked successfully');
      setState(() {
        _markingAttendance = false; // Marking completed
      });
    } catch (e) {
      log("Error marking attendance: $e");
      _showErrorDialog(e);
      setState(() {
        _markingAttendance = false; // Marking failed
      });
    }
  }

  void _fetchEvent() async {
    try {
      Event fetchedEvent = await EventService().fetchEvent('1');
      setState(() {
        event = fetchedEvent;
        _initialLocation = CameraPosition(
          target: event!.location,
          zoom: 15,
        );
        _eventRadius = event!.eventRadius;
      });
      log("Event fetched: ${event?.name}");
    } catch (e) {
      log("Error fetching event: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Mark Attendance'),
        prefixActions: [
          FHeaderAction.back(
            onPress: () {
              if (Navigator.of(context).canPop()) {
                Navigator.pop(context); // Pop the current route
              }
            },
          ),
        ],
        suffixActions: [
          FHeaderAction(
            icon: FIcon(FAssets.icons.search),
            onPress: () {},
          ),
          FHeaderAction(
            icon: FIcon(FAssets.icons.plus),
            onPress: () {},
          ),
        ],
      ),
      content: _initialLocation == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: screenWidth,
                      child: FCard(
                        title: Text(event?.name ?? 'Event Details:'),
                        subtitle: Text(
                          event?.description != null &&
                                  event!.description.length > 100
                              ? '${event!.description.substring(0, 100)}...'
                              : event?.description ??
                                  'Loading event details...',
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Start: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: event != null
                                        ? '${DateFormat.yMMMMd().format(event!.date)} ${DateFormat('jm').format(event!.date)}'
                                        : 'Loading...',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 103, 101, 101),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Deadline: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: event != null
                                        ? '${DateFormat.yMMMMd().format(event!.deadline)} ${DateFormat('jm').format(event!.date)}'
                                        : 'Loading...',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 103, 101, 101),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Location: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: event != null
                                        ? event!.address
                                        : 'Loading...',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 103, 101, 101),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.4,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        zoomGesturesEnabled: true,
                        tiltGesturesEnabled: false,
                        myLocationEnabled: true,
                        initialCameraPosition: _initialLocation!,
                        onCameraMove: (CameraPosition cameraPosition) {
                          log("Camera moved to zoom: ${cameraPosition.zoom}");
                        },
                        markers: {
                          Marker(
                            markerId: MarkerId('Event Location'),
                            position: event?.location ?? LatLng(0, 0),
                          ),
                        },
                        circles: {
                          Circle(
                            circleId: CircleId("1"),
                            center: event?.location ?? LatLng(0, 0),
                            radius: event?.eventRadius ?? 400.0,
                            strokeWidth: 2,
                            strokeColor: Colors.blueAccent,
                            fillColor: const Color.fromARGB(96, 82, 240, 240),
                          ),
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Distance from Event Location: ${(distance / 1000).toStringAsFixed(2)} km',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color:
                            distance < _eventRadius ? Colors.green : Colors.red,
                      ),
                    ),
                    Text(
                      "Your Location: ${_currentAddress ?? 'Loading...'}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FButton(
                      prefix: _markingAttendance
                          ? const CircularProgressIndicator()
                          : null,
                      label: distance < _eventRadius
                          ? const Text('Mark Attendance')
                          : const Text('Not in Event Location'),
                      onPress: distance < _eventRadius ? _markAttendance : null,
                    ),
                  ],
                ),
              ),
            ),
    );
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