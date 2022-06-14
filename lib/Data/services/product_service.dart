import 'dart:convert';
import 'package:admin_v2/Data/models/product/create-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';

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

  static Future<List<ProductEntity>> getProducts() async {
    var uri = Uri.parse(baseUrl + '/products');
    try {
      var res = await ApiClient.instance.get(uri, headers: header());
      print(res.data);
      return (res.data as List)
          .map((json) => ProductEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }
}
