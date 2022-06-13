import 'dart:convert';
import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/brand/create-brand.model.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'api_client.dart';

class BrandService {
  static Future<BrandEntity?> createBrand(CreateBrandDTO data) async {
    var uri = Uri.parse(baseUrl + '/brands/create');
    try {
      var res = await ApiClient.instance.post(
        uri,
        data: jsonEncode(data.toJson()),
        headers: header(),
      );
      return BrandEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<List<BrandEntity>> getBrands() async {
    var uri = Uri.parse(baseUrl + '/brands/all');
    try {
      var res = await ApiClient.instance.get(uri, headers: header());
      print(res.data);
      return (res.data as List)
          .map((json) => BrandEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }
}
