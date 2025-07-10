// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendRequestModel _$FriendRequestModelFromJson(Map<String, dynamic> json) =>
    FriendRequestModel(
      id: (json['id'] as num?)?.toInt(),
      requester: json['requester'] == null
          ? null
          : Requester.fromJson(json['requester'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : Receiver.fromJson(json['receiver'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$FriendRequestModelToJson(FriendRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requester': instance.requester,
      'receiver': instance.receiver,
      'status': instance.status,
    };

Receiver _$ReceiverFromJson(Map<String, dynamic> json) => Receiver(
  id: (json['id'] as num?)?.toInt(),
  username: json['username'] as String?,
);

Map<String, dynamic> _$ReceiverToJson(Receiver instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
};

Requester _$RequesterFromJson(Map<String, dynamic> json) => Requester(
  id: (json['id'] as num?)?.toInt(),
  username: json['username'] as String?,
);

Map<String, dynamic> _$RequesterToJson(Requester instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
};
