/// All named routes used in the WhatsClone app
class AppRoutes {
  // 🔰 Root & Onboarding
  static const String splash = '/';
  static const String welcome = 'welcome';
  static const String home = 'home';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String profileSetup = '/profile-setup';

  // 💬 Chat & Messaging
  static const String chatList = '/chat-list';
  static const String chat = '/chat';
  static const String callScreen = '/call-screen';
  static const String mediaViewer = '/media-viewer';

  // 👥 Contacts & Groups
  static const String contactsPicker = '/contacts-picker';
  static const String contactsSync = '/contacts-sync';
  static const String createGroup = '/create-group';
  static const String groupInfo = '/group-info';

  // 📺 Status
  static const String status = '/status';
  static const String viewStatus = '/view-status';
  static const String statusEditor = '/status-editor';

  // 🔍 Search & Settings
  static const String search = '/search';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String accountSettings = '/account-settings';
  static const String privacySettings = '/privacy-settings';
  static const String securitySettings = '/security-settings';
  static const String changeNumber = '/change-number';
  static const String deleteAccount = '/delete-account';
  static const String chatSettings = '/chat-settings';
  static const String dataSettings = '/data-settings';
  static const String help = '/help';

  // 📞 Calls (optional future)
  static const String callLog = '/calls';
}
