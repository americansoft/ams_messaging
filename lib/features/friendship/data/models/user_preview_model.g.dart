// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreviewModel _$UserPreviewModelFromJson(Map<String, dynamic> json) =>
    UserPreviewModel(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UserPreviewModelToJson(UserPreviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
    };
