import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saheli_app/model/google_nearby_model.dart';
import 'package:saheli_app/notifiers/home_screen_provider.dart';
import 'package:saheli_app/repo/google_map_api_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommedndePlacesScreen extends StatefulWidget {
  const RecommedndePlacesScreen({super.key});

  @override
  State<RecommedndePlacesScreen> createState() =>
      _RecommedndePlacesScreenState();
}

class _RecommedndePlacesScreenState extends State<RecommedndePlacesScreen> {
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Safe Places'),
        ),
        body: FutureBuilder<GoogleNearbyAPIModel?>(
          future: GoogleMapAPIManager().getNearbyPlaces(
              context.read<HomeScreenProvider>().currentLocation!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.results!.length,
                itemBuilder: (context, index) {
                  final dist = calculateDistance(
                      context
                          .read<HomeScreenProvider>()
                          .currentLocation!
                          .latitude,
                      context
                          .read<HomeScreenProvider>()
                          .currentLocation!
                          .longitude,
                      snapshot.data!.results![index].lat!,
                      snapshot.data!.results![index].lng!);
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.location_on),
                        trailing: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.navigation,
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () async {
                          final String googleMapslocationUrl =
                              "https://www.google.com/maps/search/?api=1&query=${snapshot.data!.results![index].lat},${snapshot.data!.results![index].lng}";

                          final String encodedURl =
                              Uri.encodeFull(googleMapslocationUrl);

                          await launchUrl(Uri.parse(encodedURl));
                        },
                        title: Text(snapshot.data!.results![index].name!),
                        subtitle: Text('${dist.toString().substring(0, 4)} km'),
                      ),
                      const Divider()
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
