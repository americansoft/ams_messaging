
import 'package:json_annotation/json_annotation.dart';
part 'friend_request_model.g.dart';

@JsonSerializable()
class FriendRequestModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'requester')
  Requester? requester;
  @JsonKey(name: 'receiver')
  Receiver? receiver;
  @JsonKey(name: 'status')
  String? status;

  FriendRequestModel({this.id, this.requester, this.receiver, this.status});

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) => _$FriendRequestModelFromJson(json);

  static List<FriendRequestModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(FriendRequestModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$FriendRequestModelToJson(this);
}

@JsonSerializable()
class Receiver {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;

  Receiver({this.id, this.username});

  factory Receiver.fromJson(Map<String, dynamic> json) => _$ReceiverFromJson(json);

  static List<Receiver> fromList(List<Map<String, dynamic>> list) {
    return list.map(Receiver.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$ReceiverToJson(this);
}

@JsonSerializable()
class Requester {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;

  Requester({this.id, this.username});

  factory Requester.fromJson(Map<String, dynamic> json) => _$RequesterFromJson(json);

  static List<Requester> fromList(List<Map<String, dynamic>> list) {
    return list.map(Requester.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$RequesterToJson(this);
}