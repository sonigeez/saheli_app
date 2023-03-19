import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../router/app_router.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  LatLng? _currentLocation;
  GoogleMapController? _mapController;
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'Gopal Pura Mod');

    _requestLocationPermission();
  }

  _requestLocationPermission() async {
    // await Permission.location.request();
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _moveCameraToCurrentLocation();
    });
  }

  _moveCameraToCurrentLocation() {
    _mapController!
        .animateCamera(CameraUpdate.newLatLngZoom(_currentLocation!, 15));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition:
                            const CameraPosition(target: LatLng(0, 0), zoom: 1),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController = controller;
                          _getCurrentLocation();
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
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
                              _getCurrentLocation();
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
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 50,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                child: Text(
                                  "Gopal Pura Mod",
                                  style: TextStyle(color: Colors.grey),
                                ),
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
                    const Expanded(
                      child: Text(
                        "Enter Destination",
                        style: TextStyle(color: Colors.grey),
                      ),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter short Note',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // context.router.push(const MapScreenRoute());
              },
              child: const Text('Find Saheli'),
            ),
          ],
        ),
      ),
    );
  }
}
