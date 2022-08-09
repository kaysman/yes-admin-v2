import 'dart:convert';
import 'package:admin_v2/Data/models/order/order.model.dart';

import '../../Presentation/shared/helpers.dart';
import 'api_client.dart';

class OrderService {
   static Future<List<OrderEntity>> getOrders(
    Map<String, dynamic> queryParams,
  ) async {
    String url = baseUrl + '/orders?';
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
          .map((json) => OrderEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }
}
