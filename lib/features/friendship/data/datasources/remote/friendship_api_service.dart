
import 'package:ams_messaging/config/constansts/http_constansts.dart';
import 'package:ams_messaging/features/auth/data/models/auth_model.dart';
import 'package:ams_messaging/features/friendship/data/models/friend_request_model.dart';
import 'package:ams_messaging/features/friendship/data/models/user_preview_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' hide Headers;
part "friendship_api_service.g.dart";


@RestApi(baseUrl: ApiUrls.baseUrl)
abstract class FriendshipApiService {

  factory FriendshipApiService(Dio dio) = _FriendshipApiService;

  @POST(ApiUrls.sendRequest)
  Future<HttpResponse<FriendRequestModel>> sendRequest(
    @Header("Authorization") String token,
    @Body() Map<String, int> receiverId);

  @POST(ApiUrls.acceptRequest)
  Future<HttpResponse<FriendRequestModel>> acceptRequest(
    @Header("Authorization") String token,
    @Body() Map<String, int> requestId);

  @POST(ApiUrls.declineRequest)
  Future<HttpResponse<FriendRequestModel>> declineRequest(
    @Header("Authorization") String token,
    @Body() Map<String, int> requestId);

  @POST(ApiUrls.searchUsers)
  Future<HttpResponse<List<User>>> searchUsers(
    @Header("Authorization") String token,
    @Body() Map<String, String> query);


  @GET(ApiUrls.getFriends)
  Future<HttpResponse<List<UserPreviewModel>>> getFriends(
    @Header("Authorization") String token  
    );

  @GET(ApiUrls.pendingRequests)
  Future<HttpResponse<List<FriendRequestModel>>> getPendingRequests(
    @Header("Authorization") String token  
);


}   
