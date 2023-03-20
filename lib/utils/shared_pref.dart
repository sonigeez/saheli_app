import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late final SharedPreferences storage;

  static Future<void> init() async => storage = await SharedPreferences.getInstance();

  static Future<void> updateAuthToken(String authToken) async {
    await storage.setString("authToken", authToken);
  }

  static Future<bool> isOnboarded() async {
    final x = storage.getBool("onboarded");
    if (x != null && x) {
      return true;
    } else {
      // await storage.setBool("onboarded", true);
      return false;
    }
  }

  static bool isUserLoggedIn() {
    String? value = storage.getString("authToken");
    if (value != null && value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
