
import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:retrofit/dio.dart';

abstract class AuthRepository {
  
  Future<HttpResult> register(AuthParams params);
  Future<HttpResponse> login(AuthParams params);
  Future<bool> isLoggedIn();
  Future<HttpResponse> getCurrentUser();
  Future<bool> logout();
  Future<HttpResult> updateUsername(String username);
}