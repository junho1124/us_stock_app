import 'package:csv/csv.dart';
import 'package:us_stock_app/data/csv/csv_parser.dart';
import 'package:us_stock_app/domain/model/company_listing.dart';

class CompanyListingsParser implements CsvParser<CompanyListing> {
  @override
  Future<List<CompanyListing>> parse(String csvString) async {
    List<List<dynamic>> csvValues =
        const CsvToListConverter().convert(csvString);
    csvValues.removeAt(0);
    return csvValues
        .map((e) => CompanyListing(
              symbol: e[0] ?? "",
              name: e[1] ?? "",
              exchange: e[2] ?? "",
            ))
        .where((e) =>
            e.symbol.isNotEmpty && e.name.isNotEmpty && e.exchange.isNotEmpty)
        .toList();
  }
}
