
/// App-wide constant strings, keys, sizes, and collection names
class AppConstants {
  // App Info
  static const String appName = 'WhatsClone';

  // Firebase Collection Names
  static const String usersCollection = 'users';
  static const String chatsCollection = 'chats';
  static const String messagesSubCollection = 'messages';
  static const String groupsCollection = 'groups';
  static const String statusesCollection = 'statuses';
  static const String contactsCollection = 'contacts';
  static const String blockedUsersCollection = 'blockedUsers';

  // SharedPreferences Keys
  static const String prefsUserId = 'prefs_user_id';
  static const String prefsIsLoggedIn = 'prefs_logged_in';
  static const String prefsToken = 'token';

  // UI Spacing
  static const double defaultPadding = 16.0;
  static const double avatarRadius = 24.0;

  // Durations
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration messageAnimationDuration = Duration(milliseconds: 300);

  // Placeholder image
  static const String defaultAvatarUrl =
      'https://via.placeholder.com/150/cccccc/808080?Text=User';
}



