import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class Strings {
  Strings._();

  static const String streamChatApiKey = "9c8j673rbmm2";
}

// extensions
extension StreamChatContext on BuildContext {
  StreamChatClient get streamChatClient => StreamChat.of(this).client;
  User? get currentUser => StreamChat.of(this).currentUser;
}

extension SizeContext on BuildContext {
  Size get getSize => MediaQuery.of(this).size;
}

class MyColors {
  MyColors._();

  static const Color primayColor = Color(0xFF0D92D5);
}

class StreamChatHelper {
  StreamChatHelper._();

  static String getChannelName(Channel channel, User currentUser) {
    if (channel.name != null) {
      return channel.name!;
    } else if (channel.state?.members.isNotEmpty ?? false) {
      final otherUser = channel.state!.members.firstWhere((element) => element.userId != currentUser.id);
      return otherUser.user!.name;
    } else {
      return "NA";
    }
  }
}
