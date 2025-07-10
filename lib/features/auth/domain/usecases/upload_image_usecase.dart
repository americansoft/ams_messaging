import 'dart:io';

import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/features/auth/domain/repository/auth_repository.dart';
import 'package:ams_messaging/core/service_locator/service_locator.dart';


class UploadImageUsecase{

  Future<HttpResult> call(File image) async {
    return serviceLocator.get<AuthRepository>().uploadProfileImage(image);
  }
  
}