import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/group/group_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/components/image_cropper.dart';
import 'package:store_pos/widget/components/pick_image.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class GroupSetupScreen extends StatefulWidget {
  const GroupSetupScreen({super.key});

  static const String routeName = '/GroupSetupScreen';

  @override
  State<GroupSetupScreen> createState() => _GroupSetupScreenState();
}

class _GroupSetupScreenState extends State<GroupSetupScreen> {
  final ValueNotifier<Language> _disPlayLanguageListener =
      ValueNotifier(Language.kh);
  late GroupController _controller;
  final _groupCodeCtr = TextEditingController();
  final _groupDescEn = TextEditingController();
  final _groupDescKH = TextEditingController();

  @override
  void initState() {
    _controller =
        Get.find<GroupController>(); //don't dispost it use in groupitem screen
    super.initState();
  }

  @override
  void dispose() {
    _groupCodeCtr.dispose();
    _groupDescEn.dispose();
    _groupDescKH.dispose();
    _disPlayLanguageListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBarWidget(title: 'group_setup'.tr),
      bottomNavigationBar: PrimaryBtnWidget(
        label: 'create'.tr,
        onTap: _onCreateGroup,
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
            controller: _groupCodeCtr,
            labelOuter: 'group_code'.tr,
            hintText: '${'type_your'.tr} ${'group_code'.tr} ${'here'}...',
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
                ],
              );
            },
          ),
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
    _controller.imgPath.value = imgCrop.path;
  }

  void _onCreateGroup() async {
    final Map<String, dynamic> groupData = {
      'code': _groupCodeCtr.text.trim(),
      'description': _groupDescEn.text.trim(),
      'description_2': _groupDescKH.text.trim(),
      'displayLang': _disPlayLanguageListener.value.name.toUpperCase(),
      'active': 1,
      'imgPath': '',
    };
    final result = await _controller.onCreateGroupItem(arg: groupData);
    if (result) {
      Get.back();
    }
  }
}
