

import 'package:ams_messaging/core/network/dio_client.dart';
import 'package:ams_messaging/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {

  final dio = Dio();
  serviceLocator.registerSingleton<DioClient>(DioClient());
  
  // Services
  serviceLocator.registerSingleton<AuthApiService>(AuthApiService(dio));
  
}