import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/response.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'api_client.dart';

class BrandService {
  static Future<BrandEntity?> createBrand(
    List<FilePickerResult> files,
    Map<String, String> fields,
  ) async {
    var uri = Uri.parse(baseUrl + '/brands/create');
    try {
      print(fields);
      var res = await ApiClient.instance.multiPartRequest(
        uri,
        files
            .map((e) => MultipartFile.fromBytes(
                  'logo',
                  e.files.first.bytes!.toList(),
                  filename: e.names.first,
                ))
            .toList(),
        fields: fields,
      );
      return BrandEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> updateBrand(
    List<FilePickerResult> files,
    Map<String, String> fields,
  ) async {
    var uri = Uri.parse(baseUrl + '/brands/update');
    try {
      print(fields);
      var res = await ApiClient.instance.multiPartRequest(
        uri,
        files
            .map((e) => MultipartFile.fromBytes(
                  'logo',
                  e.files.first.bytes!.toList(),
                  filename: e.names.first,
                ))
            .toList(),
        fields: fields,
        isUpdating: true,
      );
      return res;
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> deleteBrand(int id) async {
    var uri = Uri.parse(baseUrl + '/brands/$id');
    try {
      var res = await ApiClient.instance.delete(uri, headers: header());
      return res;
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<BrandEntity?> getBrandById(int id) async {
    var uri = Uri.parse(baseUrl + '/brands/$id');
    try {
      var res = await ApiClient.instance.get(uri, headers: header());
      return BrandEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<List<BrandEntity>> getBrands(
    Map<String, dynamic> queryParams,
  ) async {
    String url = baseUrl + '/brands?';
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
          .map((json) => BrandEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }
}
