
import 'package:ams_messaging/features/auth/data/datasources/local/auth_local_service.dart';

class IsLoggedInUseCase {
  final AuthLocalService _authLocalService;

  IsLoggedInUseCase(this._authLocalService);

  Future<bool> call() async {
    return await _authLocalService.isLoggedIn();
  }
  
}