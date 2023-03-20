import 'package:flutter/material.dart';
import 'package:saheli_app/services/auth_services.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class UserNotifier extends ChangeNotifier {
  bool _sendingOtp = false;
  bool get sendingOtp => _sendingOtp;
  bool _verifyingOtp = false;
  bool get verifyingOtp => _verifyingOtp;
  bool _connectingStreamUser = false;
  bool get connectingStreamUser => _connectingStreamUser;
  bool _errorr = false;
  bool get errorr => _errorr;

  void connectStreamUser(User user, StreamChatClient client) async {
    setStreamUser(true, false);
    await client.connectUser(user, client.devToken(user.id).rawValue);
    setStreamUser(false, true);
  }

  setStreamUser(bool value, bool notify) {
    _connectingStreamUser = value;
    if (notify) {
      notifyListeners();
    }
  }

  setSendingOtpLoading(bool value) {
    _sendingOtp = value;
    notifyListeners();
  }

  setVerifyingOtp(bool value) {
    _verifyingOtp = value;
    notifyListeners();
  }

  Future<bool> sendOtp(
    String firstName,
    String lastName,
    String aadharNumber,
    String phoneNo,
  ) async {
    _errorr = false;
    setSendingOtpLoading(true);
    final x = await AuthServices.sendOtp(
      firstName,
      lastName,
      aadharNumber,
      phoneNo,
    );
    if (!x) {
      // error;
      _errorr = true;
    }
    setSendingOtpLoading(false);
    return x;
  }

  Future<bool> sendLoginOtp(String phoneNumber) async {
    setSendingOtpLoading(true);
    final x = await AuthServices.sendLoginOtp(phoneNumber);
    setSendingOtpLoading(false);
    return x;
  }
}
