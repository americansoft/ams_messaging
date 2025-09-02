import 'dart:async';
import 'dart:io';

import 'package:ams_messaging/config/constansts/http_constansts.dart';
import 'package:ams_messaging/core/network/dio_client.dart';
import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:ams_messaging/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:ams_messaging/features/auth/data/models/auth_model.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/core/service_locator/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';


class AuthRepositoryImpl extends AuthRepository {
  final apiServer = serviceLocator.get<AuthApiService>();
  final localServer = serviceLocator.get<AuthLocalService>();
  final dioClient = serviceLocator.get<DioClient>();
  
  @override
  Future<HttpResult<AuthModel>> register(AuthParams params) async {
    try {
         HttpResponse<AuthModel> response  = await apiServer.register(params);
         String? token = response.data.data!.token;
         localServer.saveToken(token!);
         return ResultSuccess(response.data);
    } on DioException catch(e){
      return ResultError(e);
    }
  }

    @override
  Future<HttpResult<AuthModel>>login(AuthParams params) async {
    try {
         final response  = await apiServer.login(params);
         String? token = response.data.data!.token;
         localServer.saveToken(token!);
         return ResultSuccess(response.data);
    } on DioException catch(error){
      return ResultError(error);
    }
    
  }
  
  @override
  Future<HttpResult<AuthModel>> getCurrentUser() async {
    try{
      String? token = await localServer.getToken();
      final response  = await serviceLocator<AuthApiService>().getCurrentUser(token!);
      return ResultSuccess(response.data);

    } on DioException catch (error){
      return ResultError(error);
    }
    
    
  }
  

  @override
  Future<HttpResult> updateUsername(String username) async {
    String? token = await localServer.getToken();
    if(token != null){
      try {
        final res = await apiServer.updateUsername({"username":username},token);
        return ResultSuccess(res) ;

      } on DioException catch(e){
        return ResultError(e);
      }
    } else {
      return NoResult("Can't Update Username");
    }
    
  }
  
  @override
  Future<bool> logout() {
    return localServer.logout();
  }

  @override
  Future<HttpResult> uploadProfileImage(File image) async {
    String? token = await localServer.getToken();

   
  if(token != null){
        try {
      final data = FormData.fromMap({
        'profile-image':[await MultipartFile.fromFile(
          image.path,
          filename: image.path.split(Platform.pathSeparator).last,
          contentType: DioMediaType('image', 'jpeg')),]
      }
    );
    final headers = {'Authorization': token};
      
      final res = dioClient.post(
        '${ApiUrls.baseUrl}${ApiUrls.uploadProfileImage}',
        options: Options(headers: headers) ,
        data: data
        );
      return ResultSuccess(res) ;


    } on DioException catch(e){
      return ResultError(e);
    }
  }
    return NoResult("error");

    }

}