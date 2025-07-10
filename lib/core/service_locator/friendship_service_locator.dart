import 'package:ams_messaging/core/service_locator/service_locator.dart';
import 'package:ams_messaging/features/friendship/data/datasources/local/friendship_local_serviec.dart';
import 'package:ams_messaging/features/friendship/data/datasources/remote/friendship_api_service.dart';
import 'package:ams_messaging/features/friendship/data/repositories/friendship_repository_impl.dart';
import 'package:ams_messaging/features/friendship/domain/repository/friendship_repository.dart';
import 'package:ams_messaging/features/friendship/domain/usecases/accept_reauest_usecase.dart';
import 'package:ams_messaging/features/friendship/domain/usecases/decline_request.usecase.dart';
import 'package:ams_messaging/features/friendship/domain/usecases/get_friends_usecase.dart';
import 'package:ams_messaging/features/friendship/domain/usecases/get_pending_request_usecase.dart';
import 'package:ams_messaging/features/friendship/domain/usecases/search_users_usecase.dart';
import 'package:ams_messaging/features/friendship/domain/usecases/send_request_usecaes.dart';
import 'package:dio/dio.dart';

void initFriendshipingletons(Dio dio){

  
  // Services
  serviceLocator.registerSingleton<FriendshipApiService>(
    FriendshipApiService(dio)
    );

  serviceLocator.registerSingleton<FriendshipLocalService>( 
    FriendshipLocalServiceImpl(),
  );

  // Repositories
   serviceLocator.registerSingleton<FriendshipRepository>(
    FriendshipRepositoryImpl()
    );


  //use cases
  serviceLocator.registerLazySingleton<SendRequestUsecaes>(
    () => SendRequestUsecaes(),
  );
  serviceLocator.registerLazySingleton<AcceptReauestUsecase>(
    () => AcceptReauestUsecase(),
  );
  serviceLocator.registerLazySingleton<DeclineRequestUsecase>(
    () => DeclineRequestUsecase(),
  );
  serviceLocator.registerLazySingleton<SearchUsersUsecase>(
    () => SearchUsersUsecase()
  );
  serviceLocator.registerLazySingleton<GetFriendsUsecase>(
   () => GetFriendsUsecase()
  );
  serviceLocator.registerLazySingleton<GetPendingRequestUsecase>(
   () => GetPendingRequestUsecase()
  );
}