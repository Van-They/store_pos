import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/item/components/update_item_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/components/pick_image.dart';
import 'package:store_pos/widget/empty_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/loading_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class UpdateItemScreen extends GetView<UpdateItemController> {
  const UpdateItemScreen({super.key});

  static const String routeName = "/UpdateItemScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'update_item'.tr,
        isBack: true,
      ),
      body: Obx(
        () {
          return SingleChildScrollView(
            padding: EdgeInsets.all(appPadding.scale),
            child: Form(
              key: controller.formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: appSpace.scale),
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
                  SizedBox(height: 15.scale),
                  InputTextWidget(
                    readOnly: true,
                    onTap: () {
                      showMessage(
                        msg: 'not_allow_to_edit'.tr,
                        status: Status.failed,
                      );
                    },
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "please_input_code".tr;
                      }
                      return null;
                    },
                    controller: controller.itemCodeCtr,
                    labelOuter: 'item_code'.tr,
                    hintText:
                        '${'type_your'.tr} ${'item_code'.tr} ${'here'}...',
                  ),
                  SizedBox(height: 15.scale),
                  TextWidget(text: 'display_language'.tr),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: TextWidget(text: 'khmer'.tr),
                          value: controller.language.value,
                          groupValue: Language.kh,
                          splashRadius: appSpace,
                          contentPadding:
                              EdgeInsets.only(right: appSpace.scale),
                          dense: true,
                          onChanged: (value) {
                            controller.language.value = Language.kh;
                          },
                          fillColor:
                              const MaterialStatePropertyAll(kPrimaryColor),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                            value: controller.language.value,
                            title: TextWidget(text: 'english'.tr),
                            dense: true,
                            contentPadding:
                                EdgeInsets.only(right: appSpace.scale),
                            groupValue: Language.en,
                            onChanged: (value) {
                              controller.language.value = Language.en;
                            },
                            fillColor:
                                const MaterialStatePropertyAll(kPrimaryColor)),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: 15.scale),
                  Row(
                    children: [
                      Expanded(
                        child: InputTextWidget(
                          textInputType: TextInputType.number,
                          suffixIcon: Icon(FontAwesomeIcons.dollarSign,size: 14.scale,),
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
                          suffixIcon: Icon(FontAwesomeIcons.dollarSign,size: 14.scale,),
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
                          hintText: 'unit_price'.tr,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.scale),
                  InputTextWidget(
                    controller: controller.groupCodeCtr,
                    readOnly: true,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "please_select_group_code".tr;
                      }
                      return null;
                    },
                    onTap: () {
                      showMessage(
                        msg: 'not_allow_to_edit'.tr,
                        status: Status.failed,
                      );
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
                    controller: controller.descKHCtr,
                    labelOuter: 'description_2'.tr,
                    hintText: '${'type_your_description_here'.tr}...',
                    maxLine: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        label: 'update'.tr,
        onTap: () async {
          if (!controller.formState.currentState!.validate()) {
            return;
          }

          var imagePath = controller.itemUpdate.value.imgPath;
          if (imagePath.isNotEmpty) {
            if (controller.imageListener.value != imagePath) {
              imagePath = await ImageStorageService.saveImageToSecureDir(
                File(controller.imageListener.value),
                path: imagePath,
              );
            }
          } else {
            final tmpImg = await ImageStorageService.initImgPathTmp(
                File(controller.imageListener.value));

            imagePath = await ImageStorageService.saveImageToSecureDir(
                File(controller.imageListener.value),
                path: tmpImg);
          }

          final Map<String, dynamic> itemData = {
            'code': controller.itemCodeCtr.text.trim(),
            'groupCode': controller.groupCodeCtr.text.trim(),
            'description': controller.descEnCtr.text.trim(),
            'description_2': controller.descKHCtr.text.trim(),
            'qty': '${controller.itemUpdate.value.qty}',
            'cost': controller.itemCostCtr.text.trim(),
            'active': 1,
            'unitPrice': controller.unitPriceCtr.text.trim(),
            'displayLang': controller.language.value.name.toUpperCase(),
            'imgPath': imagePath,
          };

          final result = await controller.onUpdateItem(arg: itemData);
          if (!result) return;
          if (context.mounted) {
            Navigator.pop(context, AppState.updated);
          }
        },
      ),
    );
  }
}
