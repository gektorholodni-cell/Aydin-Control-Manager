import 'package:intl/intl.dart';

String formatMoney(double amount, {String? locale}) {
  final formatted = NumberFormat('#,##0', locale).format(amount);
  return '\$$formatted';
}

String formatDateShort(DateTime date, {String? locale}) {
  return DateFormat.yMMMd(locale).format(date);
}

String formatPercent(double progress) {
  return '${(progress * 100).toStringAsFixed(0)}%';
}
