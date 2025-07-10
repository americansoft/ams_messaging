import 'package:ams_messaging/config/constansts/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FriendshipLocalService {
  Future<String?> getToken();
} 


class FriendshipLocalServiceImpl extends FriendshipLocalService {

  final _tokenKey = AppConstants.prefsToken;
  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

    @override
    Future<String?> getToken() async {
    final  sharedPreferences = await _prefs;
    return sharedPreferences.getString(_tokenKey);
  }
}
