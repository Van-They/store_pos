import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/item/components/item_set_up_screen.dart';
import 'package:store_pos/screen/merchant/item/item_controller.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/custom_empty_widget.dart';
import 'package:store_pos/widget/expanded_app_bar_widget.dart';
import 'package:store_pos/widget/item_widget.dart';
import 'package:store_pos/widget/loading_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  static const String routeName = '/ItemScreen';

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final ItemController _controller = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildItemList(),
    );
  }

  Widget _buildItemList() {
    return CustomScrollView(
      slivers: [
        ExpandedAppBarWidget(
          title: TextWidget(
            text: 'item'.tr,
            fontSize: 18.scale,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: 'list_item'.tr),
                BoxWidget(
                  onTap: () => Get.toNamed(ItemSetUpScreen.routeName),
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
        SliverToBoxAdapter(
          child: _controller.obx(
            (state) {
              final records = state ?? [];
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: records.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
                itemBuilder: (context, index) {
                  final record = records[index];
                  return ItemWidget(
                    record: record,
                    margin: EdgeInsets.only(top: 10.scale),
                    isList: true,
                  );
                },
              );
            },
            onLoading: const LoadingWidget(),
            onError: (error) => const CustomEmptyWidget(),
            onEmpty: const CustomEmptyWidget(),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: appSpace.scale,
          ),
        )
      ],
    );
  }
}
