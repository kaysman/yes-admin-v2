import 'package:admin_v2/Data/models/role.enum.dart';

class RegisterUserDTO {
  final String phoneNumber;
  final String password;
  final RoleType role;
  final String firstName;
  final String image;
  final String address;

  RegisterUserDTO({
    required this.phoneNumber,
    required this.password,
    required this.role,
    required this.firstName,
    required this.image,
    required this.address,
  });
}
