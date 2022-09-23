import 'package:flutter/material.dart';
import 'package:us_stock_app/domain/repository/stock_repository.dart';
import 'package:us_stock_app/presentation/company_info/company_info_state.dart';

class CompanyInfoViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = CompanyInfoState();

  CompanyInfoState get state => _state;

  CompanyInfoViewModel(this._repository);

  Future loadCompanyInfo(String symbol) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getCompanyInfo(symbol);
    result.when(
      success: (info) {
        _state = _state.copyWith(
          companyInfo: info,
          isLoading: false,
        );
      },
      error: (e) {
        _state = _state.copyWith(
          companyInfo: null,
          isLoading: false,
        );
      },
    );

    notifyListeners();
  }
}