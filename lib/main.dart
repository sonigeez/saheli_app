import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:saheli_app/app.dart';
import 'package:saheli_app/router/app_router.gr.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:provider/provider.dart';
import 'notifiers/home_screen_provider.dart';
import 'notifiers/saheli_tracking_page.dart';

final appRouter = AppRouter();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final streamChatClient = StreamChatClient(
    Strings.streamChatApiKey,
    logLevel: Level.INFO,
  );

  FlutterNativeSplash.remove();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SaheliTrackingPageNotifier(),
        ),
      ],
      child: AppWidget(
        streamChatClient: streamChatClient,
      )));
}

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
    );
  }
}
