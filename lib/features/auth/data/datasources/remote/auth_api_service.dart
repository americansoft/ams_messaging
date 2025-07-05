import 'package:ams_messaging/config/constansts/http_constansts.dart';
import 'package:ams_messaging/features/auth/data/models/auth_model.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part "auth_api_service.g.dart";

@RestApi(baseUrl: HttpConstants.baseUrl)
abstract class AuthApiService {

  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST(HttpConstants.registerPath)
  Future<HttpResponse<AuthModel>> register(@Body() AuthParams params);

  @POST(HttpConstants.loginPath)
  Future<HttpResponse<AuthModel>> login(@Body() AuthParams params);
  
  @GET(HttpConstants.currentUserPath)
  Future<HttpResponse<AuthModel>> getCurrentUser(
  @Header("Authorization") String token,
);
  @PUT(HttpConstants.updateUsernamePath)
  Future<HttpResponse> updateUsername(@Body() Map<String, dynamic> body);
  
}   
