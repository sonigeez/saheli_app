import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:saheli_app/model/user_model.dart';
import 'package:saheli_app/repo/network_manager.dart';
import 'package:saheli_app/repo/networking_urls.dart';
import 'package:saheli_app/utils/shared_pref.dart';

class AuthServices {
  static Future<bool> sendOtp(
    String firstName,
    String lastName,
    String aadharNumber,
    String phoneNo,
  ) async {
    Response? response;

    try {
      response = await NetworkManager.dio.post(
        NetworkingUrls.signup,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'aadhar': aadharNumber,
          'phone': phoneNo,
        },
      );
    } catch (e) {
      debugPrint("error: $e");
    }

    return response != null && response.statusCode.toString().substring(0, 1) == "2";
  }

  static Future<UserModel?> verifyOtp(String otp, String phoneNo) async {
    UserModel? user;
    final response = await NetworkManager.dio.post(
      NetworkingUrls.verifyOtp,
      data: {
        "otp": otp,
        "phone": phoneNo,
      },
    );

    if (response.statusCode.toString().substring(0, 1) == "2") {
      user = UserModel.fromJson(response.data['user']);
      await SharedPreferencesHelper.storage.setString("authToken", response.data['token']);
      await SharedPreferencesHelper.storage.setString("username", user.username);
      await SharedPreferencesHelper.storage.setString("sudoName", user.sudoName);
      await SharedPreferencesHelper.storage.setString("name", user.name);
      await SharedPreferencesHelper.storage.setString("userId", user.id);
      SharedPreferencesHelper.storage.setBool("onboarded", true);
    }

    return user;
  }

  static Future<bool> sendLoginOtp(String phoneNumber) async {
    late final Response? response;
    try {
      response = await NetworkManager.dio.post(
        NetworkingUrls.loginOtp,
        data: {"phone": phoneNumber},
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return response != null && response.statusCode.toString().substring(0, 1) == "2";
  }

  static Future<bool> setAvailability(bool value) async {
    late final Response? response;
    try {
      debugPrint("api hit for outside");
      response = await NetworkManager.dio.post(
        NetworkingUrls.outside,
        data: {"outside": value},
        options: Options(headers: {
          "Authorization": "Bearer ${SharedPreferencesHelper.storage.getString("authToken")}",
        }),
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    debugPrint("${response?.data}");

    return response != null && response.statusCode.toString().substring(0, 1) == "2";
  }
}
