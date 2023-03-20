// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saheli_app/app.dart';
import 'package:saheli_app/notifiers/home_screen_provider.dart';
import 'package:saheli_app/notifiers/user_notifier.dart';
import 'package:saheli_app/router/app_router.gr.dart';
import 'package:saheli_app/services/auth_services.dart';
import 'package:saheli_app/services/location_services.dart';
import 'package:saheli_app/utils/shared_pref.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  GoogleMapController? _mapController;
  late final TextEditingController _controller;
  late final TextEditingController _shortNoteController;
  bool switchValue = false;
  late final ValueNotifier<bool> _availability;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    super.initState();
    _availability = ValueNotifier(false);
    _controller = TextEditingController(text: 'Gopal Pura Mod');
    _shortNoteController = TextEditingController();

    context.read<UserNotifier>().connectStreamUser(
          User(
            id: SharedPreferencesHelper.storage.getString("userId")!,
            name: SharedPreferencesHelper.storage.getString("username"),
          ),
          context.streamChatClient,
        );

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
                      height: MediaQuery.of(context).size.height * 0.64,
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
                            markers: context
                                        .read<HomeScreenProvider>()
                                        .marker !=
                                    null
                                ? {context.read<HomeScreenProvider>().marker!}
                                : {},
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  ),
                                ],
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
                                  color: Colors.blue,
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                            ),
                          ],
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Mark your availability"),
                      ValueListenableBuilder(
                          valueListenable: _availability,
                          builder: (context, svalue, _) {
                            return Switch(
                              value: svalue,
                              onChanged: (value) {
                                _availability.value = value;
                                AuthServices.setAvailability(value);
                              },
                            );
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.6,
                        ),
                      ],
                      border: Border.all(color: Colors.grey),
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
                            child: Text(
                              context
                                      .read<HomeScreenProvider>()
                                      .getDestinationAddress ??
                                  "Enter Destination",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.6,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 50,
                    child: TextField(
                      controller: _shortNoteController,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Icon(
                            Icons.note_add,
                            color: Colors.grey,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        hintText: 'Enter Short Note',
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
                  onPressed: () async {
                    if (context
                                .read<HomeScreenProvider>()
                                .destinationLocation !=
                            null &&
                        _shortNoteController.text.isNotEmpty) {
                      // upload your location.
                      await LocationServices.uploadLocation(
                          context.read<HomeScreenProvider>().currentLocation!);
                      // upload short note.
                      await LocationServices.uploadShortNote(
                          _shortNoteController.text);
                      // find saheli for youself.
                      context.pushRoute(const NearmeusersRoute());
                      // jump to next page where everything uploads and happens next.
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Please make sure you have fill all the fields")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Find Saheli'),
                  ),
                ),
                const SizedBox(height: 20),
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
                children: [
                  const CircleAvatar(radius: 40, backgroundColor: Colors.red),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      SharedPreferencesHelper.storage.getString("name")!,
                      style: const TextStyle(
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
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Settings'),
          //   onTap: () {
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Messages'),
            onTap: () => context.pushRoute(const ChatListScreenRoute()),
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
            onTap: () async {
              await StreamChat.of(context).client.disconnectUser();
              await SharedPreferencesHelper.storage.clear();
              context.router.pushAndPopUntil(
                const LoginRoute(),
                predicate: (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
