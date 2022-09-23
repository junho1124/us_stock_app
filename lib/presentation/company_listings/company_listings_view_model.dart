import 'dart:async';

import 'package:flutter/material.dart';
import 'package:us_stock_app/domain/repository/stock_repository.dart';
import 'package:us_stock_app/presentation/company_listings/company_listings_action.dart';
import 'package:us_stock_app/presentation/company_listings/company_listings_state.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = CompanyListingsState();

  // 디바운스 용도
  Timer? _debounce;

  CompanyListingsState get state => _state;

  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  void onAction(CompanyListingsAction action) {
    action.when(
      refresh: () => _getCompanyListings(fetchFromRemote: true),
      onSearchQueryChange: (query) {
        // 디바운스 구현 => 너무 빨리 많은 작동을 하는 것을 방지
        // 디바운스에 아직 명령이 있다면 디바운스에 적용된 함수가 작동되지 않음
        _debounce?.cancel();
        // 앞의 시간(500 밀리초) 이 후에 뒤의 함수가 call 되도록 명령
        _debounce = Timer(const Duration(milliseconds: 500), () {
          _getCompanyListings(query: query);
        });
      },
    );
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
        print('리모트 에러 : $error');
      },
    );

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }
}
