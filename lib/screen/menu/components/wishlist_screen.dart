import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/screen/dashboard/item/item_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

class WishlistScreen extends GetView<ItemController> {
  const WishlistScreen({super.key});
  static const String routeName ="/WishlistScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'wishlist'.tr,
        isBack: true,
      ),
    );
  }
}
