import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:saheli_app/screens/live_location_travel.dart';
import 'package:saheli_app/screens/safe_place_screen.dart';
import 'package:saheli_app/ui/screens/chat_screen.dart';
import 'package:saheli_app/ui/screens/chats_page.dart';
import 'package:saheli_app/ui/screens/login_screen.dart';
import 'package:saheli_app/ui/screens/signup_screen.dart';
import 'package:saheli_app/screens/home_page.dart';
import 'package:saheli_app/screens/onboarding_screen.dart';

import '../screens/destination_selection_screen.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(
      page: EmptyRouterPage,
      path: AppRoutes.root,
      name: 'RootRouter',
      children: [
        AutoRoute(page: OnboardingScreen, initial: true),
        AutoRoute(page: HomePage, path: AppRoutes.homeScreen),
        AutoRoute(
          page: DestinationSelectionPage,
          path: AppRoutes.destinationSelection,
        ),
        AutoRoute(
          page: LoginScreen,
          path: AppRoutes.login,
          name: "LoginRoute",
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
        AutoRoute(
          page: SaheliTrackingPage,
          name: "SaheliTrackingRoute",
          path: AppRoutes.saheliTracking,
        ),
        AutoRoute(
          page: RecommedndePlacesScreen,
          name: "RecommendedPlacesRoute",
          path: AppRoutes.recommendedPlaces,
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
  static const onboardingScreen = 'onboarding-screen';
  static const homeScreen = 'home-screen';
  static const destinationSelection = 'destination-selection';
  static const String login = "login";
  static const String signup = "signup";
  static const String splashScreen = "splash";
  static const String chatScreen = "chat/:channelId";
  static const String chats = "chat_list";
  static const String saheliTracking = "saheli-tracking";
  static const String recommendedPlaces = "recommended-places";
}
