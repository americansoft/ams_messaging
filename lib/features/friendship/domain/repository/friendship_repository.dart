import 'package:ams_messaging/core/network/http_results.dart';

abstract class FriendshipRepository {
  
  Future<HttpResult> sendRequest(int receiverId);
  Future<HttpResult> acceptRequest(int requestId);
  Future<HttpResult> declineRequest(int requestId);
  Future<HttpResult> getFriendsList();
  Future<HttpResult> searchUsers(String query);
  Future<HttpResult> getPendingRequest();
  
}