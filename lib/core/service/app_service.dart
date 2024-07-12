class AppService {
  static String converToString(value) {
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
}
