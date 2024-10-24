import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/customer/customer_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class CustomerUpdate extends GetView<CustomerController> {
  const CustomerUpdate({super.key});

  static const String routeName = "/CustomerUpdate";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "customer_update".tr,
        isBack: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding.scale),
        child: Form(
          key: controller.formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: appSpace.scale),
              Obx(() {
                return Stack(children: [
                  BoxWidget(
                    onTap: () async {
                      controller.onPickImage();
                    },
                    height: 160.scale,
                    child: ImageWidget(
                      imgPath: controller.imagePath.value,
                    ),
                  ),
                  if (controller.imagePath.isNotEmpty)
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          controller.imagePath.value = '';
                        },
                        icon: Icon(
                          FontAwesomeIcons.xmark,
                          size: 18.scale,
                          color: kRed,
                        ),
                      ),
                    ),
                ]);
              }),
              SizedBox(height: 15.scale),
              InputTextWidget(
                isMark: true,
                readOnly: true,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "required".tr;
                  }
                  return null;
                },
                controller: controller.codeCtr,
                labelOuter: 'customer_code'.tr,
                hintText: 'customer_code'.tr,
              ),
              SizedBox(height: 15.scale),
              Row(
                children: [
                  Expanded(
                    child: InputTextWidget(
                      isMark: true,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "required".tr;
                        }
                        return null;
                      },
                      controller: controller.firstNameCtr,
                      labelOuter: 'first_name'.tr,
                      hintText: 'first_name'.tr,
                    ),
                  ),
                  SizedBox(width: appSpace.scale),
                  Expanded(
                    child: InputTextWidget(
                      isMark: true,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "required".tr;
                        }
                        return null;
                      },
                      controller: controller.lastNameCtr,
                      labelOuter: 'last_name'.tr,
                      hintText: 'last_name'.tr,
                    ),
                  ),
                ],
              ),
              SizedBox(height: appSpace.scale),
              TextWidget(text: 'date_of_birth'.tr),
              SizedBox(height: appSpace.scale),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InputTextWidget(
                      textInputType: TextInputType.number,
                      controller: controller.dayCtr,
                      labelOuter: 'day'.tr,
                      hintText: 'day'.tr,
                    ),
                  ),
                  SizedBox(width: appSpace.scale),
                  Expanded(
                    flex: 1,
                    child: InputTextWidget(
                      textInputType: TextInputType.number,
                      controller: controller.monthCtr,
                      labelOuter: 'month'.tr,
                      hintText: 'month'.tr,
                    ),
                  ),
                  SizedBox(width: appSpace.scale),
                  Expanded(
                    flex: 2,
                    child: InputTextWidget(
                      textInputType: TextInputType.number,
                      controller: controller.yearCtr,
                      labelOuter: 'year'.tr,
                      hintText: 'year'.tr,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                controller: controller.phoneNumberCtr,
                textInputType: TextInputType.phone,
                labelOuter: 'phone_number'.tr,
                hintText: 'phone_number'.tr,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        onTap: () {
          controller.updateCustomer();
        },
        label: 'update'.tr,
      ),
    );
  }
}
