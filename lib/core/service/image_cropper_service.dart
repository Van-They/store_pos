import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/exception/exceptions.dart';

Future<CroppedFile?> customCropImage({XFile? imgFile}) async {
  try {
    if (imgFile != null) {
      final croppedFile = await ImageCropper().cropImage(
          sourcePath: imgFile.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'cropper'.tr,
              toolbarColor: kPrimaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
              aspectRatioPresets: [
                CropAspectRatioPreset.ratio16x9,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.square,
              ],
            ),
            IOSUiSettings(
              title: 'cropper'.tr,
              aspectRatioPresets: [
                CropAspectRatioPreset.ratio16x9,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.square,
              ],
            ),
          ]);
      return croppedFile;
    } else {
      throw GeneralException();
    }
  } catch (e) {
    rethrow;
  }
}
