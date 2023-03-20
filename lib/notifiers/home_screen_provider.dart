import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreenProvider extends ChangeNotifier {
  LatLng? _currentLocation;
  LatLng? get currentLocation => _currentLocation;

  LatLng? _destinationLocation;
  LatLng? get destinationLocation => _destinationLocation;

  String? _destinationAddress;
  String? get getDestinationAddress => _destinationAddress;
  Set<Marker> markers = <Marker>{};
  Map<PolylineId, Polyline> polylines = {};

  void setPolyline(Polyline polyline) {
    polylines[polyline.polylineId] = polyline;
    notifyListeners();
  }

  void setCurrentLocation(LatLng? location) {
    _currentLocation = location;
    notifyListeners();
  }

  void setDestinationLocation(LatLng? location) {
    _destinationLocation = location;
    notifyListeners();
  }

  void setDestinationAddress(String? address) {
    _destinationAddress = address;
    notifyListeners();
  }

  void addMarker(LatLng? location) {
    markers.add(Marker(
      markerId: MarkerId(Random().nextInt(999).toString()),
      position: location!,
    ));
    notifyListeners();
  }
}
