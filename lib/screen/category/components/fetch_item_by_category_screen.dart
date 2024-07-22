import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/item/item_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/item_widget.dart';
import 'package:store_pos/widget/refresh_indicator_widget.dart';

class FetchItemByCategory extends GetView<ItemController> {
  const FetchItemByCategory({super.key});

  static const String routeName = "/FetchItemByCategory";

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments ?? {};
    controller.onGetItemByCategory(arg: {"code": arg['title']});
    return Scaffold(
      appBar: AppBarWidget(
        title: arg['title'] ?? "category".tr,
        isBack: true,
      ),
      body: RefreshIndicatorWidget(
        onRefresh: () => controller.onGetItemByCategory(arg: {"code": arg['title']}),
        child: Obx(() {
          final records = controller.itemList;
          return MasonryGridView.builder(
            itemCount: records.length,
            physics: const AlwaysScrollableScrollPhysics(),
            crossAxisSpacing: appSpace.scale,
            mainAxisSpacing: appSpace.scale,
            padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: itemCanFitHorizontal(width: 150.scale),
            ),
            itemBuilder: (context, index) {
              final record = records[index];
              return ItemWidget(record: record);
            },
          );
        }),
      ),
    );
  }
}
