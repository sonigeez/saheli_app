import 'package:auto_route/auto_route.dart';
import 'package:saheli_app/onboarding/screen/onboarding_screen.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: OnboardingScreen, initial: true),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
