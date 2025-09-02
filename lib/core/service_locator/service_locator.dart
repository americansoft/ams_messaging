import 'package:ams_messaging/core/network/dio_client.dart';
import 'package:ams_messaging/core/network/interceptors.dart';
import 'package:ams_messaging/core/service_locator/auth_service_locator.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  final options = BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10) 

  );

  final dio = Dio(
    options
  );
  dio.interceptors.add(LoggerInterceptor());
  serviceLocator.registerSingleton<DioClient>(DioClient());
  
  initAuthSingletons(dio);

  
}