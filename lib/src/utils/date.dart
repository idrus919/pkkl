import 'package:intl/intl.dart';

class DateUtil {
  static String? month(DateTime? date) {
    if (date == null) return null;

    final result = DateFormat.MMMM().format(date);
    return result;
  }
}
