import 'dart:convert';
import 'package:admin_v2/Data/models/market/create-market.model.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/models/response.dart';
import 'package:admin_v2/Data/services/api_client.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MarketService {
  static final selectedMarket = ValueNotifier<MarketEntity?>(null);

  static Future<MarketEntity?> createMarket(CreateMarketDTO data) async {
    var uri = Uri.parse(baseUrl + '/markets/create');
    try {
      var res = await ApiClient.instance.post(
        uri,
        data: jsonEncode(data.toJson()),
        headers: header(),
      );
      return MarketEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<List<MarketEntity>> getMarkets(
    Map<String, dynamic> queryParams,
  ) async {
    String url = baseUrl + '/markets?';
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
          .map((json) => MarketEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> updateMarkets(MarketEntity data) async {
    var uri = Uri.parse(baseUrl + '/markets/update');
    try {
      var res = await ApiClient.instance.patch(
        uri,
        headers: header(),
        data: json.encode(data.toJson()),
      );
      return res;
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<MarketEntity?> getMarketById(int id) async {
    var uri = Uri.parse(baseUrl + '/markets/$id');
    try {
      var res = await ApiClient.instance.get(
        uri,
        headers: header(),
      );
      return MarketEntity.fromJson(res.data);
    } catch (_) {
      print(_);
      throw _;
    }
  }

  static Future<ApiResponse> deleteMarket(int id) async {
    var uri = Uri.parse(baseUrl + '/markets/$id');
    try {
      var res = await ApiClient.instance.delete(uri, headers: header());
      return res;
    } catch (_) {
      throw _;
    }
  }
}
