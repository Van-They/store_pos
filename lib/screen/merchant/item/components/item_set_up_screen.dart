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

class ItemSetUpScreen extends StatefulWidget {
  const ItemSetUpScreen({super.key, this.isUpdate = false});
  static const String routeName = '/ItemSetUpScreen';
  final bool isUpdate;

  @override
  State<ItemSetUpScreen> createState() => _ItemSetUpScreenState();
}

class _ItemSetUpScreenState extends State<ItemSetUpScreen> {
  late ItemController _imgCtr;
  final ValueNotifier<Language> _disPlayLanguageListener =
      ValueNotifier(Language.kh);
  final ValueNotifier<String> _imgListener = ValueNotifier('');
  final _groupCodeCtr = TextEditingController();
  final _itemCodeCtr = TextEditingController();
  final _itemCostCtr = TextEditingController();
  final _itemQtyCtr = TextEditingController();
  final _itemNewQtyCtr = TextEditingController();
  final _unitPriceCtr = TextEditingController();
  final _groupDescEnCtr = TextEditingController();
  final _groupDescKHCtr = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    _imgCtr = Get.find<ItemController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'item_set_up'.tr,
        isBack: true,
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        label: 'create'.tr,
        onTap: _onCreateItem,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding.scale),
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: appSpace.scale),
              ValueListenableBuilder(
                valueListenable: _imgListener,
                builder: (context, value, child) {
                  return BoxWidget(
                    onTap: _pickImage,
                    height: 160.scale,
                    child: ImageWidget(
                      imgPath: value,
                    ),
                  );
                },
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "please_input_code".tr;
                  }
                  return null;
                },
                controller: _itemCodeCtr,
                labelOuter: 'item_code'.tr,
                hintText: '${'type_your'.tr} ${'item_code'.tr} ${'here'}...',
              ),
              SizedBox(height: 15.scale),
              TextWidget(text: 'display_language'.tr),
              ValueListenableBuilder(
                valueListenable: _disPlayLanguageListener,
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
                            _disPlayLanguageListener.value = Language.kh;
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
                              _disPlayLanguageListener.value = Language.en;
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
                      controller: _itemQtyCtr,
                      labelOuter: 'qty'.tr,
                      hintText: 'item_qty'.tr,
                    ),
                  ),
                  if (widget.isUpdate) SizedBox(width: appSpace.scale),
                  if (widget.isUpdate)
                    Expanded(
                      child: InputTextWidget(
                        textInputType: TextInputType.number,
                        readOnly: true,
                        inputFormatter: [
                          FilteringTextInputFormatter.deny('-'),
                          FilteringTextInputFormatter.deny(','),
                          FilteringTextInputFormatter.deny(' '),
                          FilteringTextInputFormatter.deny('..'),
                        ],
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "please_input_new_qty".tr;
                          }
                          return null;
                        },
                        controller: _itemNewQtyCtr,
                        labelOuter: 'new_qty'.tr,
                        hintText: 'item_qty'.tr,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 15.scale),
              Row(
                children: [
                  Expanded(
                    child: InputTextWidget(
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "please_input_cost".tr;
                        }
                        return null;
                      },
                      controller: _itemCostCtr,
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
                      controller: _unitPriceCtr,
                      labelOuter: 'unit_price'.tr,
                      hintText: 'unit_price'.tr,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.scale),
              InputTextWidget(
                controller: _groupCodeCtr,
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
                      _groupCodeCtr.text = value['group_code'];
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
                controller: _groupDescEnCtr,
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
                controller: _groupDescKHCtr,
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

  void _pickImage() async {
    final img = await customPickImageGallery();
    if (img == null) {
      return;
    }
    _imgListener.value = img.path;
  }

  void _onCreateItem() async {
    if (_globalKey.currentState!.validate()) {
      return;
    }
    final imgUrl = await ImageStorageService.saveImageToSecureDir(
        File(_imgListener.value));
    final Map<String, dynamic> itemData = {
      'code': _itemCodeCtr.text.trim(),
      'groupCode': _groupCodeCtr.text.trim(),
      'description': _groupDescEnCtr.text.trim(),
      'description_2': _groupDescKHCtr.text.trim(),
      'qty': _itemQtyCtr.text.trim(),
      'cost': _itemCostCtr.text.trim(),
      'unitPrice': _unitPriceCtr.text.trim(),
      'displayLang': _disPlayLanguageListener.value.name.toUpperCase(),
      'imgPath': imgUrl,
    };
    final result = await _imgCtr.onCreateItem(arg: itemData);
    if (result) {
      Get.back();
    }
  }
}
