import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/group/group_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/custom_empty_widget.dart';
import 'package:store_pos/widget/custom_error_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class CategoryScreen extends GetView<GroupController> {
  const CategoryScreen({super.key});

  static const String routeName = '/CategoryScreen';

  @override
  Widget build(BuildContext context) {
    controller.onGetGroupItem();
    return Scaffold(
      appBar: AppBarWidget(title: 'category'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
        child:  CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              child: controller.obx(
                onError: (error) => const CustomErrorWidget(),
                onEmpty: const CustomEmptyWidget(),
                    (state) {
                  final records = state ?? [];
                  return MasonryGridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: records.length,
                    crossAxisSpacing: appSpace.scale,
                    gridDelegate:
                    SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: itemCanFitHorizontal(width: 150.scale),
                    ),
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return _buildGroupItem(record);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildGroupItem(GroupItemModel record) {
    return AbsorbPointer(
      child: BoxWidget(
        height: 70.scale,
        enableShadow: true,
        child: Row(
          children: [
            ImageWidget(
              imgPath: record.imgPath,
              width: 70.scale,
            ),
            SizedBox(width: appSpace.scale),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextWidget(
                  text: record.code,
                  fontSize: 16.scale,
                ),
                if (record.displayLang.contains("EN"))
                  TextWidget(text: record.description),
                if (record.displayLang.contains("KH"))
                  TextWidget(text: record.description_2)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
