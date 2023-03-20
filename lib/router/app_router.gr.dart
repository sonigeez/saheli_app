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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:auto_route/empty_router_widgets.dart' as _i1;
import 'package:flutter/material.dart' as _i7;
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as _i8;

import '../ui/screens/chat_screen.dart' as _i5;
import '../ui/screens/chats_page.dart' as _i4;
import '../ui/screens/login_screen.dart' as _i2;
import '../ui/screens/signup_screen.dart' as _i3;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    RootRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignupScreen(),
      );
    },
    ChatListScreenRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.ChatsPage(),
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
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.ChatScreen(
          key: args.key,
          channelId: args.channelId,
          channel: args.channel,
        ),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          RootRouter.name,
          path: '/',
          children: [
            _i6.RouteConfig(
              '#redirect',
              path: '',
              parent: RootRouter.name,
              redirectTo: 'login',
              fullMatch: true,
            ),
            _i6.RouteConfig(
              LoginRoute.name,
              path: 'login',
              parent: RootRouter.name,
            ),
            _i6.RouteConfig(
              SignupRoute.name,
              path: 'signup',
              parent: RootRouter.name,
            ),
            _i6.RouteConfig(
              ChatListScreenRoute.name,
              path: 'chat_list',
              parent: RootRouter.name,
            ),
            _i6.RouteConfig(
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
class RootRouter extends _i6.PageRouteInfo<void> {
  const RootRouter({List<_i6.PageRouteInfo>? children})
      : super(
          RootRouter.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'RootRouter';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.SignupScreen]
class SignupRoute extends _i6.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: 'signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i4.ChatsPage]
class ChatListScreenRoute extends _i6.PageRouteInfo<void> {
  const ChatListScreenRoute()
      : super(
          ChatListScreenRoute.name,
          path: 'chat_list',
        );

  static const String name = 'ChatListScreenRoute';
}

/// generated route for
/// [_i5.ChatScreen]
class ChatScreenRoute extends _i6.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute({
    _i7.Key? key,
    String channelId = "",
    _i8.Channel? channel,
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

  final _i7.Key? key;

  final String channelId;

  final _i8.Channel? channel;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, channelId: $channelId, channel: $channel}';
  }
}
