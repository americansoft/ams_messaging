import 'package:ams_messaging/config/constansts/app_constants.dart';
import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/core/service_locator/service_locator.dart';
import 'package:ams_messaging/features/friendship/data/datasources/local/friendship_local_serviec.dart';
import 'package:ams_messaging/features/friendship/data/datasources/remote/friendship_api_service.dart';
import 'package:ams_messaging/features/friendship/domain/repository/friendship_repository.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendshipRepositoryImpl extends FriendshipRepository{

  final apiServer = serviceLocator.get<FriendshipApiService>();
  final localServer = serviceLocator.get<FriendshipLocalService>();

  final _tokenkey = AppConstants.prefsToken;
  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  @override
  Future<HttpResult> sendRequest(int receiverId) async {
    final  sharedPreferences = await _prefs;
    final token = sharedPreferences.getString(_tokenkey);
    try {
      final res = await apiServer.sendRequest(token!, {"receiverId":receiverId});
      return ResultSuccess(res);
    } on DioException catch (e){
      return ResultError(e);
    }
  }
  
  @override
  Future<HttpResult> acceptRequest(int requestId) async {

    final  sharedPreferences = await _prefs;
    final token = sharedPreferences.getString(_tokenkey);
    try {
     final res = await apiServer.acceptRequest(token!,{"requestId":requestId});
     return ResultSuccess(res);
      
    } on DioException catch(e){
      return ResultError(e);
    }

  }

  @override
  Future<HttpResult> declineRequest(int requestId)async {
    final  sharedPreferences = await _prefs;
    final token = sharedPreferences.getString(_tokenkey);
    try {
     final res = await apiServer.declineRequest(token!,{"requestId":requestId});
     return ResultSuccess(res);
      
    } on DioException catch(e){
      return ResultError(e);
    }
  }

  @override
  Future<HttpResult> getFriendsList() async{
    final  sharedPreferences = await _prefs;
    final token = sharedPreferences.getString(_tokenkey);
    try {
     final res = await apiServer.getFriends(token!);
     return ResultSuccess(res);
      
    } on DioException catch(e){
      return ResultError(e);
    }
  }

  @override
  Future<HttpResult> getPendingRequest() async {
    final  sharedPreferences = await _prefs;
    final token = sharedPreferences.getString(_tokenkey);
    try {
     final res = await apiServer.getPendingRequests(token!);
     return ResultSuccess(res);
      
    } on DioException catch(e){
      return ResultError(e);
    }
  }

  @override
  Future<HttpResult> searchUsers(String query) async{
    final  sharedPreferences = await _prefs;
    final token = sharedPreferences.getString(_tokenkey);
    try {
     final res = await apiServer.searchUsers(token!,{"query":query});
     return ResultSuccess(res);
      
    } on DioException catch(e){
      return ResultError(e);
    }
  }

}