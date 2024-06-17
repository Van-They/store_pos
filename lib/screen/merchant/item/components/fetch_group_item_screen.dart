import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/group/components/group_set_up_screen.dart';
import 'package:store_pos/screen/merchant/group/group_controller.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/custom_empty_widget.dart';
import 'package:store_pos/widget/custom_error_widget.dart';
import 'package:store_pos/widget/expanded_app_bar_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class FetchGroupItemScreen extends GetView<GroupController> {
  const FetchGroupItemScreen({super.key});
  static const String routeName = "/FetchGroupItemScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: appSpace.scale, right: appSpace.scale),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            ExpandedAppBarWidget(
              title: TextWidget(
                text: 'group_item'.tr,
                color: kPrimaryColor,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: 'list_group'.tr),
                  BoxWidget(
                    onTap: () => Get.toNamed(GroupSetupScreen.routeName),
                    height: 45.scale,
                    borderColor: kBgColor,
                    padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
                    enableShadow: true,
                    child: TextWidget(text: 'add_new'.tr),
                  ),
                ],
              ),
            ),
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
    return BoxWidget(
      height: 70.scale,
      onTap: () => Get.back(result: {"group_code": record.code}),
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
    );
  }
}
