import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = "https://www.alphavantage.co/";
  static const apiKey = "K0JHUAB56C3JZ8IW";

  final http.Client client;

  StockApi(this.client);

  Future<http.Response> getListings(String apiKey) async {
    return await client.get(Uri.parse(
        "https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=${apiKey}"));
  }
}
