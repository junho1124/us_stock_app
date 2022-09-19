import 'package:hive/hive.dart';
import 'package:us_stock_app/data/source/local/comapny_listing_entity.dart';

class StockDao {
  final box = Hive.box<List<CompanyListingEntity>>('stock.db');
  static const companyListing = "companyListing";

  ///추가
  Future insertCompanyListings(
      List<CompanyListingEntity> companyListingEntity) async {
    await box.put(companyListing, companyListingEntity);
  }

  ///클리어
  Future clearCompanyListings() async {
    await box.clear();
  }

  ///검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    final companyListing = box.get(StockDao.companyListing, defaultValue: []);
    return companyListing!
        .where((e) =>
            e.name.toLowerCase().contains(query.toLowerCase()) ||
            query.toUpperCase() == e.symbol)
        .toList();
  }
}
