import 'package:intl/intl.dart';
import 'package:us_stock_app/data/source/remote/dto/intraday_info_dto.dart';
import 'package:us_stock_app/domain/model/intraday_info.dart';

extension ToIntradyInfo on IntradayInfoDto {
  IntradayInfo toIntradayInfo() {
    final formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
    return IntradayInfo(
      date: formatter.parse(timestamp),
      close: close,
    );
  }
}
