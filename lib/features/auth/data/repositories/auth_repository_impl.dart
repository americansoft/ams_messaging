import 'dart:async';

import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:ams_messaging/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:ams_messaging/features/auth/data/models/auth_model.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepositoryImpl extends AuthRepository {

  
  @override
  Future<HttpResult<AuthModel>> register(AuthParams params) async {
    try {
         HttpResponse<AuthModel> response  = await serviceLocator<AuthApiService>().register(params);
         String? token = response.data.data!.token;
         SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
         sharedPreferences.setString('token', token!);
         return ResultSuccess(response.data);
    } on DioException catch(e){
      return ResultError(e);
    }
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
  Future<HttpResult> updateUsername(String username) async {
    String? token = await serviceLocator.get<AuthLocalService>().getToken();
    if(token != null){
      try {
        final res = await serviceLocator.get<AuthApiService>().updateUsername({"username":username},token);
        return ResultSuccess(res) ;

      } on DioException catch(e){
        return ResultError(e);
      }
    } else {
      return NoResult("Can't Update Username");
    }
    
  }
  
  @override
  Future<bool> isLoggedIn() {
    return serviceLocator<AuthLocalService>().isLoggedIn();
  }
  
  @override
  Future<bool> logout() {
    return serviceLocator<AuthLocalService>().logout();
  }
  

}