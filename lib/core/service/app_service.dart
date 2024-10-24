import 'package:intl/intl.dart';

class AppService {
  static final _displayFormat = NumberFormat("#,##0.00", "en_US");

  static String convertToString(value) {
    if (value == null) {
      return '';
    }
    return '$value';
  }

  static double convertToDouble(value) {
    if (value == null) {
      return 0.0;
    }
    if (value == '') {
      return 0.0;
    }
    if (value is double) {
      return value;
    }

    if (value is int) {
      return value.toDouble();
    }

    return double.parse(value);
  }

  static int convertToInt(value) {
    if (value == null) {
      return 0;
    }
    if (value == '') {
      return 0;
    }
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.toInt();
    }
    return int.parse(value);
  }

  static String displayFormat(double unitPrice) {
    return "\$${_displayFormat.format(unitPrice)}";
  }
}
