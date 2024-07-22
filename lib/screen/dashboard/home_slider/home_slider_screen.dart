import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
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
      body: Container(),
      bottomNavigationBar: PrimaryBtnWidget(
        onTap: () async {
          final img = await customPickImageGallery(isEnableCropp: true);
          if (img != null) {
            final path = await ImageStorageService.initImgPathTmp(
              File(img.path),
            );
          }
        },
        label: 'upload_image'.tr,
      ),
    );
  }
}
