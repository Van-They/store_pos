import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/item/components/fetch_group_item_screen.dart';
import 'package:store_pos/screen/merchant/item/item_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/components/image_cropper.dart';
import 'package:store_pos/widget/components/pick_image.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class ItemSetUpScreen extends StatefulWidget {
  const ItemSetUpScreen({super.key});
  static const String routeName = '/ItemSetUpScreen';

  @override
  State<ItemSetUpScreen> createState() => _ItemSetUpScreenState();
}

class _ItemSetUpScreenState extends State<ItemSetUpScreen> {
  late ItemController _controller;
  final ValueNotifier<Language> _disPlayLanguageListener =
      ValueNotifier(Language.kh);
  final _groupCodeCtr = TextEditingController();
  final _itemCode = TextEditingController();
  final _groupDescEn = TextEditingController();
  final _groupDescKH = TextEditingController();
  @override
  void initState() {
    _controller = Get.find<ItemController>();
    super.initState();
  }

  @override
  void dispose() {
    _groupCodeCtr.dispose();
    _itemCode.dispose();
    _groupDescEn.dispose();
    _groupDescKH.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'item_set_up'),
      bottomNavigationBar: PrimaryBtnWidget(
        label: 'create'.tr,
        onTap: _onCreateItem,
      ),
      body: ListView(
        padding: EdgeInsets.all(appSpace.scale),
        children: [
          SizedBox(height: appSpace.scale),
          Obx(() {
            return BoxWidget(
              onTap: _pickImage,
              height: 160.scale,
              child: ImageWidget(
                imgPath: _controller.imgPath.string,
              ),
            );
          }),
          SizedBox(height: 15.scale),
          InputTextWidget(
            controller: _itemCode,
            labelOuter: 'item_code'.tr,
            hintText: '${'type_your'.tr} ${'item_code'.tr} ${'here'}...',
          ),
          SizedBox(height: 15.scale),
          ValueListenableBuilder(
            valueListenable: _disPlayLanguageListener,
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
                        _disPlayLanguageListener.value = Language.kh;
                      },
                      fillColor: const MaterialStatePropertyAll(kPrimaryColor),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile.adaptive(
                        value: value,
                        title: TextWidget(text: 'english'.tr),
                        dense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: appSpace.scale),
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
          SizedBox(height: 15.scale),
          InputTextWidget(
            controller: _groupCodeCtr,
            readOnly: true,
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
            controller: _groupDescEn,
            labelOuter: 'description'.tr,
            hintText: '${'type_your_description_here'.tr}...',
            maxLine: 2,
          ),
          SizedBox(height: 15.scale),
          InputTextWidget(
            controller: _groupDescKH,
            labelOuter: 'description_2'.tr,
            hintText: '${'type_your_description_here'.tr}...',
            maxLine: 2,
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    final img = await customPickImageGallery();
    if (img == null) {
      return;
    }
    final imgCrop = await customCropImage(imgFile: img);
    if (imgCrop == null) {
      return;
    }
    // _controller.imgPath.value = imgCrop.path;
  }

  void _onCreateItem() async {
    final Map<String, dynamic> itemData = {
      'code': _itemCode.text.trim(),
      'groupCode': _groupCodeCtr.text.trim(),
      'description': _groupDescEn.text.trim(),
      'description_2': _groupDescKH.text.trim(),
      'displayLang': _disPlayLanguageListener.value.name.toUpperCase(),
      'imgPath': '',
    };
    final result = await _controller.onCreateItem(arg: itemData);
    if (result) {
      Get.back();
    }
  }
}
