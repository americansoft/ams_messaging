import 'dart:async';

import 'package:ams_messaging/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:ams_messaging/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:ams_messaging/features/auth/data/models/auth_model.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/service_locator.dart';
import 'package:retrofit/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepositoryImpl extends AuthRepository {

  
  @override
  Future<HttpResponse> register(AuthParams params) async {
   HttpResponse<AuthModel> response  = await serviceLocator<AuthApiService>().register(params);
   if (response.response.statusCode == 201) {
    String? token = response.data.data!.token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token!);
    } 
    return response;
  }

    @override
  Future<HttpResponse>login(AuthParams params) async {
    HttpResponse<AuthModel> response  = await serviceLocator<AuthApiService>().login(params);
     if (response.response.statusCode == 201) {
    String? token = response.data.data!.token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token!);
    } 
    return response;
  }
  
  @override
  Future<HttpResponse> getCurrentUser() async {
    String? token = await serviceLocator<AuthLocalService>().getToken();
    HttpResponse<AuthModel> response  = await serviceLocator<AuthApiService>().getCurrentUser(token!);
    return response;
  }
  

  @override
  Future<HttpResponse> updateUsername(Map<String,dynamic> username) {
    return serviceLocator<AuthApiService>().updateUsername(username);
  }
  
  @override
  Future<bool> isLoggedIn() {
    return serviceLocator<AuthApiService>().isLoggedIn();
  }
  
  @override
  Future<HttpResponse> logout() {
    //todo 
  }



}