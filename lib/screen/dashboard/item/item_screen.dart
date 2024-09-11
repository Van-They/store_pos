import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/item/components/set_up_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/components/update_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/item_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/button_float_widget.dart';
import 'package:store_pos/widget/components/custom_dialog.dart';
import 'package:store_pos/widget/empty_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/item_widget.dart';
import 'package:store_pos/widget/loading_widget.dart';
import 'package:store_pos/widget/refresh_indicator_widget.dart';

class ItemScreen extends GetView<ItemController> {
  const ItemScreen({super.key});

  static const String routeName = '/ItemScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () {
            return AppBarWidget(
              title: 'item'.tr,
              isBack: true,
              isSearch: true,
              iconSearch: controller.searchListener.value
                  ? Icon(
                      Icons.close,
                      size: 20.scale,
                      color: kPrimaryColor,
                    )
                  : null,
              onSearch: () {
                controller.searchListener.value =
                    !controller.searchListener.value;
              },
            );
          },
        ),
      ),
      floatingActionButton: ButtonFloatWidget(
        onTap: () {
          Get.toNamed(SetupItemScreen.routeName);
        },
      ),
      body: RefreshIndicatorWidget(
        onRefresh: () => controller.onGetItem(),
        child: CustomScrollView(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Obx(() {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: controller.searchListener.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: appPadding.scale,
                            vertical: appSpace.scale,
                          ),
                          child: InputTextWidget(
                            onChange: (query) {
                              controller.onSearchItem(query);
                            },
                            controller: controller.searchController,
                            hintText: '${'search_item'.tr}...',
                            suffixIcon: Icon(
                              Icons.search,
                              size: 18.scale,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              }),
            ),
            SliverFillRemaining(
              child: Obx(
                () {
                  final records = controller.itemList;
                  if (controller.isLoading.value) {
                    return const LoadingWidget();
                  }

                  if (records.isEmpty) {
                    return const EmptyWidget();
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: records.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return ItemWidget(
                        record: record,
                        onEdit: () {
                          Get.toNamed(UpdateItemScreen.routeName,
                              arguments: {"item": record})?.then(
                            (value) {
                              if (value == AppState.updated) {
                                controller.onGetItem();
                              }
                            },
                          );
                        },
                        onDelete: () {
                          showYesNoDialog(
                            content:
                                '${'do_you_want_to_delete'.tr} ${record.code}?',
                            onConfirm: () {
                              controller.onDeleteItem(record.code);
                              Get.back();
                            },
                          );
                        },
                        margin: EdgeInsets.only(top: 10.scale),
                        isList: true,
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
