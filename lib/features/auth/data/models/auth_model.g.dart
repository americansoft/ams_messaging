// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
  token: json['token'] as String?,
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'user': instance.user,
  'token': instance.token,
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  email: json['email'] as String?,
  password: json['password'] as String?,
  verificationToken: json['verificationToken'] as String?,
  username: json['username'],
  resetPasswordToken: json['resetPasswordToken'],
  isAcountVerified: json['isAcountVerified'] as bool?,
  profileImage: json['profileImage'],
  id: (json['id'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'verificationToken': instance.verificationToken,
  'username': instance.username,
  'resetPasswordToken': instance.resetPasswordToken,
  'isAcountVerified': instance.isAcountVerified,
  'profileImage': instance.profileImage,
  'id': instance.id,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
