import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/service/app_service.dart';
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

class UpdateItemScreen extends StatefulWidget {
  const UpdateItemScreen({super.key});

  static const String routeName = "/UpdateItemScreen";

  @override
  State<UpdateItemScreen> createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  late UpdateItemController _controller;
  late Map? _arg;
  late String _itemCode;
  late ValueNotifier<Language> _languageListener;
  late ValueNotifier<String> _imgListener;
  late TextEditingController _groupCodeCtr;
  late TextEditingController _itemCodeCtr;
  late TextEditingController _itemCostCtr;
  late TextEditingController _itemQtyCtr;
  late TextEditingController _itemNewQtyCtr;
  late TextEditingController _unitPriceCtr;
  late TextEditingController _groupDescEnCtr;
  late TextEditingController _groupDescKHCtr;
  late ItemModel _itemModel;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    _arg = Get.arguments ?? {};
    _itemCode = _arg?['code'] ?? "";
    _controller = Get.find<UpdateItemController>();

    _init();
    super.initState();
  }

  _init() async {
    await _controller.onGetItemById(itemCode: _itemCode);
    _itemModel = _controller.itemModel.value;
    _languageListener = ValueNotifier(
      _itemModel.displayLang == Language.kh.name ? Language.kh : Language.en,
    );
    _imgListener = ValueNotifier(_itemModel.imgPath);
    _groupCodeCtr = TextEditingController(text: _itemModel.groupCode);
    _itemCodeCtr = TextEditingController(text: _itemModel.code);
    _itemCostCtr = TextEditingController(text: '${_itemModel.cost}');
    _itemQtyCtr = TextEditingController(
        text: '${AppService.convertToInt(_itemModel.qty)}');
    _itemNewQtyCtr = TextEditingController(text: '0');
    _unitPriceCtr = TextEditingController(text: '${_itemModel.unitPrice}');
    _groupDescEnCtr = TextEditingController(text: _itemModel.description);
    _groupDescKHCtr = TextEditingController(text: _itemModel.description_2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'update_item'.tr,
        isBack: true,
      ),
      body: Obx(
        () {
          if (_controller.isLoading.value) {
            return const LoadingWidget();
          }

          if (_itemModel.code.isEmpty) {
            return const EmptyWidget();
          }

          return SingleChildScrollView(
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
                        onTap: () async {
                          final img = await customPickImageGallery();
                          if (img == null) {
                            return;
                          }
                          _imgListener.value = img.path;
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
                    controller: _itemCodeCtr,
                    labelOuter: 'item_code'.tr,
                    hintText:
                        '${'type_your'.tr} ${'item_code'.tr} ${'here'}...',
                  ),
                  SizedBox(height: 15.scale),
                  TextWidget(text: 'display_language'.tr),
                  ValueListenableBuilder(
                    valueListenable: _languageListener,
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
                                _languageListener.value = Language.kh;
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
                                  _languageListener.value = Language.en;
                                },
                                fillColor: const MaterialStatePropertyAll(
                                    kPrimaryColor)),
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
                          readOnly: true,
                          textInputType: TextInputType.number,
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onTap: () {
                            showMessage(
                              msg: 'not_allow_to_edit'.tr,
                              status: Status.failed,
                            );
                          },
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
          );
        },
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        label: 'update'.tr,
        onTap: () async {
          if (!_globalKey.currentState!.validate()) {
            return;
          }
          var imagePath = _itemModel.imgPath;
          if (imagePath.isNotEmpty) {
            if (_imgListener.value != imagePath) {
              imagePath = await ImageStorageService.saveImageToSecureDir(
                File(_imgListener.value),
                path: imagePath,
              );
            }
          } else {
            final tmpImg = await ImageStorageService.initImgPathTmp(
                File(_imgListener.value));

            imagePath = await ImageStorageService.saveImageToSecureDir(
                File(_imgListener.value),
                path: tmpImg);
          }

          final Map<String, dynamic> itemData = {
            'code': _itemCodeCtr.text.trim(),
            'groupCode': _groupCodeCtr.text.trim(),
            'description': _groupDescEnCtr.text.trim(),
            'description_2': _groupDescKHCtr.text.trim(),
            'qty': _itemNewQtyCtr.text == '0'
                ? _itemQtyCtr.text
                : _itemNewQtyCtr.text,
            'cost': _itemCostCtr.text.trim(),
            'active': 1,
            'unitPrice': _unitPriceCtr.text.trim(),
            'displayLang': _languageListener.value.name.toUpperCase(),
            'imgPath': imagePath,
          };

          final result = await _controller.onUpdateItem(arg: itemData);
          if (!result) return;
          if (mounted) {
            Navigator.pop(context, AppState.updated);
          }
        },
      ),
    );
  }
}
