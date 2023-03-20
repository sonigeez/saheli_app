import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:saheli_app/ui/screens/chat_screen.dart';
import 'package:saheli_app/ui/screens/chats_page.dart';
import 'package:saheli_app/ui/screens/login_screen.dart';
import 'package:saheli_app/ui/screens/signup_screen.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(
      page: EmptyRouterPage,
      path: AppRoutes.root,
      name: "RootRouter",
      children: [
        AutoRoute(
          page: LoginScreen,
          path: AppRoutes.login,
          name: "LoginRoute",
          initial: true,
        ),
        AutoRoute(
          page: SignupScreen,
          path: AppRoutes.signup,
          name: "SignupRoute",
        ),
        AutoRoute(
          page: ChatsPage,
          path: AppRoutes.chats,
          name: "ChatListScreenRoute",
        ),
        AutoRoute(
          page: ChatScreen,
          name: "ChatScreenRoute",
          path: AppRoutes.chatScreen,
        ),
      ],
    ),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}

class AppRoutes {
  AppRoutes._();

  static const String root = "/";
  static const String login = "login";
  static const String signup = "signup";
  static const String splashScreen = "splash";
  static const String chatScreen = "chat/:channelId";
  static const String chats = "chat_list";
}
