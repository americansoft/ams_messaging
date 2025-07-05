
import 'package:json_annotation/json_annotation.dart';
part 'auth_params.g.dart';

@JsonSerializable()
class AuthParams {
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'password')
  String password;

  AuthParams({required this.email, required this.password});

  factory AuthParams.fromJson(Map<String, dynamic> json) => _$AuthParamsFromJson(json);

  static List<AuthParams> fromList(List<Map<String, dynamic>> list) {
    return list.map(AuthParams.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$AuthParamsToJson(this);
}