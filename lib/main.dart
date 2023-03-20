import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:saheli_app/app.dart';
import 'package:saheli_app/notifiers/user_notifier.dart';
import 'package:saheli_app/router/app_router.gr.dart';
import 'package:saheli_app/utils/shared_pref.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:provider/provider.dart';
import 'notifiers/home_screen_provider.dart';

final appRouter = AppRouter();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final streamChatClient = StreamChatClient(
    Strings.streamChatApiKey,
    logLevel: Level.INFO,
  );

  await SharedPreferencesHelper.init();
  final onboarded = await SharedPreferencesHelper.isOnboarded();

  FlutterNativeSplash.remove();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => UserNotifier()),
      ],
      child: AppWidget(
        streamChatClient: streamChatClient,
        showOnBoard: !onboarded,
      ),
    ),
  );
}

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
    required this.streamChatClient,
    required this.showOnBoard,
  });
  final StreamChatClient streamChatClient;
  final bool showOnBoard;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.delegate(
        initialRoutes: [
          if (showOnBoard) const RootRouter(children: [OnboardRoute()]),
          if (!showOnBoard && SharedPreferencesHelper.isUserLoggedIn()) const RootRouter(children: [HomeRoute()]),
          if (!showOnBoard && !SharedPreferencesHelper.isUserLoggedIn()) const RootRouter(children: [LoginRoute()])
        ],
      ),
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
