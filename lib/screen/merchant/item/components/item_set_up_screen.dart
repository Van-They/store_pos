import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/item/components/fetch_group_item_screen.dart';
import 'package:store_pos/screen/merchant/item/item_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/components/pick_image.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class ItemSetUpScreen extends GetView<ItemController> {
  const ItemSetUpScreen({super.key, this.isUpdate = false});

  static const String routeName = '/ItemSetUpScreen';
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments ?? {};
    final isUpdate = arguments['isUpdate'] ?? false;
    final recordImgPath = arguments['imgPath'] ?? '';
    final recordCode = arguments['code'];
    final recordGroupCode = arguments['group_code'];
    final recordDesc = arguments['description'];
    final recordDesc2 = arguments['description_2'];
    final recordDisLang = arguments['display_language'] ?? 'KH';
    final recordQty = arguments['qty'] ?? '0';
    final recordCost = arguments['cost'] ?? '0';
    final recordPrice = arguments['price'] ?? '0';
    final language = recordDisLang == "EN" ? Language.en : Language.kh;

    final ValueNotifier<Language> languageListener = ValueNotifier(language);
    final ValueNotifier<String> imgListener = ValueNotifier(recordImgPath);
    final groupCodeCtr = TextEditingController(text: recordGroupCode);
    final itemCodeCtr = TextEditingController(text: recordCode);
    final itemCostCtr = TextEditingController(text: recordCost);
    final itemQtyCtr = TextEditingController(text: recordQty);
    final itemNewQtyCtr = TextEditingController();//TODO: update
    final unitPriceCtr = TextEditingController(text: recordPrice);
    final groupDescEnCtr = TextEditingController(text: recordDesc);
    final groupDescKHCtr = TextEditingController(text: recordDesc2);
    final globalKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBarWidget(
        title: 'item_set_up'.tr,
        isBack: true,
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        label: isUpdate ? 'update'.tr : 'create'.tr,
        onTap: () async {
          if (!globalKey.currentState!.validate()) {
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
            final Map<String, dynamic> itemData = {
              'code': itemCodeCtr.text.trim(),
              'groupCode': groupCodeCtr.text.trim(),
              'description': groupDescEnCtr.text.trim(),
              'description_2': groupDescKHCtr.text.trim(),
              'qty': itemQtyCtr.text.trim(),
              'cost': itemCostCtr.text.trim(),
              'active': 1,
              'unitPrice': unitPriceCtr.text.trim(),
              'displayLang': languageListener.value.name.toUpperCase(),
              'imgPath': pathUpdate,
            };

            final result = await controller.onUpdateItem(arg: itemData);
            if (result) {
              Get.back();
            }

            return;
          }

          final impPath = await ImageStorageService.initImgPathTmp(
            File(imgListener.value),
          );
          final Map<String, dynamic> itemData = {
            'code': itemCodeCtr.text.trim(),
            'groupCode': groupCodeCtr.text.trim(),
            'description': groupDescEnCtr.text.trim(),
            'description_2': groupDescKHCtr.text.trim(),
            'qty': itemQtyCtr.text.trim(),
            'cost': itemCostCtr.text.trim(),
            'active': 1,
            'unitPrice': unitPriceCtr.text.trim(),
            'displayLang': languageListener.value.name.toUpperCase(),
            'imgPath': impPath,
          };
          final result = await controller.onCreateItem(arg: itemData);
          if (result) {
            await ImageStorageService.saveImageToSecureDir(
              File(imgListener.value),
              path: impPath,
            );
            Get.back();
          }
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding.scale),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: appSpace.scale),
              ValueListenableBuilder(
                valueListenable: imgListener,
                builder: (context, value, child) {
                  return BoxWidget(
                    onTap: () async {
                      final img = await customPickImageGallery();
                      if (img == null) {
                        return;
                      }
                      imgListener.value = img.path;
                    },
                    height: 160.scale,
                    child: ImageWidget(
                      imgPath: value,
                    ),
                  );
                },
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                readOnly: isUpdate,
                onTap: () {
                  if (isUpdate) {
                    showMessage(
                      msg: 'not_allow_to_edit'.tr,
                      status: Status.failed,
                    );
                  }
                },
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "please_input_code".tr;
                  }
                  return null;
                },
                controller: itemCodeCtr,
                labelOuter: 'item_code'.tr,
                hintText: '${'type_your'.tr} ${'item_code'.tr} ${'here'}...',
              ),
              SizedBox(height: 15.scale),
              TextWidget(text: 'display_language'.tr),
              ValueListenableBuilder(
                valueListenable: languageListener,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: TextWidget(text: 'khmer'.tr),
                          value: value,
                          groupValue: Language.kh,
                          splashRadius: appSpace,
                          contentPadding:
                              EdgeInsets.only(right: appSpace.scale),
                          dense: true,
                          onChanged: (value) {
                            languageListener.value = Language.kh;
                          },
                          fillColor:
                              const MaterialStatePropertyAll(kPrimaryColor),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                            value: value,
                            title: TextWidget(text: 'english'.tr),
                            dense: true,
                            contentPadding:
                                EdgeInsets.only(right: appSpace.scale),
                            groupValue: Language.en,
                            onChanged: (value) {
                              languageListener.value = Language.en;
                            },
                            fillColor:
                                const MaterialStatePropertyAll(kPrimaryColor)),
                      ),
                      const Spacer(),
                    ],
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: InputTextWidget(
                      textInputType: TextInputType.number,
                      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "please_input_qty".tr;
                        }
                        return null;
                      },
                      controller: itemQtyCtr,
                      labelOuter: 'qty'.tr,
                      hintText: 'item_qty'.tr,
                    ),
                  ),
                  if (isUpdate) SizedBox(width: appSpace.scale),
                  // if (isUpdate)
                  //   Expanded(
                  //     child: InputTextWidget(
                  //       textInputType: TextInputType.number,
                  //       readOnly: true,
                  //       inputFormatter: [
                  //         FilteringTextInputFormatter.deny('-'),
                  //         FilteringTextInputFormatter.deny(','),
                  //         FilteringTextInputFormatter.deny(' '),
                  //         FilteringTextInputFormatter.deny('..'),
                  //       ],
                  //       validator: (p0) {
                  //         if (p0 == null || p0.isEmpty) {
                  //           return "please_input_new_qty".tr;
                  //         }
                  //         return null;
                  //       },
                  //       controller: itemNewQtyCtr,
                  //       labelOuter: 'new_qty'.tr,
                  //       hintText: 'item_qty'.tr,
                  //     ),
                  //   ),
                ],
              ),
              SizedBox(height: 15.scale),
              Row(
                children: [
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
                          return "please_input_cost".tr;
                        }
                        return null;
                      },
                      controller: itemCostCtr,
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
                      controller: unitPriceCtr,
                      labelOuter: 'unit_price'.tr,
                      hintText: 'unit_price'.tr,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                controller: groupCodeCtr,
                readOnly: true,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "please_select_group_code".tr;
                  }
                  return null;
                },
                onTap: () {
                  Get.toNamed(FetchGroupItemScreen.routeName)!.then((value) {
                    if (value != null) {
                      groupCodeCtr.text = value['group_code'];
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
                controller: groupDescEnCtr,
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
                controller: groupDescKHCtr,
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
