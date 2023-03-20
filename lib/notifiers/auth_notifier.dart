import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  bool _autheticated = false;

  bool get authenticated => _autheticated;

  set setAuth(bool value) {
    _autheticated = value;
    notifyListeners();
  }
}
