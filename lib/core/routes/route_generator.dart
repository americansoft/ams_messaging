import 'package:ams_messaging/config/constansts/app_routes.dart';
import 'package:ams_messaging/features/auth/presentation/pages/welcome_screen.dart';
import 'package:ams_messaging/features/auth/presentation/pages/profile_setup_screen.dart';
import 'package:flutter/material.dart';
import '../../screens/chat/media_viewer_screen.dart';
import '../../screens/contact/contact_picker_screen.dart';
import '../../screens/contact/contact_sync_screen.dart';
import '../../screens/group/create_group_screen.dart';
import '../../screens/group/group_info_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/search/search_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/status/status_screen.dart';
import '../../screens/status/view_status_screen.dart';
import '../../screens/notifications_screen.dart';
import '../../screens/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.profileSetup:
        return MaterialPageRoute(builder: (_) => const ProfileSetupScreen());

      case AppRoutes.mediaViewer:
        return MaterialPageRoute(builder: (_) => const MediaViewerScreen());

      case AppRoutes.contactsPicker:
        return MaterialPageRoute(builder: (_) => const ContactPickerScreen());

      case AppRoutes.contactsSync:
        return MaterialPageRoute(builder: (_) => const ContactSyncScreen());

      case AppRoutes.createGroup:
        return MaterialPageRoute(builder: (_) => const CreateGroupScreen());

      case AppRoutes.groupInfo:
        return MaterialPageRoute(builder: (_) => const GroupInfoScreen());

      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case AppRoutes.status:
        return MaterialPageRoute(builder: (_) => const StatusScreen());

      case AppRoutes.viewStatus:
        return MaterialPageRoute(builder: (_) => const ViewStatusScreen());

      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

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
