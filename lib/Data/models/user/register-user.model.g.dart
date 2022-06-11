// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register-user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterUserDTO _$RegisterUserDTOFromJson(Map<String, dynamic> json) =>
    RegisterUserDTO(
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      role: $enumDecode(_$RoleTypeEnumMap, json['role']),
      firstName: json['firstName'] as String?,
      image: json['image'] as String?,
      address: json['address'] as String,
    );

Map<String, dynamic> _$RegisterUserDTOToJson(RegisterUserDTO instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'role': _$RoleTypeEnumMap[instance.role],
      'firstName': instance.firstName,
      'image': instance.image,
      'address': instance.address,
    };

const _$RoleTypeEnumMap = {
  RoleType.END_USER: 'END_USER',
  RoleType.BUSINESS_USER: 'BUSINESS_USER',
  RoleType.ADMIN: 'ADMIN',
};
