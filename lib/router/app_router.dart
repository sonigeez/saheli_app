import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:saheli_app/ui/screens/chat_screen.dart';
import 'package:saheli_app/ui/screens/chats_page.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(
      page: EmptyRouterPage,
      path: AppRoutes.root,
      name: "RootRouter",
      children: [
        AutoRoute(
          page: ChatsPage,
          path: AppRoutes.chats,
          initial: true,
        ),
        AutoRoute(
          page: ChatScreen,
          name: "chat",
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
  static const String onboarding = 'onboard';
  static const String home = "home";
  static const String login = "login";
  static const String signup = "signup";
  static const String chatScreen = "chat";
  static const String chats = "chats";
}
