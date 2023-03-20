import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/app.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    @pathParam this.channelId = "",
    this.channel,
  });
  final String channelId;
  final Channel? channel;

  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: channel ?? context.streamChatClient.channel('messaging', id: channelId),
      child: Scaffold(
        appBar: const StreamChannelHeader(),
        body: Column(
          children: const [
            Expanded(
              child: StreamMessageListView(),
            ),
            StreamMessageInput(),
          ],
        ),
      ),
    );
  }
}
