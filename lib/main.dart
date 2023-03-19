import 'package:flutter/material.dart';
import 'package:saheli_app/app.dart';
import 'package:saheli_app/router/app_router.gr.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  final streamChatClient = StreamChatClient(
    Strings.streamChatApiKey,
    logLevel: Level.INFO,
  );

  await streamChatClient.connectUser(
    User(id: "ankit"),
    streamChatClient.devToken("ankit").rawValue,
  );

  runApp(AppWidget(
    streamChatClient: streamChatClient,
  ));
}

final appRouter = AppRouter();

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
    required this.streamChatClient,
  });
  final StreamChatClient streamChatClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      title: 'Flutter Demo',
      builder: (context, child) => StreamChat(
        client: streamChatClient,
        child: child,
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routerDelegate: AutoRouterDelegate(),
      // routeInformationParser: AutoRouteInformationParser(),
    );
  }
}
