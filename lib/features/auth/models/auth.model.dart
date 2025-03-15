import 'package:json_annotation/json_annotation.dart';
part 'auth.model.g.dart';

@JsonSerializable()
class OtpResponse {
  final String message;
  final String otpId;

  OtpResponse({required this.message, required this.otpId});
  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OtpResponseToJson(this);
}
