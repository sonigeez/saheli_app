import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.channel,
  });
  final Channel channel;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // setup channel with client

  @override
  void initState() {
    super.initState();
    // channel setup
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: widget.channel,
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
