// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

class HomePageState extends State<HomePage> {
  GoogleMapController? _mapController;
  late TextEditingController _controller;
  late TextEditingController _shortNoteController;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

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

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(builder: (context, value, child) {
      if (context.read<HomeScreenProvider>().marker != null &&
          _mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLngZoom(
            context.read<HomeScreenProvider>().destinationLocation!, 12));
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
                              context.read<HomeScreenProvider>().polyline ??
                                  const Polyline(
                                      polylineId: PolylineId("test")),
                            },
                            initialCameraPosition: const CameraPosition(
                                target: LatLng(0, 0), zoom: 13),
                            onMapCreated:
                                (GoogleMapController controller) async {
                              _mapController = controller;
                              final provider =
                                  context.read<HomeScreenProvider>();
                              if (provider.currentLocation == null) {
                                await _getCurrentLocation();
                              }
                            },
                            gestureRecognizers: {
                              Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer())
                            },
                            myLocationEnabled: true,
                            myLocationButtonEnabled: false,
                            markers: {
                              context.read<HomeScreenProvider>().marker ??
                                  const Marker(markerId: MarkerId("test"))
                            },
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _shortNoteController,
                      decoration: const InputDecoration(
                        hintText: 'Enter short Note',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // if (context.read<HomeScreenProvider>().destinationLocation != null &&
                    //     _shortNoteController.text.isNotEmpty) {}

                    // context.router.push(SaheliTrackingRoute(
                    //   sourceLocation: const LatLng(28.7041, 77.1025),
                    //   destinationLocation: const LatLng(28.5355, 77.3910),
                    // ));
                    context.router.push(const RecommendedPlacesRoute());
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
            leading: const Icon(Icons.how_to_reg_sharp),
            title: const Text('Self Defence Tutorials'),
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
            leading: const Icon(Icons.emergency, color: Colors.red),
            title: const Text(
              'Emergency',
              style: TextStyle(color: Colors.red),
            ),
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
