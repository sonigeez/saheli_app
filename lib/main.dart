import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'router/app_router.gr.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
