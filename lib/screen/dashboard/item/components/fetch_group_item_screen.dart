import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/group/group_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class FetchGroupItemScreen extends GetView<GroupController> {
  const FetchGroupItemScreen({super.key});

  static const String routeName = "/FetchGroupItemScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'group_item'.tr,
        isBack: true,
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            titleSpacing: appSpace.scale,
            toolbarHeight: 70.scale,
            title: InputTextWidget(
              maxLine: 1,
              hintText: "${'search_group'.tr}...",
              suffixIcon: Icon(
                Icons.search,
                size: 20.scale,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () {
                final records = controller.groupItemList;
                return MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: records.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
                  crossAxisSpacing: appSpace.scale,
                  mainAxisSpacing: appSpace.scale,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
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
    );
  }

  Widget _buildGroupItem(GroupItemModel record) {
    return BoxWidget(
      height: 80.scale,
      onTap: () => Get.back(result: {"group_code": record.code}),
      enableShadow: true,
      margin: EdgeInsets.only(top: 4.scale),
      child: Row(
        children: [
          ImageWidget(
            imgPath: record.imgPath,
            width: 80.scale,
          ),
          SizedBox(width: appSpace.scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.scale),
              TextWidget(
                text: record.displayLang.contains("KH")
                    ? record.description_2
                    : record.description,
                fontSize: 16.scale,
              ),
              SizedBox(height: 4.scale),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: appSpace.scale, vertical: 2.scale),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(appSpace.scale),
                ),
                child: TextWidget(
                  text: "${'code'.tr}: ${record.code}",
                  color: kWhite,
                  fontSize: 12.scale,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
