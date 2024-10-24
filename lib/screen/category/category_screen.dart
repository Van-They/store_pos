import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/category/components/fetch_item_by_category_screen.dart';
import 'package:store_pos/screen/dashboard/group/group_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  static const String routeName = '/CategoryScreen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late GroupController _controller;

  @override
  void initState() {
    _controller = Get.find<GroupController>();
    _controller.onGetGroupItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments ?? {};
    return Scaffold(
      appBar: AppBarWidget(
        title: 'category'.tr,
        isBack: arg['back'] ?? false,
      ),
      body: Padding(
        padding: EdgeInsets.all(appSpace.scale),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              child: Obx(
                () {
                  final records = _controller.groupItemList;
                  return MasonryGridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: records.length,
                    crossAxisSpacing: appPadding.scale,
                    mainAxisSpacing: appPadding.scale,
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
      onTap: () {
        Get.toNamed(
          FetchItemByCategory.routeName,
          arguments: {
            "title": record.code,
          },
        );
      },
      height: 70.scale,
      enableShadow: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageWidget(
            imgPath: record.imgPath,
            width: 70.scale,
          ),
          SizedBox(width: appSpace.scale),
          Flexible(
            child: TextWidget(
              fontSize: 16.scale,
              maxLine: 2,
              text: record.displayLang.contains("KH")
                  ? record.description_2
                  : record.description,
            ),
          ),
        ],
      ),
    );
  }
}
