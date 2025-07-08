import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/service_locator.dart';


class UpdateUsernameUsecase {

  Future<HttpResult> call(String username) async {
    return serviceLocator.get<AuthRepository>().updateUsername(username);
  }
  
}