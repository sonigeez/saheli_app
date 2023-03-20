// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../notifiers/saheli_tracking_page.dart';

const kGoogleApiKey = 'AIzaSyBPbqIkJ2zzLtlOW12omt67Puy845O5oBA';

class SaheliTrackingPage extends StatefulWidget {
  const SaheliTrackingPage(
      {super.key,
      required this.destinationLocation,
      required this.sourceLocation});
  final LatLng destinationLocation;
  final LatLng sourceLocation;

  @override
  State<SaheliTrackingPage> createState() => _SaheliTrackingPageState();
}

class _SaheliTrackingPageState extends State<SaheliTrackingPage> {
  GoogleMapController? mapController;
  late LatLng initialLocation;
  late LatLng destinationLocation;
  late PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Polyline? polyline;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  _moveCameraToCurrentLocation() {
    mapController!.animateCamera(CameraUpdate.newLatLngZoom(
        context.read<SaheliTrackingPageNotifier>().currentLocation!, 15));
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    await Geolocator.requestPermission();
    Provider.of<SaheliTrackingPageNotifier>(context, listen: false)
        .setCurrentLocation(LatLng(position.latitude, position.longitude));

    _moveCameraToCurrentLocation();
  }

  _createPolylines() async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();
    polylineCoordinates.clear();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      kGoogleApiKey, // Google Maps API Key
      PointLatLng(initialLocation.latitude, initialLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
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
    setState(() {});
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              size: Size(1, 1),
            ),
            "assets/images/current_location.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  void initState() {
    initialLocation = widget.sourceLocation;
    destinationLocation = widget.destinationLocation;
    addCustomIcon();
    _createPolylines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      context.watch<SaheliTrackingPageNotifier>().locationStreams();
      return Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.sourceLocation,
            zoom: 14.4746,
          ),
          polylines: {
            if (polyline != null) polyline!,
          },
          markers: {
            Marker(
              markerId: MarkerId('sourcePin'),
              position: initialLocation,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
            ),
            Marker(
              markerId: MarkerId('destPin'),
              position: destinationLocation,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ),
          },
          myLocationEnabled: true,
          onMapCreated: (controller) async {
            mapController = controller;
            _getCurrentLocation();
          },
        ),
      );
    });
  }
}
