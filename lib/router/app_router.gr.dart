// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../screens/destination_selection_screen.dart' as _i3;
import '../screens/home_page.dart' as _i2;
import '../screens/onboarding_screen.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    OnboardingScreen.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.OnboardingScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    DestinationSelectionRoute.name: (routeData) {
      final args = routeData.argsAs<DestinationSelectionRouteArgs>(
          orElse: () => const DestinationSelectionRouteArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.DestinationSelectionPage(key: args.key),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          OnboardingScreen.name,
          path: '/',
        ),
        _i4.RouteConfig(
          HomeRoute.name,
          path: '/home-screen',
        ),
        _i4.RouteConfig(
          DestinationSelectionRoute.name,
          path: '/destination-selection',
        ),
      ];
}

/// generated route for
/// [_i1.OnboardingScreen]
class OnboardingScreen extends _i4.PageRouteInfo<void> {
  const OnboardingScreen()
      : super(
          OnboardingScreen.name,
          path: '/',
        );

  static const String name = 'OnboardingScreen';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home-screen',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.DestinationSelectionPage]
class DestinationSelectionRoute
    extends _i4.PageRouteInfo<DestinationSelectionRouteArgs> {
  DestinationSelectionRoute({_i5.Key? key})
      : super(
          DestinationSelectionRoute.name,
          path: '/destination-selection',
          args: DestinationSelectionRouteArgs(key: key),
        );

  static const String name = 'DestinationSelectionRoute';
}

class DestinationSelectionRouteArgs {
  const DestinationSelectionRouteArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'DestinationSelectionRouteArgs{key: $key}';
  }
}
