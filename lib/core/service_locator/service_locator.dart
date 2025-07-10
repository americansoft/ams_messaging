import 'package:ams_messaging/core/network/dio_client.dart';
import 'package:ams_messaging/core/network/interceptors.dart';
import 'package:ams_messaging/core/service_locator/auth_service_locator.dart';
import 'package:ams_messaging/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:ams_messaging/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:ams_messaging/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:ams_messaging/features/auth/domain/usecases/login_usecase.dart';
import 'package:ams_messaging/features/auth/domain/usecases/register_usecase.dart';
import 'package:ams_messaging/features/auth/domain/usecases/update_username_usecase.dart';
import 'package:ams_messaging/features/auth/domain/usecases/upload_image_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
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