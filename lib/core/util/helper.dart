import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

final _screenDimention = Get.width < Get.height ? Get.width : Get.height;
double _scaleFactor(size, [double factor = 0.5]) {
  return size + ((_screenDimention / 350 * size) - size) * factor;
}

extension ScaleDoubleFactor on double {
  double get scale {
    return _scaleFactor(this);
  }
}

extension ScaleFactor on int {
  double get scale {
    return _scaleFactor(this);
  }
}

const appSpace = 8.0;

int itemCanFitHorizontal({required double width}) => Get.width ~/ width;
int itemCanFitVertical({required double height}) => Get.height ~/ height;

final Logger logger = _logger();
Logger _logger() => Logger(
      printer: PrettyPrinter(methodCount: 1, errorMethodCount: 1),
    );

String formatDate(DateTime dateTime) =>
    DateFormat("YYYY-MM-DD").format(dateTime); //2000-07-11

String invoiceFormater(int no) => no.toString().padLeft(5, "0");
