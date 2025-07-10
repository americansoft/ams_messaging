import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/core/service_locator/service_locator.dart';


class RegisterUseCase {

  Future<HttpResult> call(AuthParams  param) async {
    return serviceLocator.get<AuthRepository>().register(param);
  }
  
}