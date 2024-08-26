import 'package:flutter/material.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';

import '../../main.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message) {
    if (scaffoldMessageKey.currentState != null) {
      scaffoldMessageKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: kErrorColor,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          elevation: 0,
          margin: EdgeInsets.only(
            left: appSpace.scale,
            right: appSpace.scale,
            bottom: appSpace.scale,
          ),
          content: Text(message),
        ),
      );
    }
  }
}
