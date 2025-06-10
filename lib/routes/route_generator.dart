import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/auth/profile_setup_screen.dart';
import '../screens/chat/chat_list_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/chat/media_viewer_screen.dart';
import '../screens/contact/contact_picker_screen.dart';
import '../screens/contact/contact_sync_screen.dart';
import '../screens/group/create_group_screen.dart';
import '../screens/group/group_info_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/status/status_screen.dart';
import '../screens/status/view_status_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/otp':
        return MaterialPageRoute(builder: (_) => const OtpScreen());

      case '/profile-setup':
        return MaterialPageRoute(builder: (_) => const ProfileSetupScreen());

      case '/chat-list':
        return MaterialPageRoute(builder: (_) => const ChatListScreen());

      case '/chat':
        return MaterialPageRoute(builder: (_) => const ChatScreen());

      case '/media-viewer':
        return MaterialPageRoute(builder: (_) => const MediaViewerScreen());

      case '/contacts-picker':
        return MaterialPageRoute(builder: (_) => const ContactPickerScreen());

      case '/contacts-sync':
        return MaterialPageRoute(builder: (_) => const ContactSyncScreen());

      case '/create-group':
        return MaterialPageRoute(builder: (_) => const CreateGroupScreen());

      case '/group-info':
        return MaterialPageRoute(builder: (_) => const GroupInfoScreen());

      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case '/status':
        return MaterialPageRoute(builder: (_) => const StatusScreen());

      case '/view-status':
        return MaterialPageRoute(builder: (_) => const ViewStatusScreen());

      case '/notifications':
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
