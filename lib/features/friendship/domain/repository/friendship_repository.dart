import 'package:ams_messaging/core/network/http_results.dart';

abstract class FriendshipRepository {
  
  Future<HttpResult> sendRequest();
  Future<HttpResult> acceptRequest();
  Future<HttpResult> declineRequest();
  Future<HttpResult> getFriendsList();
  Future<HttpResult> searchUsers();
  Future<HttpResult> getPendingRequest();
  
}