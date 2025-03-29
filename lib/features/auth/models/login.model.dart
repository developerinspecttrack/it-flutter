import 'package:json_annotation/json_annotation.dart';
part 'login.model.g.dart';

@JsonSerializable()
class LoginResponse {
  final String message;
  final String accessToken;
  final String refreshToken;

  LoginResponse({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
  });
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
