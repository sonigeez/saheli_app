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
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:auto_route/empty_router_widgets.dart' as _i1;
import 'package:flutter/material.dart' as _i14;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i16;
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as _i15;

import '../screens/destination_selection_screen.dart' as _i5;
import '../screens/home_page.dart' as _i4;
import '../screens/live_location_travel.dart' as _i11;
import '../screens/onboarding_screen.dart' as _i2;
import '../screens/safe_place_screen.dart' as _i12;
import '../ui/screens/chat_screen.dart' as _i10;
import '../ui/screens/chats_page.dart' as _i9;
import '../ui/screens/login_screen.dart' as _i6;
import '../ui/screens/nearby_users_list.dart' as _i7;
import '../ui/screens/otp_verification_screen.dart' as _i3;
import '../ui/screens/signup_screen.dart' as _i8;

class AppRouter extends _i13.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    RootRouter.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    OnboardRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.OnboardingScreen(),
      );
    },
    PinCodeVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<PinCodeVerificationRouteArgs>(
          orElse: () => const PinCodeVerificationRouteArgs());
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.PinCodeVerificationScreen(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    DestinationSelectionRoute.name: (routeData) {
      final args = routeData.argsAs<DestinationSelectionRouteArgs>(
          orElse: () => const DestinationSelectionRouteArgs());
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.DestinationSelectionPage(key: args.key),
      );
    },
    LoginRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.LoginScreen(),
      );
    },
    NearmeusersRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.NearbyUsersList(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.SignupScreen(),
      );
    },
    ChatListScreenRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ChatsPage(),
      );
    },
    ChatScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatScreenRouteArgs>(
          orElse: () => ChatScreenRouteArgs(
                  channelId: pathParams.getString(
                'channelId',
                "",
              )));
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.ChatScreen(
          key: args.key,
          channelId: args.channelId,
          channel: args.channel,
        ),
      );
    },
    SaheliTrackingRoute.name: (routeData) {
      final args = routeData.argsAs<SaheliTrackingRouteArgs>();
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.SaheliTrackingPage(
          key: args.key,
          destinationLocation: args.destinationLocation,
          sourceLocation: args.sourceLocation,
        ),
      );
    },
    RecommendedPlacesRoute.name: (routeData) {
      final args = routeData.argsAs<RecommendedPlacesRouteArgs>();
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.RecommedndePlacesScreen(
          key: args.key,
          channel: args.channel,
        ),
      );
    },
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(
          RootRouter.name,
          path: '/',
          children: [
            _i13.RouteConfig(
              OnboardRoute.name,
              path: 'onboarding-screen',
              parent: RootRouter.name,
            ),
            _i13.RouteConfig(
              PinCodeVerificationRoute.name,
              path: 'otp-verification',
              parent: RootRouter.name,
            ),
            _i13.RouteConfig(
              HomeRoute.name,
              path: 'home-screen',
              parent: RootRouter.name,
            ),
            _i13.RouteConfig(
              DestinationSelectionRoute.name,
              path: 'destination-selection',
              parent: RootRouter.name,
            ),
            _i13.RouteConfig(
              LoginRoute.name,
              path: 'login',
              parent: RootRouter.name,
            ),
            _i13.RouteConfig(
              NearmeusersRoute.name,
              path: 'nearme',
              parent: RootRouter.name,
            ),
            _i13.RouteConfig(
              SignupRoute.name,
              path: 'signup',
              parent: RootRouter.name,
            ),
            _i13.RouteConfig(
              ChatListScreenRoute.name,
              path: 'chat_list',
              parent: RootRouter.name,
            ),
            _i13.RouteConfig(
              ChatScreenRoute.name,
              path: 'chat/:channelId',
              parent: RootRouter.name,
            ),
            _i13.RouteConfig(
              SaheliTrackingRoute.name,
              path: 'saheli-tracking',
              parent: RootRouter.name,
            ),
            _i13.RouteConfig(
              RecommendedPlacesRoute.name,
              path: 'recommended-places',
              parent: RootRouter.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class RootRouter extends _i13.PageRouteInfo<void> {
  const RootRouter({List<_i13.PageRouteInfo>? children})
      : super(
          RootRouter.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'RootRouter';
}

/// generated route for
/// [_i2.OnboardingScreen]
class OnboardRoute extends _i13.PageRouteInfo<void> {
  const OnboardRoute()
      : super(
          OnboardRoute.name,
          path: 'onboarding-screen',
        );

  static const String name = 'OnboardRoute';
}

/// generated route for
/// [_i3.PinCodeVerificationScreen]
class PinCodeVerificationRoute
    extends _i13.PageRouteInfo<PinCodeVerificationRouteArgs> {
  PinCodeVerificationRoute({
    _i14.Key? key,
    String? phoneNumber,
  }) : super(
          PinCodeVerificationRoute.name,
          path: 'otp-verification',
          args: PinCodeVerificationRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
        );

  static const String name = 'PinCodeVerificationRoute';
}

class PinCodeVerificationRouteArgs {
  const PinCodeVerificationRouteArgs({
    this.key,
    this.phoneNumber,
  });

  final _i14.Key? key;

  final String? phoneNumber;

  @override
  String toString() {
    return 'PinCodeVerificationRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-screen',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.DestinationSelectionPage]
class DestinationSelectionRoute
    extends _i13.PageRouteInfo<DestinationSelectionRouteArgs> {
  DestinationSelectionRoute({_i14.Key? key})
      : super(
          DestinationSelectionRoute.name,
          path: 'destination-selection',
          args: DestinationSelectionRouteArgs(key: key),
        );

  static const String name = 'DestinationSelectionRoute';
}

class DestinationSelectionRouteArgs {
  const DestinationSelectionRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'DestinationSelectionRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i7.NearbyUsersList]
class NearmeusersRoute extends _i13.PageRouteInfo<void> {
  const NearmeusersRoute()
      : super(
          NearmeusersRoute.name,
          path: 'nearme',
        );

  static const String name = 'NearmeusersRoute';
}

/// generated route for
/// [_i8.SignupScreen]
class SignupRoute extends _i13.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: 'signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i9.ChatsPage]
class ChatListScreenRoute extends _i13.PageRouteInfo<void> {
  const ChatListScreenRoute()
      : super(
          ChatListScreenRoute.name,
          path: 'chat_list',
        );

  static const String name = 'ChatListScreenRoute';
}

/// generated route for
/// [_i10.ChatScreen]
class ChatScreenRoute extends _i13.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute({
    _i14.Key? key,
    String channelId = "",
    _i15.Channel? channel,
  }) : super(
          ChatScreenRoute.name,
          path: 'chat/:channelId',
          args: ChatScreenRouteArgs(
            key: key,
            channelId: channelId,
            channel: channel,
          ),
          rawPathParams: {'channelId': channelId},
        );

  static const String name = 'ChatScreenRoute';
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs({
    this.key,
    this.channelId = "",
    this.channel,
  });

  final _i14.Key? key;

  final String channelId;

  final _i15.Channel? channel;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, channelId: $channelId, channel: $channel}';
  }
}

/// generated route for
/// [_i11.SaheliTrackingPage]
class SaheliTrackingRoute extends _i13.PageRouteInfo<SaheliTrackingRouteArgs> {
  SaheliTrackingRoute({
    _i14.Key? key,
    required _i16.LatLng destinationLocation,
    required _i16.LatLng sourceLocation,
  }) : super(
          SaheliTrackingRoute.name,
          path: 'saheli-tracking',
          args: SaheliTrackingRouteArgs(
            key: key,
            destinationLocation: destinationLocation,
            sourceLocation: sourceLocation,
          ),
        );

  static const String name = 'SaheliTrackingRoute';
}

class SaheliTrackingRouteArgs {
  const SaheliTrackingRouteArgs({
    this.key,
    required this.destinationLocation,
    required this.sourceLocation,
  });

  final _i14.Key? key;

  final _i16.LatLng destinationLocation;

  final _i16.LatLng sourceLocation;

  @override
  String toString() {
    return 'SaheliTrackingRouteArgs{key: $key, destinationLocation: $destinationLocation, sourceLocation: $sourceLocation}';
  }
}

/// generated route for
/// [_i12.RecommedndePlacesScreen]
class RecommendedPlacesRoute
    extends _i13.PageRouteInfo<RecommendedPlacesRouteArgs> {
  RecommendedPlacesRoute({
    _i14.Key? key,
    required _i15.Channel channel,
  }) : super(
          RecommendedPlacesRoute.name,
          path: 'recommended-places',
          args: RecommendedPlacesRouteArgs(
            key: key,
            channel: channel,
          ),
        );

  static const String name = 'RecommendedPlacesRoute';
}

class RecommendedPlacesRouteArgs {
  const RecommendedPlacesRouteArgs({
    this.key,
    required this.channel,
  });

  final _i14.Key? key;

  final _i15.Channel channel;

  @override
  String toString() {
    return 'RecommendedPlacesRouteArgs{key: $key, channel: $channel}';
  }
}
