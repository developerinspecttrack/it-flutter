import 'package:json_annotation/json_annotation.dart';
part 'userroleresponse.model.g.dart';

@JsonSerializable()
class UserRoleResponse {
  final String message;
  final String userType;
  UserRoleResponse({
    required this.message,
    required this.userType,
  });

  factory UserRoleResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRoleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserRoleResponseToJson(this);
}
