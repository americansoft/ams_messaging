import 'package:ams_messaging/config/constansts/app_constants.dart';
import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/core/service_locator/service_locator.dart';
import 'package:ams_messaging/features/friendship/data/datasources/local/friendship_local_serviec.dart';
import 'package:ams_messaging/features/friendship/data/datasources/remote/friendship_api_service.dart';
import 'package:ams_messaging/features/friendship/domain/repository/friendship_repository.dart';

class FriendshipRepositoryImpl extends FriendshipRepository{

  final apiServer = serviceLocator.get<FriendshipApiService>();
  final localServer = serviceLocator.get<FriendshipLocalService>();

  final _tokenkey = AppConstants.prefsToken;
  
  @override
  Future<HttpResult> acceptRequest() async {
    try {
      await apiServer.acceptRequest(token, requestId)
      
    } catch (e){

    }
  }

  @override
  Future<HttpResult> declineRequest() {
    // TODO: implement declineRequest
    throw UnimplementedError();
  }

  @override
  Future<HttpResult> getFriendsList() {
    // TODO: implement getFriendsList
    throw UnimplementedError();
  }

  @override
  Future<HttpResult> getPendingRequest() {
    // TODO: implement getPendingRequest
    throw UnimplementedError();
  }

  @override
  Future<HttpResult> searchUsers() {
    // TODO: implement searchUsers
    throw UnimplementedError();
  }

  @override
  Future<HttpResult> sendRequest() {
    // TODO: implement sendRequest
    throw UnimplementedError();
  }

}