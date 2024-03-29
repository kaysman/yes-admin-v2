import 'dart:convert';

import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.model.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';

import 'api_client.dart';

class FilterService {
  static Future<FilterEntity?> createFilter(FilterDTO data) async {
    var uri = Uri.parse(baseUrl + '/filters/create');
    try {
      var res = await ApiClient.instance
          .post(uri, data: jsonEncode(data.toJson()), headers: header());
      return FilterEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<List<FilterEntity>> getFilters(
    Map<String, dynamic> queryParams,
  ) async {
    String url = baseUrl + '/filters?';
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
          .map((json) => FilterEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }
}
