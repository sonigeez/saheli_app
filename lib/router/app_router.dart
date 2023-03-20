import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
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
            path: AppRoutes.destinationSelection),
      ],
    ),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}

class AppRoutes {
  static const root = '/';
  static const onboardingScreen = 'onboarding-screen';
  static const homeScreen = 'home-screen';
  static const destinationSelection = 'destination-selection';
}
