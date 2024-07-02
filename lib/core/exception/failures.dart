import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/text_widget.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message) {
    showMessage(msg: message,status: Status.failed);
    // Get.rawSnackbar(
    //   animationDuration: const Duration(milliseconds: 120),
    //   messageText: TextWidget(
    //     text: message,
    //     color: kWhite,
    //   ),
    //   borderRadius: appSpace.scale,
    //   backgroundColor: kErrorColor,
    //   margin: EdgeInsets.fromLTRB(appSpace.scale, 0, appSpace.scale, 4.scale),
    //   dismissDirection: DismissDirection.down,
    // );
  }
}
