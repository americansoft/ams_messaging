
import 'package:json_annotation/json_annotation.dart';
part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  @JsonKey(name: 'success')
  bool? success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  Data? data;

  AuthModel({this.success, this.message, this.data});

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  static List<AuthModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(AuthModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'user')
  User? user;
  @JsonKey(name: 'token')
  String? token;

  Data({this.user, this.token});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'verificationToken')
  String? verificationToken;
  @JsonKey(name: 'username')
  dynamic username;
  @JsonKey(name: 'resetPasswordToken')
  dynamic resetPasswordToken;
  @JsonKey(name: 'isAcountVerified')
  bool? isAcountVerified;
  @JsonKey(name: 'profileImage')
  dynamic profileImage;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  User({this.email, this.password, this.verificationToken, this.username, this.resetPasswordToken, this.isAcountVerified, this.profileImage, this.id, this.createdAt, this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static List<User> fromList(List<Map<String, dynamic>> list) {
    return list.map(User.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}