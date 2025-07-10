import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/core/service_locator/service_locator.dart';


class LoginUseCase {
  Future<HttpResult> call(AuthParams params) async {
    return serviceLocator.get<AuthRepository>().login(params);
  }
}