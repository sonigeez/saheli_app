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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:auto_route/empty_router_widgets.dart' as _i1;
import 'package:flutter/material.dart' as _i10;
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as _i11;

import '../screens/destination_selection_screen.dart' as _i4;
import '../screens/home_page.dart' as _i3;
import '../screens/onboarding_screen.dart' as _i2;
import '../ui/screens/chat_screen.dart' as _i8;
import '../ui/screens/chats_page.dart' as _i7;
import '../ui/screens/login_screen.dart' as _i5;
import '../ui/screens/signup_screen.dart' as _i6;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    RootRouter.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    OnboardingScreen.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.OnboardingScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    DestinationSelectionRoute.name: (routeData) {
      final args = routeData.argsAs<DestinationSelectionRouteArgs>(
          orElse: () => const DestinationSelectionRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.DestinationSelectionPage(key: args.key),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.LoginScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SignupScreen(),
      );
    },
    ChatListScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.ChatsPage(),
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
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.ChatScreen(
          key: args.key,
          channelId: args.channelId,
          channel: args.channel,
        ),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          RootRouter.name,
          path: '/',
          children: [
            _i9.RouteConfig(
              OnboardingScreen.name,
              path: '',
              parent: RootRouter.name,
            ),
            _i9.RouteConfig(
              HomeRoute.name,
              path: 'home-screen',
              parent: RootRouter.name,
            ),
            _i9.RouteConfig(
              DestinationSelectionRoute.name,
              path: 'destination-selection',
              parent: RootRouter.name,
            ),
            _i9.RouteConfig(
              LoginRoute.name,
              path: 'login',
              parent: RootRouter.name,
            ),
            _i9.RouteConfig(
              SignupRoute.name,
              path: 'signup',
              parent: RootRouter.name,
            ),
            _i9.RouteConfig(
              ChatListScreenRoute.name,
              path: 'chat_list',
              parent: RootRouter.name,
            ),
            _i9.RouteConfig(
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
class RootRouter extends _i9.PageRouteInfo<void> {
  const RootRouter({List<_i9.PageRouteInfo>? children})
      : super(
          RootRouter.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'RootRouter';
}

/// generated route for
/// [_i2.OnboardingScreen]
class OnboardingScreen extends _i9.PageRouteInfo<void> {
  const OnboardingScreen()
      : super(
          OnboardingScreen.name,
          path: '',
        );

  static const String name = 'OnboardingScreen';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-screen',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.DestinationSelectionPage]
class DestinationSelectionRoute
    extends _i9.PageRouteInfo<DestinationSelectionRouteArgs> {
  DestinationSelectionRoute({_i10.Key? key})
      : super(
          DestinationSelectionRoute.name,
          path: 'destination-selection',
          args: DestinationSelectionRouteArgs(key: key),
        );

  static const String name = 'DestinationSelectionRoute';
}

class DestinationSelectionRouteArgs {
  const DestinationSelectionRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'DestinationSelectionRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i6.SignupScreen]
class SignupRoute extends _i9.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: 'signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i7.ChatsPage]
class ChatListScreenRoute extends _i9.PageRouteInfo<void> {
  const ChatListScreenRoute()
      : super(
          ChatListScreenRoute.name,
          path: 'chat_list',
        );

  static const String name = 'ChatListScreenRoute';
}

/// generated route for
/// [_i8.ChatScreen]
class ChatScreenRoute extends _i9.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute({
    _i10.Key? key,
    String channelId = "",
    _i11.Channel? channel,
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

  final _i10.Key? key;

  final String channelId;

  final _i11.Channel? channel;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, channelId: $channelId, channel: $channel}';
  }
}
