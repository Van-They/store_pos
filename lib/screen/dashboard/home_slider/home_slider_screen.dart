import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/components/pick_image.dart';
import 'package:store_pos/widget/empty_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';

import 'home_slider_controller.dart';

class HomeSliderScreen extends GetView<HomeSliderController> {
  const HomeSliderScreen({super.key});

  static const String routeName = "/HomeSliderScreen";

  _onUploadImage(String raw, String path) async {
    final result = await controller.onSaveImageSlider(path);
    if (result) {
      await ImageStorageService.saveImageToSecureDir(
        File(raw),
        path: path,
      );
      controller.imgListSlider.add(path);
      showMessage(status: Status.success, msg: "success".tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'home_slide_set_up'.tr,
        isBack: true,
      ),
      body: Obx(
        () {
          final records = controller.imgListSlider;
          if (records.isEmpty) {
            return const EmptyWidget();
          }
          return ListView.builder(
            itemCount: controller.imgListSlider.length,
            itemBuilder: (context, index) {
              final record = controller.imgListSlider[index];
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
                      onPressed: () {
                        controller.onDeleteSlide(index);
                      },
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
      bottomNavigationBar: PrimaryBtnWidget(
        onTap: () async {
          final img = await customPickImageGallery(isEnableCrop: true);
          if (img != null) {
            final path = await ImageStorageService.initImgPathTmp(
              File(img.path),
            );
            _onUploadImage(img.path, path);
          }
        },
        label: 'add_image'.tr,
      ),
    );
  }
}
