import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/group/group_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/components/pick_image.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class GroupSetupScreen extends GetView<GroupController> {
  const GroupSetupScreen({super.key});

  static const String routeName = '/GroupSetupScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'group_setup'.tr,
        isBack: true,
        onBack: () {
          Get.back();
          controller.onCloseTransaction();
        },
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        label: 'save'.tr,
        onTap: () async {
          if (!controller.keyForm.currentState!.validate()) {
            return;
          }
          //
          // if (isUpdate) {
          //   var pathUpdate = recordImgPath;
          //   if (imgListener.value != recordImgPath) {
          //     pathUpdate = await ImageStorageService.saveImageToSecureDir(
          //       File(imgListener.value),
          //       path: recordImgPath,
          //     );
          //   }
          //   final Map<String, dynamic> groupData = {
          //     'code': groupCodeCtr.text.trim(),
          //     'description': groupDescEn.text.trim(),
          //     'description_2': groupDescKH.text.trim(),
          //     'displayLang': disPlayLanguageListener.value.name.toUpperCase(),
          //     'active': 1,
          //     'imgPath': pathUpdate,
          //   };
          //   final result = await controller.onUpdateGroup(arg: groupData);
          //   if (result) {
          //     Get.back();
          //     showMessage(
          //         msg: '${groupData['code']} ${'updated'.tr}',
          //         status: Status.success);
          //   }
          //   return;
          // }

          var imgPath = controller.imgListener.value;
          if (imgPath.isNotEmpty) {
            imgPath = await ImageStorageService.initImgPathTmp(
              File(controller.imgListener.value),
            );
          }

          final Map<String, dynamic> groupData = {
            'code': controller.groupCodeCtr.text.trim(),
            'description': controller.groupDescEn.text.trim(),
            'description_2': controller.groupDescKH.text.trim(),
            'displayLang': controller.displayLanguage.value.name.toUpperCase(),
            'active': 1,
            'imgPath': imgPath,
          };
          final result = await controller.onCreateGroupItem(arg: groupData);
          if (result) {
            if (imgPath.isNotEmpty) {
              await ImageStorageService.saveImageToSecureDir(
                File(controller.imgListener.value),
                path: imgPath,
              );
            }
            Get.back();
          }
        },
      ),
      body: Form(
        key: controller.keyForm,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
          child: Column(
            children: [
              SizedBox(height: 4.scale),
              Obx(
                () {
                  return BoxWidget(
                    onTap: () => _pickImage(),
                    height: 160.scale,
                    child: ImageWidget(
                      imgPath: controller.imgListener.value,
                    ),
                  );
                },
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                controller: controller.groupCodeCtr,
                labelOuter: 'group_code'.tr,
                hintText: '${'type_your'.tr} ${'group_code'.tr} ${'here'}...',
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'please_input_group_code'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: appSpace.scale),
              Obx(
                () {
                  return Row(
                    children: [
                      Expanded(
                        child: RadioListTile.adaptive(
                          title: TextWidget(text: 'khmer'.tr),
                          value: controller.displayLanguage.value,
                          groupValue: Language.kh,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: appSpace.scale),
                          dense: true,
                          onChanged: (value) {
                            controller.displayLanguage.value = Language.kh;
                          },
                          fillColor:
                              const WidgetStatePropertyAll(kPrimaryColor),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile.adaptive(
                            value: controller.displayLanguage.value,
                            title: TextWidget(text: 'english'.tr),
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: appSpace.scale),
                            groupValue: Language.en,
                            onChanged: (value) {
                              controller.displayLanguage.value = Language.en;
                            },
                            fillColor:
                                const WidgetStatePropertyAll(kPrimaryColor)),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: appSpace.scale),
              InputTextWidget(
                controller: controller.groupDescEn,
                labelOuter: 'description'.tr,
                hintText: '${'type_your_description_here'.tr}...',
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'please_input_group_description'.tr;
                  }
                  return null;
                },
                maxLine: 2,
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                controller: controller.groupDescKH,
                labelOuter: 'description_2'.tr,
                hintText: '${'type_your_description_here'.tr}...',
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'please_input_group_description'.tr;
                  }
                  return null;
                },
                maxLine: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final img = await customPickImageGallery(isEnableCrop: true);
    if (img == null) {
      return;
    }
    controller.imgListener.value = img.path;
  }
}
