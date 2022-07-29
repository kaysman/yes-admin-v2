import 'dart:convert';

import 'package:admin_v2/Data/models/gadget/gadget.model.dart';
import 'package:admin_v2/Data/models/gadget/update-gadget.model.dart';
import 'package:admin_v2/Data/models/response.dart';
import 'package:admin_v2/Data/services/api_client.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';

class GadgetService {
  static Future<ApiResponse> createHomeGadget(
    List<FilePickerResult> files,
    Map<String, String> fields,
  ) async {
    var uri = Uri.parse(baseUrl + '/gadgets/create');
    try {
      print(fields);
      var res = await ApiClient.instance.multiPartRequest(
        uri,
        files
            .map((e) => MultipartFile.fromBytes(
                  'images',
                  e.files.first.bytes!.toList(),
                  filename: e.names.first,
                  // contentType: MediaType("image", "xlsx"),
                ))
            .toList(),
        fields: fields,
      );
      return res;
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<List<GadgetEntity>> getAllGadgets(
    Map<String, dynamic> queryParams,
  ) async {
    String url = baseUrl + '/gadgets?';
    queryParams.forEach((key, value) {
      if (key != null && value != null) {
        url += url.endsWith('?')
            ? '${key}=${queryParams[key]}'
            : '&${key}=${queryParams[key]}';
      }
    });
    var uri = Uri.parse(url);
    try {
      var res = await ApiClient.instance.get(uri, headers: header());
      return (res.data as List)
          .map((json) => GadgetEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<GadgetEntity> getGadgetById(int id) async {
    var uri = Uri.parse(baseUrl + '/gadgets/$id');
    try {
      var res = await ApiClient.instance.get(uri, headers: header());
      return GadgetEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> upDateGadget(UpdateGadgetModel data) async {
    var uri = Uri.parse(baseUrl + '/gadgets/update');
    try {
      var res = await ApiClient.instance.patch(
        uri,
        data: jsonEncode(data.toJson()),
        headers: header(),
      );
      return res;
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> deleteGadget(int id) async {
    var uri = Uri.parse(baseUrl + '/gadgets/$id');
    try {
      var res = await ApiClient.instance.delete(
        uri,
        headers: header(),
      );
      return res;
    } catch (_) {
      print(_);
      throw _;
    }
  }
}
