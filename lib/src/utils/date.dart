import 'package:intl/intl.dart';

class DateUtil {
  static String? month(DateTime? date) {
    if (date == null) return null;

    final result = DateFormat.MMMM().format(date);
    return result;
  }

  static String string(
    DateTime? date, {
    String format = 'dd MMM yyyy',
    bool zone = false,
  }) {
    if (date == null) return '';

    final result = DateFormat(format, 'id_ID').format(date);
    final zoneString = zone ? ' ${date.timeZoneName}' : '';

    return result + zoneString;
  }

  static DateTime? parse(String? text) {
    text = text ?? '';
    if (text.isEmpty) return null;

    return DateTime.parse(text).toLocal();
  }
}
