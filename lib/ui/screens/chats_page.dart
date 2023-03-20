import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/app.dart';
import 'package:saheli_app/router/app_router.gr.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late final StreamChannelListController _channelListController;

  @override
  void initState() {
    super.initState();
    _channelListController = StreamChannelListController(
      client: context.streamChatClient,
      filter: Filter.in_('members', [context.currentUser!.id]),
      channelStateSort: const [SortOption('last_message_at')],
    );
  }

  @override
  void dispose() {
    _channelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _channelListController.refresh,
        child: StreamChannelListView(
          controller: _channelListController,
          onChannelTap: (channel) =>
              context.router.push(ChatScreenRoute(channel: channel)),
        ),
      ),
    );
  }
}
