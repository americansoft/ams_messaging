
import 'package:json_annotation/json_annotation.dart';
part 'user_preview_model.g.dart';

@JsonSerializable()
class UserPreviewModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'email')
  String? email;

  UserPreviewModel({this.id, this.username, this.email});

  factory UserPreviewModel.fromJson(Map<String, dynamic> json) => _$UserPreviewModelFromJson(json);

  static List<UserPreviewModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserPreviewModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$UserPreviewModelToJson(this);
}