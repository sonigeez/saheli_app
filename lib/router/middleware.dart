import 'package:auto_route/auto_route.dart';
import 'package:saheli_app/notifiers/auth_notifier.dart';

class AuthGuard extends AutoRedirectGuard {
  final AuthNotifier authNotifier;

  AuthGuard(this.authNotifier) {
    authNotifier.addListener(() {
      if (!authNotifier.authenticated) {
        reevaluate();
      }
    });
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authNotifier.authenticated) {
      return resolver.next();
    } else {
      // navigate to login screen.
    }
  }

  @override
  Future<bool> canNavigate(RouteMatch route) async => true;
}
