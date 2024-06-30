import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/group/group_controller.dart';
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
    final arguments = Get.arguments ?? {};
    final isUpdate = arguments['isUpdate'] ?? false;
    final recordImgPath = arguments['imgPath'] ?? '';
    final recordCode = arguments['code'];
    final recordDesc = arguments['description'];
    final recordDesc2 = arguments['description_2'];
    final recordDisLang = arguments['display_language'] ?? 'KH';
    final language = recordDisLang == "EN" ? Language.en : Language.kh;
    final ValueNotifier<Language> disPlayLanguageListener =
        ValueNotifier(language);
    final ValueNotifier<String> imgListener = ValueNotifier(recordImgPath);
    final keyForm = GlobalKey<FormState>();
    final groupCodeCtr = TextEditingController(text: recordCode);
    final groupDescEn = TextEditingController(text: recordDesc);
    final groupDescKH = TextEditingController(text: recordDesc2);

    return Scaffold(
      appBar: AppBarWidget(
        title: 'group_setup'.tr,
        isBack: true,
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        label: 'create'.tr,
        onTap: () async {
          if (!keyForm.currentState!.validate()) {
            return;
          }

          if (isUpdate) {
            var pathUpdate = recordImgPath;
            if (imgListener.value != recordImgPath) {
              pathUpdate = await ImageStorageService.saveImageToSecureDir(
                File(imgListener.value),
                path: recordImgPath,
              );
            }
            final Map<String, dynamic> groupData = {
              'code': groupCodeCtr.text.trim(),
              'description': groupDescEn.text.trim(),
              'description_2': groupDescKH.text.trim(),
              'displayLang': disPlayLanguageListener.value.name.toUpperCase(),
              'active': 1,
              'imgPath': pathUpdate,
            };
            final result = await controller.onUpdateGroup(arg: groupData);
            if (result) {
              Get.back();
              showMessage(
                  msg: '${groupData['code']} ${'updated'.tr}',
                  status: Status.success);
            }
            return;
          }

          var imgPath = imgListener.value;
          if (imgPath.isNotEmpty) {
            imgPath = await ImageStorageService.initImgPathTmp(
              File(imgListener.value),
            );
          }

          final Map<String, dynamic> groupData = {
            'code': groupCodeCtr.text.trim(),
            'description': groupDescEn.text.trim(),
            'description_2': groupDescKH.text.trim(),
            'displayLang': disPlayLanguageListener.value.name.toUpperCase(),
            'active': 1,
            'imgPath': imgPath,
          };
          final result = await controller.onCreateGroupItem(arg: groupData);
          if (result) {
            if (imgPath.isNotEmpty) {
              await ImageStorageService.saveImageToSecureDir(
                File(imgListener.value),
                path: imgPath,
              );
            }
            Get.back();
          }
        },
      ),
      body: Form(
        key: keyForm,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
          child: Column(
            children: [
              SizedBox(height: 4.scale),
              ValueListenableBuilder(
                valueListenable: imgListener,
                builder: (context, value, child) {
                  return BoxWidget(
                    onTap: () => _pickImage(imgListener),
                    height: 160.scale,
                    child: ImageWidget(
                      imgPath: value,
                    ),
                  );
                },
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                controller: groupCodeCtr,
                readOnly: isUpdate,
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
              ValueListenableBuilder(
                valueListenable: disPlayLanguageListener,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: RadioListTile.adaptive(
                          title: TextWidget(text: 'khmer'.tr),
                          value: value,
                          groupValue: Language.kh,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: appSpace.scale),
                          dense: true,
                          onChanged: (value) {
                            disPlayLanguageListener.value = Language.kh;
                          },
                          fillColor:
                              const MaterialStatePropertyAll(kPrimaryColor),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile.adaptive(
                            value: value,
                            title: TextWidget(text: 'english'.tr),
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: appSpace.scale),
                            groupValue: Language.en,
                            onChanged: (value) {
                              disPlayLanguageListener.value = Language.en;
                            },
                            fillColor:
                                const MaterialStatePropertyAll(kPrimaryColor)),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: appSpace.scale),
              InputTextWidget(
                controller: groupDescEn,
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
                controller: groupDescKH,
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

  void _pickImage(ValueNotifier<String> imgListener) async {
    final img = await customPickImageGallery(isEnableCropp: true);
    if (img == null) {
      return;
    }
    imgListener.value = img.path;
  }
}
