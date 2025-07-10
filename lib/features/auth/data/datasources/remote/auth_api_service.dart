import 'dart:io';

import 'package:ams_messaging/config/constansts/http_constansts.dart';
import 'package:ams_messaging/features/auth/data/models/auth_model.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' hide Headers;
part "auth_api_service.g.dart";


@RestApi(baseUrl: ApiUrls.baseUrl)
abstract class AuthApiService {

  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST(ApiUrls.register)
  Future<HttpResponse<AuthModel>> register(@Body() AuthParams params);

  @POST(ApiUrls.login)
  Future<HttpResponse<AuthModel>> login(@Body() AuthParams params);
  
  @GET(ApiUrls.currentUser)
  Future<HttpResponse<AuthModel>> getCurrentUser(
  @Header("Authorization") String token,
);
  @PUT(ApiUrls.updateUsername)
  Future<HttpResponse> updateUsername(
    @Body() Map<String, String> body,
    @Header("Authorization") String token
    );

  @MultiPart()
  @POST(ApiUrls.uploadProfileImage)
  Future<HttpResponse<User>> uploadProfileImage(
    @Part(name: "profile-image")  File image,
    @Header("Authorization") String token,
    @Header("Content-Type") String mediaType
  );

  

}   
