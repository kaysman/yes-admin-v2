import 'package:admin_v2/Data/models/role.enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register-user.model.g.dart';

@JsonSerializable()
class RegisterUserDTO {
  final String phoneNumber;
  final String password;
  final RoleType role;
  final String? firstName;
  final String? image;
  final String address;

  RegisterUserDTO({
    required this.phoneNumber,
    required this.password,
    required this.role,
    this.firstName,
    this.image,
    required this.address,
  });

  factory RegisterUserDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserDTOToJson(this);
}
