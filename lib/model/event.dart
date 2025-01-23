import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final String id;
  final String name;
  final String address;
  final Position position;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.position,
  });
}


class Event {
  final String id;
  final String name;
  final DateTime date;
  final LatLng location;
  final String description;
  final DateTime deadline ;
  final String address;
  final double eventRadius;


  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.description,
    required this.deadline,
    required this.address,
    required this.eventRadius,
  });
  
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      location: LatLng(json['location']['latitude'], json['location']['longitude']),
      description: json['description'],
      deadline: DateTime.parse(json['deadline']),
      address: json['address'],
      eventRadius: json['eventRadius'],
    );
  }

  
}

class SubEvent {
  final String id;
  final String name;
  final DateTime date;
  final Location location;
  final String eventId;
  final String description;

  SubEvent({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.eventId,
    required this.description,
  });
}