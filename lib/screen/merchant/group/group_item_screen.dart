import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/group/components/group_set_up_screen.dart';
import 'package:store_pos/screen/merchant/group/group_controller.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/custom_empty_widget.dart';
import 'package:store_pos/widget/custom_error_widget.dart';
import 'package:store_pos/widget/group_item_widget.dart';
import 'package:store_pos/widget/slidable_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

import '../../../widget/expanded_app_bar_widget.dart';

class GroupItemScreen extends GetView<GroupController> {
  const GroupItemScreen({super.key});

  static const String routeName = '/GroupItemScreen';

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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: appSpace.scale),
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
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: appSpace.scale),
                        child: SlidableWidget(
                          onDelete: () {},
                          onEdit: () {},
                          child: GroupItemWidget(record: record),
                        ),
                      );
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
}
