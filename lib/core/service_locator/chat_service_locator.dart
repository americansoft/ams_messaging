import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/chat/data/datasources/remote/chat_api_service.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repository/chat_repository.dart';
import '../../features/chat/domain/usecases/get_conversations_usecase.dart';
import '../../features/chat/domain/usecases/get_messages_usecase.dart';
import '../../features/chat/domain/usecases/send_message_usecase.dart';
import '../../features/chat/domain/usecases/add_reaction_usecase.dart';
import '../../features/chat/domain/usecases/search_messages_usecase.dart';
import '../../features/chat/domain/usecases/upload_file_usecase.dart';
import '../../features/chat/presentation/bloc/chat_bloc.dart';

final serviceLocator = GetIt.instance;

void setupChatServiceLocator() {
  // API Service
  serviceLocator.registerLazySingleton<ChatApiService>(
    () => ChatApiServiceImpl(serviceLocator<Dio>()),
  );

  // Repository
  serviceLocator.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(serviceLocator<ChatApiService>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton<GetConversationsUseCase>(
    () => GetConversationsUseCase(serviceLocator<ChatRepository>()),
  );

  serviceLocator.registerLazySingleton<GetMessagesUseCase>(
    () => GetMessagesUseCase(serviceLocator<ChatRepository>()),
  );

  serviceLocator.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(serviceLocator<ChatRepository>()),
  );

  serviceLocator.registerLazySingleton<AddReactionUseCase>(
    () => AddReactionUseCase(serviceLocator<ChatRepository>()),
  );

  serviceLocator.registerLazySingleton<SearchMessagesUseCase>(
    () => SearchMessagesUseCase(serviceLocator<ChatRepository>()),
  );

  serviceLocator.registerLazySingleton<UploadFileUseCase>(
    () => UploadFileUseCase(serviceLocator<ChatRepository>()),
  );

  // BLoC
  serviceLocator.registerFactory<ChatBloc>(
    () => ChatBloc(
      getConversationsUseCase: serviceLocator<GetConversationsUseCase>(),
      getMessagesUseCase: serviceLocator<GetMessagesUseCase>(),
      sendMessageUseCase: serviceLocator<SendMessageUseCase>(),
      addReactionUseCase: serviceLocator<AddReactionUseCase>(),
      searchMessagesUseCase: serviceLocator<SearchMessagesUseCase>(),
      uploadFileUseCase: serviceLocator<UploadFileUseCase>(),
    ),
  );
} 