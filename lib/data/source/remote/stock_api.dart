import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = "https://www.alphavantage.co/";
  static const apiKey = "K0JHUAB56C3JZ8IW";

  final http.Client _client;

  StockApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getListings({String apikey = apiKey}) async {
    return await _client.get(Uri.parse(
        "https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=$apiKey"));
  }
}
