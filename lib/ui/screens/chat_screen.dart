import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/app.dart';
import 'package:saheli_app/router/app_router.gr.dart';
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
    final ch = channel ?? context.streamChatClient.channel('messaging', id: channelId);
    return StreamChannel(
      channel: ch,
      child: Scaffold(
        appBar: const StreamChannelHeader(),
        body: Column(
          children: [
            SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Get a recommended location on a walking distance"),
                    ElevatedButton(
                      onPressed: () => context.pushRoute(RecommendedPlacesRoute(channel: ch)),
                      child: const Text("Yeah Sure!"),
                    ),
                  ],
                )),
            const Expanded(
              child: StreamMessageListView(),
            ),
            const StreamMessageInput(),
          ],
        ),
      ),
    );
  }
}
