import 'package:auto_route/auto_route.dart';
import 'package:saheli_app/screens/home_page.dart';
import 'package:saheli_app/screens/onboarding_screen.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: OnboardingScreen, initial: true),
    MaterialRoute(page: HomePage, path: AppRoutes.homeScreen),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}

class AppRoutes {
  static const onboardingScreen = '/onboarding-screen';
  static const homeScreen = '/home-screen';
}
