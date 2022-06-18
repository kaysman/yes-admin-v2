import 'dart:convert';

import 'package:admin_v2/Data/models/credentials.dart';
import 'package:admin_v2/Data/models/user/login/login.model.dart';
import 'package:admin_v2/Data/models/user/register/register-user.model.dart';
import 'package:admin_v2/Data/services/api_client.dart';
import 'package:admin_v2/Data/services/local_storage.service.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';

class AuthService {
  static Future<Credentials> login(LoginDTO data) async {
    try {
      var uri = Uri.parse(baseUrl + '/auth/signin');
      var parsedBody = await ApiClient.instance.post(
        uri,
        headers: header(),
        data: jsonEncode(data.toJson()),
      );
      var disk = (await LocalStorage.instance);
      disk?.toSetResponseMessage = parsedBody.message;
      return Credentials.fromJson(parsedBody.data);
    } catch (_) {
      throw _;
    }
  }

  static Future<Credentials> register(RegisterUserDTO data) async {
    try {
      var uri = Uri.parse(baseUrl + '/auth/signup');
      var parsedBody = await ApiClient.instance.post(
        uri,
        headers: header(),
        data: jsonEncode(data.toJson()),
      );
      return Credentials.fromJson(parsedBody.data);
    } catch (_) {
      throw _;
    }
  }
}
