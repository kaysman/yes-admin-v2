import 'package:admin_v2/Data/models/user/login/login.model.dart';
import 'package:admin_v2/Data/models/user/register/register-user.model.dart';
import 'package:admin_v2/Data/services/api_client.dart';
import 'package:admin_v2/Data/services/local_storage.service.dart';

class AuthService {
  static Future<LoginDTO> login(String phone, String password) async {
    try {
      var uri = Uri.parse(baseUrl + '/signin');
      var body = {"phone": phone, "password": password};
      var parsedBody = await ApiClient.instance.post(uri, data: body);
      var storage = await LocalStorage.instance;
      // storage.
      return LoginDTO.fromJson(parsedBody.data);
    } catch (_) {
      throw _;
    }
  }

  static Future<RegisterUserDTO> register() async {
    try {
      var uri = Uri.parse(baseUrl + '/signup');
      var parsedBody = await ApiClient.instance.get(uri);
      return RegisterUserDTO.fromJson(parsedBody.data);
    } catch (_) {
      throw _;
    }
  }
}
