import 'package:flutter/material.dart';
import 'package:us_stock_app/domain/repository/stock_repository.dart';
import 'package:us_stock_app/presentation/company_listings/company_listings_state.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = CompanyListingsState();

  CompanyListingsState get state => _state;

  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  Future _getCompanyListings(
      {bool fetchFromRemote = false, String query = ""}) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getCompanyListings(fetchFromRemote, query);
    result.when(
      success: (listings) {
        _state = _state.copyWith(companies: listings);
      },
      error: (error) {
        // TODO error 처리
        print('리모트 에러 : ' + error.toString());
      },
    );

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }
}
