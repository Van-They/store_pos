import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/group/group_controller.dart';

import '../../main.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: kErrorColor,
        messageText: Text(message),
        margin: EdgeInsets.only(
          left: appSpace.scale,
          right: appSpace.scale,
          bottom: appSpace.scale,
        ),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
