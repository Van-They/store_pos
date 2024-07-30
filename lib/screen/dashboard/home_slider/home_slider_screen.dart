import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/components/pick_image.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';

import 'home_slider_controller.dart';

class HomeSliderScreen extends GetView<HomeSliderController> {
  const HomeSliderScreen({super.key});

  static const String routeName = "/HomeSliderScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'home_slide_set_up'.tr,
        isBack: true,
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: controller.imgSlider.length,
            itemBuilder: (context, index) {
              final record = controller.imgSlider[index];
              return Stack(
                children: [
                  Container(
                    height: 200.scale,
                    margin: EdgeInsets.only(top: appSpace.scale),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: FileImage(File(record)),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4.scale,
                    top: 4.scale,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.close,
                        color: kErrorColor,
                        size: 22.scale,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: Obx(() {
        return Row(
          children: [
            if (controller.isFile.value)
              Expanded(
                child: PrimaryBtnWidget(
                  onTap: () async {},
                  label: 'upload_image'.tr,
                ),
              ),
            Expanded(
              child: PrimaryBtnWidget(
                onTap: () async {
                  final img = await customPickImageGallery(isEnableCropp: true);
                  if (img != null) {
                    final path = await ImageStorageService.initImgPathTmp(
                      File(img.path),
                    );
                    controller.imgSlider.add(img.path);
                    controller.isFile.value = true;
                  }
                },
                label: 'add_image'.tr,
              ),
            ),
          ],
        );
      }),
    );
  }
}
