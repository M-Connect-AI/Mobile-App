import 'package:intl/intl.dart';

extension VndFormatExtension on num {
  String toVNDFormat() {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }
}
