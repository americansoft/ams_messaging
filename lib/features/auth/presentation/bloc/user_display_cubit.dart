

import 'package:ams_messaging/features/auth/domain/entities/user.dart';
import 'package:ams_messaging/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:ams_messaging/features/auth/presentation/bloc/user_display_state.dart';
import 'package:ams_messaging/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDisplayCubit extends Cubit<UserDisplayState> {

  UserDisplayCubit() : super (UserLoading());

  void displayUser() async {
    var result = await serviceLocator.get<GetUserUseCase>().call({});
    emit(UserLoaded(userEntity: UserEntity(email: result.email!, username: result.username)));
  }
}