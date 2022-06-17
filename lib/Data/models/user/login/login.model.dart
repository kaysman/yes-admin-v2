import 'package:json_annotation/json_annotation.dart';
part 'login.model.g.dart';

@JsonSerializable()
class LoginDTO {
  final String phoneNumber;
  final String password;

  LoginDTO({
    required this.phoneNumber,
    required this.password,
  });

  factory LoginDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);
}
