// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userroleresponse.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRoleResponse _$UserRoleResponseFromJson(Map<String, dynamic> json) =>
    UserRoleResponse(
      message: json['message'] as String,
      userType: json['userType'] as String,
    );

Map<String, dynamic> _$UserRoleResponseToJson(UserRoleResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'userType': instance.userType,
    };
