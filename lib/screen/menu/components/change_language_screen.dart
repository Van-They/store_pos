import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  static const String routeName = "/ChangeLanguageScreen";

  @override
  Widget build(BuildContext context) {
    String lang = "Kh";
    return Scaffold(
      appBar: AppBarWidget(
        title: 'language'.tr,
        isBack: true,
      ),
      body: Column(
        children: [
          RadioListTile(
            value: lang,
            groupValue: "Kh",
            activeColor: kPrimaryColor,
            title: TextWidget(text: "khmer".tr),
            onChanged: (value) {
              lang = "Kh";
            },
          ),
          RadioListTile(
            value: lang,
            groupValue: "En",
            activeColor: kPrimaryColor,
            title: TextWidget(text: "english".tr),
            onChanged: (value) {
              lang = "En";
            },
          ),
        ],
      ),
    );
  }
}
