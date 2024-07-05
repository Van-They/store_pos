import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/text_widget.dart';

class LoadingMoreWidget extends StatelessWidget {
  const LoadingMoreWidget({
    super.key,
    this.isLoading = false,
    this.isScrolled = false,
  });

  final bool isLoading;
  final bool isScrolled;

  @override
  Widget build(BuildContext context) {
    if (isScrolled && !isLoading) {
      return TextWidget(
        text: 'end_of_records'.tr,
        height: 2,
      );
    }

    return SizedBox(
      height: 50.scale,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            color: kPrimaryColor,
          ),
          TextWidget(
            text: '${'loading_more'.tr}...',
          ),
        ],
      ),
    );
  }
}
