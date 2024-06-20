import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

class CheckOutScreen extends GetView<CartController> {
  const CheckOutScreen({super.key});
  static const String routeName = "/CheckOutScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'check_out'.tr),
    );
  }
}
