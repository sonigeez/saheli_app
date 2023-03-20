import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saheli_app/model/nearme_user.dart';
import 'package:saheli_app/repo/network_manager.dart';
import 'package:saheli_app/repo/networking_urls.dart';
import 'package:saheli_app/utils/shared_pref.dart';

class LocationServices {
  static Future<bool> uploadLocation(LatLng loc) async {
    Response? response;
    try {
      response = await NetworkManager.dio.post(
        NetworkingUrls.location,
        data: {
          "lon": loc.longitude,
          "lat": loc.latitude,
        },
        options: Options(headers: {
          "Authorization": "Bearer ${SharedPreferencesHelper.storage.getString("authToken")}",
        }),
      );
    } catch (e) {
      debugPrint("Error: $e");
    }

    return response != null && response.statusCode.toString().substring(0, 1) == "2";
  }

  static Future<List<NearmeUser>?> getNearMe() async {
    List<NearmeUser>? users;
    try {
      final response = await NetworkManager.dio.get(
        NetworkingUrls.nearme,
        options: Options(headers: {
          "Authorization": "Bearer ${SharedPreferencesHelper.storage.getString("authToken")}",
        }),
      );

      debugPrint("Response: ${response.data}");

      if (response.statusCode.toString().substring(0, 1) == "2") {
        users = List.from(response.data['data'].map((e) => NearmeUser.fromJson(e)));
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return users;
  }

  static Future<bool> uploadShortNote(String shortDesc) async {
    Response? response;
    try {
      response = await NetworkManager.dio.post(
        NetworkingUrls.shortNote,
        data: {"shortDescription": shortDesc},
        options: Options(headers: {
          "Authorization": "Bearer ${SharedPreferencesHelper.storage.getString("authToken")}",
        }),
      );
    } catch (e) {
      debugPrint("Error: $e");
    }

    return response != null && response.statusCode.toString().substring(0, 1) == "2";
  }
}
