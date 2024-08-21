import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/text_widget.dart';

showYesNoDialog(
    {required String content,
    VoidCallback? onConfirm,
    VoidCallback? onCancel}) {
  Get.dialog(
    AlertDialog(
      content: TextWidget(
        text: content,
        fontSize: 16.scale,
      ),
      title: Row(
        children: [
          Icon(
            FontAwesomeIcons.circleQuestion,
            size: 18.scale,
            color: kErrorColor,
          ),
          SizedBox(width: appSpace.scale),
          TextWidget(
            text: 'info'.tr,
          ),
        ],
      ),
      titlePadding: EdgeInsets.only(
          left: appPadding.scale,
          top: appPadding.scale,
          bottom: appSpace.scale),
      actionsPadding: EdgeInsets.zero,
      contentPadding:
          EdgeInsets.symmetric(vertical: 0, horizontal: appPadding.scale),
      actions: [
        TextButton(
          onPressed: onConfirm ??
              () {
                Get.back();
              },
          child: TextWidget(
            text: 'yes'.tr,
            color: kPrimaryColor,
          ),
        ),
        TextButton(
          onPressed: onCancel ??
              () {
                Get.back();
              },
          child: TextWidget(
            text: 'no'.tr,
            color: kErrorColor,
          ),
        ),
        SizedBox(width: appSpace.scale),
      ],
    ),
  );
}
