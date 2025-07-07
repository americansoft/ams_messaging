import 'package:ams_messaging/features/auth/data/models/auth_model.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/service_locator.dart';


class LoginUseCase {

  Future<AuthModel?> call(AuthParams params) async {
    return serviceLocator.get<AuthRepository>().login(params).then((response) {
      if (response.data != null) {
        return AuthModel.fromJson(response.data);
      } else {
        return null;
      }
    });

  }
  
}