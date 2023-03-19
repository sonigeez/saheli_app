import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppWidget());
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
      // routerDelegate: AutoRouterDelegate(),
      // routeInformationParser: AutoRouteInformationParser(),
    );
  }
}
