import 'package:ams_messaging/core/service_locator/service_locator.dart';
import 'package:ams_messaging/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:ams_messaging/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:ams_messaging/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:ams_messaging/features/auth/domain/usecases/login_usecase.dart';
import 'package:ams_messaging/features/auth/domain/usecases/register_usecase.dart';
import 'package:ams_messaging/features/auth/domain/usecases/update_username_usecase.dart';
import 'package:ams_messaging/features/auth/domain/usecases/upload_image_usecase.dart';
import 'package:ams_messaging/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';

void initAuthSingletons(Dio dio){

  
  // Services
  serviceLocator.registerSingleton<AuthApiService>(
    AuthApiService(dio)
    );

  serviceLocator.registerSingleton<AuthLocalService>( 
    AuthLocalServiceImpl(),
  );

  // Repositories
   serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
    );


  //use cases
  serviceLocator.registerSingleton<GetUserUseCase>(
    GetUserUseCase(),
  );
  serviceLocator.registerSingleton<LoginUseCase>(
    LoginUseCase(),
  );
  serviceLocator.registerSingleton<RegisterUseCase>(
    RegisterUseCase(),
  );
  serviceLocator.registerSingleton<UploadImageUsecase>(
    UploadImageUsecase()
  );
  serviceLocator.registerSingleton<UpdateUsernameUsecase>(
    UpdateUsernameUsecase()
  );

  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(serviceLocator())
  );
}