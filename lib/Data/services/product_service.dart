import 'dart:convert';

import 'package:admin_v2/Data/models/product/delete-many-products.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Data/models/product/update-product.model.dart';
import 'package:admin_v2/Data/models/response.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'api_client.dart';

class ProductService {
  static Future<ProductEntity> createProduct(
    List<PlatformFile> files,
    Map<String, String> fields,
  ) async {
    var uri = Uri.parse(baseUrl + '/products/create');
    try {
      print(fields);
      var res = await ApiClient.instance.multiPartRequest(
        uri,
        files
            .map(
              (e) => MultipartFile.fromBytes(
                'images',
                e.bytes?.toList() ?? [],
                filename: e.name,
              ),
            )
            .toList(),
        fields: fields,
      );
      print(res.data);
      return ProductEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> updateProduct(UpdateProductDTO data) async {
    var uri = Uri.parse(baseUrl + '/products/update');
    try {
      var res = await ApiClient.instance
          .patch(uri, data: jsonEncode(data.toJson()), headers: header());
      return res;
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> deleteProduct(int id) async {
    var uri = Uri.parse(baseUrl + '/products/$id');
    try {
      var res = await ApiClient.instance.delete(uri, headers: header());
      return res;
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> multiDeleteProduct(
      DeleteMultiProductModel data) async {
    var uri = Uri.parse(baseUrl + '/products/deleteMultiple');
    try {
      var res = await ApiClient.instance
          .patch(uri, data: json.encode(data.toJson()), headers: header());
      return res;
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ProductEntity?> getProductById(int id) async {
    var uri = Uri.parse(baseUrl + '/products/$id');
    try {
      var res = await ApiClient.instance.get(uri, headers: header());
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
      // print('Product res: ${res.data}');
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
          ),
        ],
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  static Future<ApiResponse> uploadImage(List<PlatformFile> files) async {
    var uri = Uri.parse(baseUrl + '/products/uploadImages');
    try {
      var res = await ApiClient.instance.multiPartRequest(
        uri,
        files
            .map((e) => MultipartFile.fromBytes(
                  'images',
                  e.bytes?.toList() ?? [],
                  filename: e.name,
                ))
            .toList(),
      );
      print(res.data);
      return res;
    } catch (_) {
      throw _;
    }
  }
}
