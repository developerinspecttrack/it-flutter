import 'package:json_annotation/json_annotation.dart';
part 'userprofile.model.g.dart';

@JsonSerializable()
class UserProfile {
  final String userEmail;
  final String address;
  UserProfile({
    required this.address,
    required this.userEmail,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
