import 'package:auth/core/usecase/usecase.dart';
import 'package:auth/domain/repositories/auth.dart';
import 'package:auth/service_locator.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {

  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepository>().isLoggedIn();
  }
  
}