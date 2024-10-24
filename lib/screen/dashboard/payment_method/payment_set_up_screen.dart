import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/payment_method/payment_method_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/components/custom_dialog.dart';
import 'package:store_pos/widget/components/pick_image.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class PaymentSetupScreen extends GetView<PaymentMethodController> {
  const PaymentSetupScreen({super.key});

  static const String routeName = "/PaymentSetupScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "set_up_payment_method".tr,
        isBack: true,
        onBack: () {
          Get.back(closeOverlays: true);
        },
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
                      final img = await customPickImageGallery();
                      if (img == null) {
                        return;
                      }
                      controller.imageListener.value = img.path;
                    },
                    height: 160.scale,
                    child: ImageWidget(
                      imgPath: controller.imageListener.value,
                    ),
                  ),
                  if (controller.imageListener.isNotEmpty)
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          controller.imageListener.value = '';
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
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "please_input_code".tr;
                  }
                  return null;
                },
                controller: controller.codeCtr,
                labelOuter: 'payment_code'.tr,
                hintText: '${'type_your'.tr} ${'payment_code'.tr} ${'here'}...',
              ),
              SizedBox(height: 15.scale),
              TextWidget(text: 'display_language'.tr),
              Obx(() {
                return Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: TextWidget(text: 'khmer'.tr),
                        value: controller.language.value,
                        groupValue: Language.kh,
                        splashRadius: appSpace,
                        contentPadding: EdgeInsets.only(
                          right: appSpace.scale,
                        ),
                        dense: true,
                        onChanged: (value) {
                          controller.language.value = Language.kh;
                        },
                        fillColor: const WidgetStatePropertyAll(
                          kPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        value: controller.language.value,
                        title: TextWidget(text: 'english'.tr),
                        dense: true,
                        contentPadding: EdgeInsets.only(right: appSpace.scale),
                        groupValue: Language.en,
                        onChanged: (value) {
                          controller.language.value = Language.en;
                        },
                        fillColor: const WidgetStatePropertyAll(
                          kPrimaryColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              }),
              SizedBox(height: 15.scale),
              InputTextWidget(
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "please_input_description".tr;
                  }
                  return null;
                },
                controller: controller.descEnCtr,
                labelOuter: 'description'.tr,
                hintText: '${'type_your_description_here'.tr}...',
                maxLine: 2,
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "please_input_description".tr;
                  }
                  return null;
                },
                controller: controller.descKhCtr,
                labelOuter: 'description_2'.tr,
                hintText: '${'type_your_description_here'.tr}...',
                maxLine: 2,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        label: 'save'.tr,
        onTap: () {
          if (!controller.formState.currentState!.validate()) {
            return;
          }
          showYesNoDialog(
            content:
            "${"do_want_to_create_new_payment_method".tr} ${controller.codeCtr
                .text.trim()} ?",
            onConfirm: () async {
              File imageFile = File(controller.imageListener.value);
              var imagePath = controller.imageListener.value;
              if (imagePath.isNotEmpty) {
                imagePath = await ImageStorageService.initImgPathTmp(imageFile);
              }
              final Map<String, dynamic> paymentMethod = <String, dynamic>{
                'code': controller.codeCtr.text.toUpperCase(),
                'description': controller.descEnCtr.text,
                'description_2': controller.descKhCtr.text,
                'displayLang': controller.language.value.name.toUpperCase(),
                'imagePath': imagePath,
              };

              final result =
              await controller.onCreatePaymentMethod(arg: paymentMethod);
              if (result) {
                //when create success copy file to app directory
                if (imagePath.isNotEmpty) {
                  await ImageStorageService.saveImageToSecureDir(
                    imageFile,
                    path: imagePath,
                  );
                }
                if (context.mounted) {
                  Get.back(closeOverlays: true);
                }
              } else {
                Get.back();
              }
            },
          );
        },
      ),
    );
  }
}
