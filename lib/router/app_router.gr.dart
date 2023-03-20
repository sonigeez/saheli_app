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
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:auto_route/empty_router_widgets.dart' as _i1;
import 'package:flutter/material.dart' as _i12;
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as _i13;

import '../screens/destination_selection_screen.dart' as _i5;
import '../screens/home_page.dart' as _i4;
import '../screens/onboarding_screen.dart' as _i2;
import '../ui/screens/chat_screen.dart' as _i10;
import '../ui/screens/chats_page.dart' as _i9;
import '../ui/screens/login_screen.dart' as _i6;
import '../ui/screens/nearby_users_list.dart' as _i7;
import '../ui/screens/otp_verification_screen.dart' as _i3;
import '../ui/screens/signup_screen.dart' as _i8;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    RootRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    OnboardRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.OnboardingScreen(),
      );
    },
    PinCodeVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<PinCodeVerificationRouteArgs>(
          orElse: () => const PinCodeVerificationRouteArgs());
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.PinCodeVerificationScreen(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    DestinationSelectionRoute.name: (routeData) {
      final args = routeData.argsAs<DestinationSelectionRouteArgs>(
          orElse: () => const DestinationSelectionRouteArgs());
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.DestinationSelectionPage(key: args.key),
      );
    },
    LoginRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.LoginScreen(),
      );
    },
    NearmeusersRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.NearbyUsersList(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.SignupScreen(),
      );
    },
    ChatListScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
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
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.ChatScreen(
          key: args.key,
          channelId: args.channelId,
          channel: args.channel,
        ),
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          RootRouter.name,
          path: '/',
          children: [
            _i11.RouteConfig(
              OnboardRoute.name,
              path: 'onboarding-screen',
              parent: RootRouter.name,
            ),
            _i11.RouteConfig(
              PinCodeVerificationRoute.name,
              path: 'otp-verification',
              parent: RootRouter.name,
            ),
            _i11.RouteConfig(
              HomeRoute.name,
              path: 'home-screen',
              parent: RootRouter.name,
            ),
            _i11.RouteConfig(
              DestinationSelectionRoute.name,
              path: 'destination-selection',
              parent: RootRouter.name,
            ),
            _i11.RouteConfig(
              LoginRoute.name,
              path: 'login',
              parent: RootRouter.name,
            ),
            _i11.RouteConfig(
              NearmeusersRoute.name,
              path: 'nearme',
              parent: RootRouter.name,
            ),
            _i11.RouteConfig(
              SignupRoute.name,
              path: 'signup',
              parent: RootRouter.name,
            ),
            _i11.RouteConfig(
              ChatListScreenRoute.name,
              path: 'chat_list',
              parent: RootRouter.name,
            ),
            _i11.RouteConfig(
              ChatScreenRoute.name,
              path: 'chat/:channelId',
              parent: RootRouter.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class RootRouter extends _i11.PageRouteInfo<void> {
  const RootRouter({List<_i11.PageRouteInfo>? children})
      : super(
          RootRouter.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'RootRouter';
}

/// generated route for
/// [_i2.OnboardingScreen]
class OnboardRoute extends _i11.PageRouteInfo<void> {
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
    extends _i11.PageRouteInfo<PinCodeVerificationRouteArgs> {
  PinCodeVerificationRoute({
    _i12.Key? key,
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

  final _i12.Key? key;

  final String? phoneNumber;

  @override
  String toString() {
    return 'PinCodeVerificationRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
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
    extends _i11.PageRouteInfo<DestinationSelectionRouteArgs> {
  DestinationSelectionRoute({_i12.Key? key})
      : super(
          DestinationSelectionRoute.name,
          path: 'destination-selection',
          args: DestinationSelectionRouteArgs(key: key),
        );

  static const String name = 'DestinationSelectionRoute';
}

class DestinationSelectionRouteArgs {
  const DestinationSelectionRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'DestinationSelectionRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i7.NearbyUsersList]
class NearmeusersRoute extends _i11.PageRouteInfo<void> {
  const NearmeusersRoute()
      : super(
          NearmeusersRoute.name,
          path: 'nearme',
        );

  static const String name = 'NearmeusersRoute';
}

/// generated route for
/// [_i8.SignupScreen]
class SignupRoute extends _i11.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: 'signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i9.ChatsPage]
class ChatListScreenRoute extends _i11.PageRouteInfo<void> {
  const ChatListScreenRoute()
      : super(
          ChatListScreenRoute.name,
          path: 'chat_list',
        );

  static const String name = 'ChatListScreenRoute';
}

/// generated route for
/// [_i10.ChatScreen]
class ChatScreenRoute extends _i11.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute({
    _i12.Key? key,
    String channelId = "",
    _i13.Channel? channel,
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

  final _i12.Key? key;

  final String channelId;

  final _i13.Channel? channel;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, channelId: $channelId, channel: $channel}';
  }
}
