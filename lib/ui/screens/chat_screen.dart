import 'package:flutter/material.dart';
import 'package:saheli_app/app.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  // setup channel with client
  late final StreamChatClient _streamChatClient;
  late final Channel _channel;

  late final Future<ChannelState> _state;

  @override
  void initState() {
    super.initState();
    _streamChatClient = context.streamChatClient;
    // channel setup
    _channel = _streamChatClient.channel('messaging',id: "hackathonChat",extraData: {
      "members": [
        context.currentUser!.id,
        // other user chat
      ],
    });

    _state = _channel.watch();
  }

  @override
  void dispose() {
    _channel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StreamChannelHeader(),
      body: StreamChannel(
        channel: _channel,
        child: Column(
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
