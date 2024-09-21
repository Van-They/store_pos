import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/item/components/fetch_group_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/item_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/components/custom_dialog.dart';
import 'package:store_pos/widget/components/pick_image.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class SetupItemScreen extends GetView<ItemController> {
  const SetupItemScreen({super.key});

  static const String routeName = '/SetupItemScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'item_set_up'.tr,
        isBack: true,
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        label: 'save'.tr,
        onTap: () {
          if (!controller.formState.currentState!.validate()) {
            return;
          }
          showYesNoDialog(
            content:
                "${"do_want_to_create_new_item".tr} ${controller.itemCodeCtr.text.trim()} ?",
            onConfirm: () async {
              File imageFile = File(controller.imageListener.value);
              var imagePath = controller.imageListener.value;
              if (imagePath.isNotEmpty) {
                imagePath = await ImageStorageService.initImgPathTmp(imageFile);
              }
              final Map<String, dynamic> itemData = {
                'code': controller.itemCodeCtr.text.trim(),
                'groupCode': controller.groupCodeCtr.text.trim(),
                'description': controller.groupDescEnCtr.text.trim(),
                'description_2': controller.groupDescKHCtr.text.trim(),
                'qty': controller.qtyCtr.text.trim(),
                'cost': controller.itemCostCtr.text.trim(),
                'active': 1,
                'unitPrice': controller.unitPriceCtr.text.trim(),
                'displayLang': controller.language.value.name.toUpperCase(),
                'imgPath': imagePath,
              };

              final result = await controller.onCreateItem(arg: itemData);
              if (result) {
                //when create success copy file to app directory
                if (imagePath.isNotEmpty) {
                  await ImageStorageService.saveImageToSecureDir(
                    imageFile,
                    path: imagePath,
                  );
                }
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          );
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding.scale),
        child:
        Form(
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
                controller: controller.itemCodeCtr,
                labelOuter: 'item_code'.tr,
                hintText: '${'type_your'.tr} ${'item_code'.tr} ${'here'}...',
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
                        fillColor: const MaterialStatePropertyAll(
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
                        fillColor: const MaterialStatePropertyAll(
                          kPrimaryColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              }),
              Row(
                children: [
                  Expanded(
                    child: InputTextWidget(
                      textInputType: TextInputType.number,
                      suffixIcon: Icon(
                        FontAwesomeIcons.dollarSign,
                        size: 14.scale,
                      ),
                      inputFormatter: [
                        FilteringTextInputFormatter.deny('-'),
                        FilteringTextInputFormatter.deny(','),
                        FilteringTextInputFormatter.deny(' '),
                        FilteringTextInputFormatter.deny('..'),
                      ],
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "please_input_cost".tr;
                        }
                        return null;
                      },
                      controller: controller.itemCostCtr,
                      labelOuter: 'cost'.tr,
                      hintText: 'item_cost'.tr,
                    ),
                  ),
                  SizedBox(width: appSpace.scale),
                  Expanded(
                    child: InputTextWidget(
                      textInputType: TextInputType.number,
                      inputFormatter: [
                        FilteringTextInputFormatter.deny('-'),
                        FilteringTextInputFormatter.deny(','),
                        FilteringTextInputFormatter.deny(' '),
                        FilteringTextInputFormatter.deny('..'),
                      ],
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "please_input_price".tr;
                        }
                        return null;
                      },
                      controller: controller.unitPriceCtr,
                      labelOuter: 'unit_price'.tr,
                      suffixIcon: Icon(
                        FontAwesomeIcons.dollarSign,
                        size: 14.scale,
                      ),
                      hintText: 'unit_price'.tr,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                controller: controller.groupCodeCtr,
                readOnly: true,
                isMark: true,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "please_select_group_code".tr;
                  }
                  return null;
                },
                onTap: () {
                  Get.toNamed(FetchGroupItemScreen.routeName)!.then((value) {
                    if (value != null) {
                      controller.groupCodeCtr.text = value['group_code'];
                    }
                  });
                },
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  size: 24.scale,
                ),
                labelOuter: 'group_code'.tr,
                hintText: '${'select'.tr} ${'group_code'.tr} ${'here'}',
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "please_input_description".tr;
                  }
                  return null;
                },
                controller: controller.groupDescEnCtr,
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
                controller: controller.groupDescKHCtr,
                labelOuter: 'description_2'.tr,
                hintText: '${'type_your_description_here'.tr}...',
                maxLine: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
