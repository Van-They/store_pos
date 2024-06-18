class AppService {
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

    return value.toDouble();
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
    return value.toInt();
  }
}
