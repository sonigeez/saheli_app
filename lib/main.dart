import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notifiers/home_screen_provider.dart';
import 'router/app_router.gr.dart';

final appRouter = AppRouter();

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
  ], child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      // builder: (context, router) => router!,
    );
  }
}
