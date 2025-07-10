import 'package:ams_messaging/config/constansts/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
  Future<bool> logout();
  Future<String?> getToken();
  Future<void> saveToken(String token);
} 


class AuthLocalServiceImpl extends AuthLocalService {

  final _tokenKey = AppConstants.prefsToken;
  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();


  @override
  Future<bool> isLoggedIn() async {
    final  sharedPreferences = await _prefs;
    var token = sharedPreferences.getString(_tokenKey);
    if (token  == null ){
      return false;
    } else {
      return true;
    }
  }
  
  @override
  Future<bool> logout() async {
    final  sharedPreferences = await _prefs;
    sharedPreferences.clear();
    return true;
  }

    @override
    Future<String?> getToken() async {
    final  sharedPreferences = await _prefs;
    return sharedPreferences.getString(_tokenKey);
  }

  @override
  Future<void> saveToken(String token) async {
    final  sharedPreferences = await _prefs;
    await sharedPreferences.setString(_tokenKey, 'Bearer $token');
  }
}
