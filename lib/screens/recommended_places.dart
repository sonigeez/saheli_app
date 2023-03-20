import 'package:flutter/material.dart';
import 'package:saheli_app/model/google_nearby_model.dart';
import 'package:saheli_app/repo/google_map_api_manager.dart';

class RecommedndePlacesScreen extends StatefulWidget {
  const RecommedndePlacesScreen({super.key});

  @override
  State<RecommedndePlacesScreen> createState() =>
      _RecommedndePlacesScreenState();
}

class _RecommedndePlacesScreenState extends State<RecommedndePlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Recommended Places'),
        ),
        body: FutureBuilder<GoogleNearbyAPIModel?>(
          future: GoogleMapAPIManager().getNearbyPlaces(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.results!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data!.results![index].name!),
                    subtitle:
                        Text(snapshot.data!.results![index].lat.toString()),
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

class ReocommendTile extends StatefulWidget {
  const ReocommendTile({super.key});

  @override
  State<ReocommendTile> createState() => _ReocommendTileState();
}

class _ReocommendTileState extends State<ReocommendTile> {
  @override
  Widget build(BuildContext context) {
    return Text('');
  }
}
