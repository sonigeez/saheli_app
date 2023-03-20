import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saheli_app/model/google_nearby_model.dart';

class GoogleMapAPIManager {
  Dio dio = Dio();

  Future<GoogleNearbyAPIModel?> getNearbyPlaces(LatLng initial) async {
    GoogleNearbyAPIModel? nearbyPlaces;
    try {
      Response response = await dio.get(
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyBPbqIkJ2zzLtlOW12omt67Puy845O5oBA&location=${initial.latitude}%2C${initial.longitude}&type=park|hospital|library|bank|cafe|police|restaurant|restaurant|store|landmark|locality&rankby=distance');
      print(response.data);
      nearbyPlaces = GoogleNearbyAPIModel.fromJson(response.data);
      return nearbyPlaces;
    } catch (e) {
      print(e.toString());
      return nearbyPlaces;
    }
  }

  Future<String?> getTime(
      {required LatLng latLng, required LatLng initial}) async {
    String? time;
    try {
      Response response = await dio.get(
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          'https://maps.googleapis.com/maps/api/distancematrix/json?&origins=${initial.latitude}%2C${initial.longitude}&destinations=${latLng.latitude}%2C${latLng.longitude}&key=AIzaSyBPbqIkJ2zzLtlOW12omt67Puy845O5oBA');
      print(response.data);
      time = response.data['rows'][0]['elements'][0]['duration']['text'];
      return time;
    } catch (e) {
      print(e.toString());
      return time;
    }
  }
}
