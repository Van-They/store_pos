import 'package:get/get.dart';

final _screenOrientation = Get.width < Get.height ? Get.width : Get.height;
double _scaleFactor(size, [double factor = 0.5]) {
  return size + ((_screenOrientation / 350 * size) - size) * factor;
}
extension ScaleDoubleFactor on double {
  double get scale{
    return _scaleFactor(this);
  }
}
extension ScaleFactor on int {
  double get scale{
    return _scaleFactor(this);
  }
}

const appSpace = 8.0;