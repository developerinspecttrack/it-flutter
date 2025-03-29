// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userprofile.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      address: json['address'] as String,
      userEmail: json['userEmail'] as String,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'userEmail': instance.userEmail,
      'address': instance.address,
    };
