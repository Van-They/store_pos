import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            color: kPrimaryColor,
          ),
          Text(label ?? 'loading'.tr),
        ],
      ),
    );
  }
}
