
import 'dart:io';

import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';

abstract class AuthRepository {
  
  Future<HttpResult> register(AuthParams params);
  Future<HttpResult> login(AuthParams params);
  Future<HttpResult> getCurrentUser();
  Future<bool> logout();
  Future<HttpResult> updateUsername(String username);
  Future<HttpResult> uploadProfileImage(File image);
}