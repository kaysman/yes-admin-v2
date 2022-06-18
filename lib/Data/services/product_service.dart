import 'dart:convert';
import 'package:admin_v2/Data/models/product/create-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Data/models/response.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'api_client.dart';

class ProductService {
  static Future<ProductEntity?> createProduct(CreateProductDTO data) async {
    var uri = Uri.parse(baseUrl + '/products/create');
    try {
      var res = await ApiClient.instance
          .post(uri, data: jsonEncode(data.toJson()), headers: header());
      return ProductEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<List<ProductEntity>> getProducts(
    Map<String, dynamic> queryParams,
  ) async {
    String url = baseUrl + '/products?';
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
          .map((json) => ProductEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<List<ProductEntity>> searchProduct(String? searchQuery) async {
    var uri = Uri.parse(baseUrl + '/products?search=$searchQuery');
    try {
      var res = await ApiClient.instance.get(uri, headers: header());

      return (res.data as List)
          .map((json) => ProductEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> uploadExcel(
      String filename, List<int> bytes) async {
    var uri = Uri.parse(baseUrl + '/products/uploadExcel');
    try {
      var res = await ApiClient.instance.multiPartRequest(
        uri,
        [
          MultipartFile.fromBytes(
            'file',
            bytes,
            filename: filename,
            contentType: MediaType("excel", "xlsx"),
          )
        ],
      );
      return res;
    } catch (e) {
      throw e;
    }
  }
}
