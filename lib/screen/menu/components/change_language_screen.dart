import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/screen/menu/controller/language_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class ChangeLanguageScreen extends GetView<LanguageController> {
  const ChangeLanguageScreen({super.key});

  static const String routeName = "/ChangeLanguageScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'language'.tr,
        isBack: true,
      ),
      body: Obx(
        () => Column(
          children: [
            RadioListTile(
              value: controller.language.value,
              groupValue: "km",
              activeColor: kPrimaryColor,
              title: TextWidget(text: "khmer".tr),
              onChanged: (value) {
                controller.language.value = "km";
                controller.saveChange("km");
                Get.updateLocale(const Locale('km', 'KH'));
              },
            ),
            RadioListTile(
              value: controller.language.value,
              groupValue: Language.en.name,
              activeColor: kPrimaryColor,
              title: TextWidget(text: "english".tr),
              onChanged: (value) {
                controller.language.value = Language.en.name;
                controller.saveChange(Language.en.name);
                Get.updateLocale(const Locale('en', 'US'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
