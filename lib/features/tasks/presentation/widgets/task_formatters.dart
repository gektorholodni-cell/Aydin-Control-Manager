import 'package:intl/intl.dart';

String formatTaskDate(DateTime date, {String? locale}) {
  return DateFormat.yMMMd(locale).format(date);
}

String formatTaskProgress(double progress) {
  return '${(progress * 100).round()}%';
}

String formatTaskMoney(double amount, {String? locale}) {
  final value = NumberFormat('#,##0', locale).format(amount);
  return '\$$value';
}
