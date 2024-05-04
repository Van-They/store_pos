import 'package:get/get.dart';

final _screenOrientation = Get.width < Get.height ? Get.width : Get.height;

double scaleFactor(size, [double factor = 0.5]) {
  return size + ((_screenOrientation / 350 * size) - size) * factor;
}

const appSpace = 8.0;