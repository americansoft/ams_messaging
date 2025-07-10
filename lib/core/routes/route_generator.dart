import 'package:ams_messaging/config/constansts/app_routes.dart';
import 'package:ams_messaging/features/auth/presentation/pages/welcome_screen.dart';
import 'package:ams_messaging/features/auth/presentation/pages/profile_setup_screen.dart';
import 'package:flutter/material.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:

      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case AppRoutes.profileSetup:
        return MaterialPageRoute(builder: (_) => const ProfileSetupScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('Error: Route not found!')),
        ));
  }
}
