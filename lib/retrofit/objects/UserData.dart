import 'package:json_annotation/json_annotation.dart';

part 'UserData.g.dart';

@JsonSerializable()
class UserData{
  @JsonKey(name: "user_name")
  String userName;
  @JsonKey(name: "user_info")
  String userInfo;
  @JsonKey(name: "status")
  String status;

  UserData(this.userName, this.userInfo, this.status);

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}