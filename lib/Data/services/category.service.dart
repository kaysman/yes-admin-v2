import 'dart:convert';
import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/create-category.model.dart';
import 'package:admin_v2/Data/models/response.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import '../models/category/update-category.model.dart';
import 'api_client.dart';

class CategoryService {
  static Future<ApiResponse> createCategory(CreateCategoryDTO data) async {
    var uri = Uri.parse(baseUrl + '/categories/create');
    try {
      var res = await ApiClient.instance.post(
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

  static Future<CategoryEntity?> getCategoryById(int id) async {
    var uri = Uri.parse(baseUrl + '/categories/$id');
    try {
      var res = await ApiClient.instance.get(
        uri,
        headers: header(),
      );
      return CategoryEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<List<CategoryEntity>> getCategories(
    Map<String, dynamic> queryParams,
  ) async {
    String url = baseUrl + '/categories?';
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
      print(res.data.toString());

      return (res.data as List)
          .map((json) => CategoryEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> updateCategory(UpdateCategoryDTO data) async {
    var uri = Uri.parse(baseUrl + '/categories/update');
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

  static Future<ApiResponse> deleteCategory(int id) async {
    var uri = Uri.parse(baseUrl + '/categories/$id');
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
