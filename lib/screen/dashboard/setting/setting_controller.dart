import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  late TextEditingController phoneNumberCtr;
  late TextEditingController exchangeRateCtr;
  late TextEditingController addressCtr;

  @override
  void onClose() {
    phoneNumberCtr.dispose();
    exchangeRateCtr.dispose();
    addressCtr.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    phoneNumberCtr = TextEditingController();
    exchangeRateCtr = TextEditingController();
    addressCtr = TextEditingController();
    super.onInit();
  }
}
