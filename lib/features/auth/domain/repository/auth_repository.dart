
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:retrofit/dio.dart';

abstract class AuthRepository {
  
  Future<HttpResponse> register(AuthParams params);
  Future<HttpResponse> login(AuthParams params);
  Future<bool> isLoggedIn();
  Future<HttpResponse> getCurrentUser();
  Future<HttpResponse> logout();
  Future<HttpResponse> updateUsername(Map<String,dynamic> username);
}