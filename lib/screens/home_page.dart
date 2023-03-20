// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saheli_app/notifiers/home_screen_provider.dart';
import 'package:saheli_app/router/app_router.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

const kGoogleApiKey = 'AIzaSyBPbqIkJ2zzLtlOW12omt67Puy845O5oBA';

class HomePageState extends State<HomePage> {
  GoogleMapController? _mapController;
  late TextEditingController _controller;
  late TextEditingController _shortNoteController;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  // Object for PolylinePoints
  late PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points

  // Create the polylines for showing the route between two places

  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      kGoogleApiKey, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
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
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    context.read<HomeScreenProvider>().setPolyline(polyline);
    // Adding the polyline to the map
    // polylines[id] = polyline;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'Gopal Pura Mod');
    _shortNoteController = TextEditingController();

    _requestLocationPermission();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  dispose() {
    _controller.dispose();
    _shortNoteController.dispose();

    super.dispose();
  }

  _requestLocationPermission() async {
    // await Permission.location.request();
    await Geolocator.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    _moveCameraToCurrentLocation() {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(
          context.read<HomeScreenProvider>().currentLocation!, 15));
    }

    _getCurrentLocation() async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      await Geolocator.requestPermission();
      Provider.of<HomeScreenProvider>(context, listen: false)
          .setCurrentLocation(LatLng(position.latitude, position.longitude));

      _moveCameraToCurrentLocation();
    }

    return Consumer<HomeScreenProvider>(builder: (context, value, child) {
      if (context.read<HomeScreenProvider>().markers.isNotEmpty &&
          _mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLngZoom(
            context.read<HomeScreenProvider>().destinationLocation!, 15));
      }
      return SafeArea(
        child: Scaffold(
          key: _key,
          drawer: const AppDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Stack(
                        children: [
                          GoogleMap(
                            onCameraMove: (position) {},
                            polylines: <Polyline>{
                              // ...polylines.values,
                              ...context
                                  .read<HomeScreenProvider>()
                                  .polylines
                                  .values,
                            },
                            initialCameraPosition: const CameraPosition(
                                target: LatLng(0, 0), zoom: 13),
                            onMapCreated:
                                (GoogleMapController controller) async {
                              _mapController = controller;
                              _getCurrentLocation();
                              if (context
                                          .read<HomeScreenProvider>()
                                          .currentLocation !=
                                      null &&
                                  context
                                          .read<HomeScreenProvider>()
                                          .destinationLocation !=
                                      null) {
                                await _createPolylines(
                                  context
                                      .read<HomeScreenProvider>()
                                      .currentLocation!
                                      .latitude,
                                  context
                                      .read<HomeScreenProvider>()
                                      .currentLocation!
                                      .longitude,
                                  context
                                      .read<HomeScreenProvider>()
                                      .destinationLocation!
                                      .latitude,
                                  context
                                      .read<HomeScreenProvider>()
                                      .destinationLocation!
                                      .longitude,
                                );
                              }
                            },
                            gestureRecognizers: {
                              Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer())
                            },
                            myLocationEnabled: true,
                            myLocationButtonEnabled: false,
                            markers: context.read<HomeScreenProvider>().markers,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                    const CircleBorder(),
                                  ),
                                ),
                                onPressed: () {
                                  _moveCameraToCurrentLocation();
                                },
                                icon: const Icon(
                                  Icons.my_location,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                const CircleBorder(),
                              ),
                            ),
                            onPressed: () {
                              _key.currentState!.openDrawer();
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        context.router.push(DestinationSelectionRoute());
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(context
                                    .read<HomeScreenProvider>()
                                    .getDestinationAddress ??
                                "Enter Destination"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: TextField(
                    controller: _shortNoteController,
                    decoration: const InputDecoration(
                      hintText: 'Enter short Note',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (context
                                .read<HomeScreenProvider>()
                                .destinationLocation !=
                            null &&
                        _shortNoteController.text.isNotEmpty) {}
                  },
                  child: const Text('Find Saheli'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(radius: 40, backgroundColor: Colors.red),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Saheli',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Messages'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.emergency),
            title: const Text('Emergency'),
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
