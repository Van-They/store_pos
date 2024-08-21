import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/setting/setting_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  static const String routeName = '/SettingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        isBack: true,
        title: 'setting'.tr,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(appSpace.scale),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showMessage(msg: "Click image");
                },
                child: Stack(
                  children: [
                    ImageWidget(
                      imgPath: '',
                      width: 150.scale,
                      height: 150.scale,
                    ),
                    Positioned(
                      right: 1,
                      child: Icon(
                        Icons.edit,
                        size: 18.scale,
                        color: kPrimaryColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: appSpace.scale),
              GestureDetector(
                onTap: () {
                  showMessage(msg: "Click name khmer");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(text: 'Company Name Khmer', fontSize: 18.scale),
                    SizedBox(
                      width: appSpace.scale,
                    ),
                    Icon(
                      Icons.edit,
                      size: 18.scale,
                      color: kPrimaryColor,
                    )
                  ],
                ),
              ),
              SizedBox(height: appSpace.scale),
              GestureDetector(
                onTap: () {
                  showMessage(msg: "Click Company name eng");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(text: 'Company Name', fontSize: 18.scale),
                    SizedBox(
                      width: appSpace.scale,
                    ),
                    Icon(
                      Icons.edit,
                      size: 18.scale,
                      color: kPrimaryColor,
                    )
                  ],
                ),
              ),
              SizedBox(height: appSpace.scale),
              InputTextWidget(
                controller: controller.phoneNumberCtr,
                labelOuter: 'phone_number'.tr,
                hintText: 'phone_number'.tr,
              ),
              SizedBox(height: appSpace.scale),
              const Row(
                children: [
                  TextWidget(text: 'display_currency'),
                ],
              ),
              Row(
                children: [
                  RadioMenuButton(
                    value: "riel",
                    groupValue: "riel",
                    onChanged: (value) {},
                    child: TextWidget(text: "riel".tr),
                  ),
                  RadioMenuButton(
                    value: "usd",
                    groupValue: "riel",
                    onChanged: (value) {},
                    child: TextWidget(text: "usd".tr),
                  ),
                ],
              ),
              SizedBox(height: appSpace.scale),
              InputTextWidget(
                controller: controller.exchangeRateCtr,
                labelOuter: 'exchange_rate'.tr,
                hintText: '1\$ = 4100r'.tr,
              ),
              SizedBox(height: appSpace.scale),
              InputTextWidget(
                controller: controller.addressCtr,
                labelOuter: 'address'.tr,
                maxLine: 5,
                hintText: 'address'.tr,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        onTap: () {},
        label: 'save'.tr,
      ),
    );
  }
}
