// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../notifiers/home_screen_provider.dart';

const kGoogleApiKey = 'AIzaSyBPbqIkJ2zzLtlOW12omt67Puy845O5oBA';

class DestinationSelectionPage extends PlacesAutocompleteWidget {
  DestinationSelectionPage({Key? key})
      : super(
          key: key,
          apiKey: kGoogleApiKey,
          sessionToken: const Uuid().v4(),
        );

  @override
  CustomSearchScaffoldState createState() => CustomSearchScaffoldState();
}

class CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarPlacesAutoCompleteTextField(
          textStyle: null,
          textDecoration: null,
          cursorColor: null,
        ),
      ),
      body: PlacesAutocompleteResult(
        onTap: (p) async {
          // ignore: unnecessary_null_comparison
          if (p == null) {
            return;
          }

          // get detail (lat/lng)
          final places = GoogleMapsPlaces(
            apiKey: kGoogleApiKey,
            apiHeaders: await const GoogleApiHeaders().getHeaders(),
          );

          final detail = await places.getDetailsByPlaceId(p.placeId!);
          final geometry = detail.result.geometry!;

          context.read<HomeScreenProvider>().setDestinationLocation(
              LatLng(geometry.location.lat, geometry.location.lng));
          context
              .read<HomeScreenProvider>()
              .addMarker(LatLng(geometry.location.lat, geometry.location.lng));
          context
              .read<HomeScreenProvider>()
              .setDestinationAddress(p.description!);
          context.router.pop();
        },
        logo: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [],
        ),
        // ignore: deprecated_member_use
      ),
    );
  }

  @override
  void onResponseError(PlacesAutocompleteResponse res) {
    super.onResponseError(res);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res.errorMessage ?? 'Unknown error')),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse res) {
    super.onResponse(res);

    if (res.predictions.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Got answer')),
      );
    }
  }
}
