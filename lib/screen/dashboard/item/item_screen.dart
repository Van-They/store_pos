import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/item/components/set_up_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/components/update_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/item_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
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
      appBar: AppBarWidget(
        title: 'item'.tr,
        isBack: true,
        isSearch: true,
        onSearch: () {
          controller.searchListener.value = !controller.searchListener.value;
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.toNamed(SetupItemScreen.routeName);
        },
        child: const CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: Icon(
            Icons.add,
            color: kWhite,
          ),
        ),
      ),
      body: RefreshIndicatorWidget(
        onRefresh: () => controller.onGetItem(),
        child: SingleChildScrollView(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Obx(() {
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
              Obx(
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
                              arguments: {"code": record.code})?.then((value) {
                            if (value == AppState.updated) {
                              controller.onGetItem();
                            }
                          });
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
              SizedBox(height: appPadding.scale),
            ],
          ),
        ),
      ),
    );
  }
}
