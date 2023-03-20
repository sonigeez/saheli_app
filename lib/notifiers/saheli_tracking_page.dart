import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SaheliTrackingPageNotifier extends ChangeNotifier {
  LatLng? _currentLocation;

  LatLng? get currentLocation => _currentLocation;

  Future<LatLng> getLiveLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return _currentLocation = LatLng(position.latitude, position.longitude);
  }

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  locationStreams() async {
    Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      _currentLocation = LatLng(position.latitude, position.longitude);
      notifyListeners();
    });
  }

  void setCurrentLocation(LatLng? location) {
    _currentLocation = location;
    notifyListeners();
  }
}
