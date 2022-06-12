import 'dart:convert';
import 'package:admin_v2/Data/models/market/create-market.model.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/services/api_client.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:http/http.dart' as http;

class MarketService {
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

  static Future<List<MarketEntity>> getMarkets() async {
    var uri = Uri.parse(baseUrl + '/markets/all');
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

  static Future<List<MarketEntity>> searchMarket(String? searchQuery) async {
    var uri = Uri.parse(baseUrl + '/markets?search=$searchQuery');
    try {
      var res = await ApiClient.instance.get(uri, headers: header());
      print(res.data);
      return (res.data as List)
          .map((json) => MarketEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      print(_);
      throw _;
    }
  }
}
