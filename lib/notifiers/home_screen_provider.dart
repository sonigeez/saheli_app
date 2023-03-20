import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saheli_app/app.dart';

class HomeScreenProvider extends ChangeNotifier {
  LatLng? _currentLocation;
  final kGoogleApiKey = 'AIzaSyBPbqIkJ2zzLtlOW12omt67Puy845O5oBA';

  LatLng? get currentLocation => _currentLocation;

  LatLng? _destinationLocation;
  LatLng? get destinationLocation => _destinationLocation;

  String? _destinationAddress;
  String? get getDestinationAddress => _destinationAddress;
  Marker? marker;
  // Map<PolylineId, Polyline> polylines = {};
  Polyline? polyline;

  late PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

  _createPolylines() async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();
    polylineCoordinates.clear();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      kGoogleApiKey, // Google Maps API Key
      PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
      PointLatLng(_destinationLocation!.latitude, _destinationLocation!.longitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    // Defining an ID
    PolylineId id = const PolylineId('poly');

    // Initializing Polyline
    polyline = Polyline(
      polylineId: id,
      color: MyColors.primayColor,
      points: polylineCoordinates,
      width: 6,
      endCap: Cap.roundCap,
      jointType: JointType.round,
      startCap: Cap.roundCap,
    );
  }

  void setCurrentLocation(LatLng? location) {
    _currentLocation = location;
    notifyListeners();
  }

  Future<void> setDestinationLocation(LatLng? location) async {
    _destinationLocation = location;
    await _createPolylines();
    notifyListeners();
  }

  void setDestinationAddress(String? address) {
    _destinationAddress = address;
  }

  void addMarker(LatLng? location) {
    marker = Marker(markerId: MarkerId(Random().nextInt(999).toString()), position: location!);
    notifyListeners();
  }
}
