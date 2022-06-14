import 'dart:convert';
import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/create-category.model.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'api_client.dart';

class CategoryService {
  static Future<CategoryEntity?> createCategory(CreateCategoryDTO data) async {
    var uri = Uri.parse(baseUrl + '/categories/create');
    try {
      var res = await ApiClient.instance.post(
        uri,
        data: jsonEncode(data.toJson()),
        headers: header(),
      );
      return CategoryEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<List<CategoryEntity>> getCategories() async {
    var uri = Uri.parse(baseUrl + '/categories/all');
    try {
      var res = await ApiClient.instance.get(uri, headers: header());
      print(res.data);
      return (res.data as List)
          .map((json) => CategoryEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }
}
