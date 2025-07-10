

import 'package:ams_messaging/features/auth/data/models/auth_model.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/core/service_locator/service_locator.dart';

class GetUserUseCase{
  Future<User> call(Map<String,String> username) async {
    return await serviceLocator.get<AuthRepository>().getCurrentUser().then((response) {
      if (response.data != null) {
        return User.fromJson(response.data);
      } else {
        throw Exception('User data is empty');
      }
    });
  }
  
}