import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:us_stock_app/data/source/remote/dto/company_info_dto.dart';

class StockApi {
  static const baseUrl = "https://www.alphavantage.co/";
  static const apiKey = "K0JHUAB56C3JZ8IW";

  final http.Client _client;

  StockApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getListings({String apikey = apiKey}) async {
    return await _client.get(Uri.parse(
        "${baseUrl}query?function=LISTING_STATUS&apikey=$apiKey"));
  }

  Future<CompanyInfoDto> getCompanyInfo({
    String apikey = apiKey,
    required String symbol,
  }) async {
    final response =  await _client.get(Uri.parse(
        "${baseUrl}query?function=OVERVIEW&symbol=$symbol&apikey=$apiKey"));
    return CompanyInfoDto.fromJson(jsonDecode(response.body));
  }

  Future<http.Response> getIntradatInfo({
    String apikey = apiKey,
    required String symbol
  }) async {
    return await _client.get(Uri.parse(
        "${baseUrl}query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=60min&apikey=$apiKey&datatype=csv"));
  }
}
