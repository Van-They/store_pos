import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/group/components/group_set_up_screen.dart';
import 'package:store_pos/screen/dashboard/group/group_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/button_float_widget.dart';
import 'package:store_pos/widget/components/custom_dialog.dart';
import 'package:store_pos/widget/empty_widget.dart';
import 'package:store_pos/widget/group_item_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/loading_widget.dart';

class GroupItemScreen extends GetView<GroupController> {
  const GroupItemScreen({super.key});

  static const String routeName = '/GroupItemScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () {
            return AppBarWidget(
              title: 'group_item'.tr,
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
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: controller.scrollController,
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
                          hintText: '${'search_group'.tr}...',
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
                if (controller.isLoading.value) {
                  return const LoadingWidget();
                }

                final records = controller.groupItemList;

                if (records.isEmpty) {
                  return const EmptyWidget();
                }

                return MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: records.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
                  crossAxisSpacing: appSpace.scale,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  ),
                  itemBuilder: (context, index) {
                    final record = records[index];
                    return GroupItemWidget(
                      record: record,
                      onDisable: () {
                        showYesNoDialog(
                          content:
                              '${'do_you_want_to_disable'.tr} ${record.code}?',
                          onConfirm: () async {
                            final updateRecord = record.toMap();
                            updateRecord['active'] =
                                record.active == 1 ? '0' : '1';
                            final result =
                                await controller.onToggleDisableGroup(
                              arg: updateRecord,
                            );
                            if (result) {
                              Get.back();
                            }
                          },
                        );
                      },
                      onEdit: () {
                        Get.toNamed(
                          GroupSetupScreen.routeName,
                          arguments: {
                            'isUpdate': true,
                            'imgPath': record.imgPath,
                            'code': record.code,
                            'description': record.description,
                            'description_2': record.description_2,
                            'display_language': record.displayLang,
                          },
                        );
                      },
                      onDelete: () {
                        showYesNoDialog(
                          content:
                              '${'do_you_want_to_delete'.tr} ${record.code}?',
                          onConfirm: () async {
                            final path = record.imgPath;
                            final result = await controller
                                .onDeleteGroup(arg: {"code": record.code});
                            Get.back();
                            if (result) {
                              await ImageStorageService.onClearCache(path)
                                  .whenComplete(() => Get.back());
                            }
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ButtonFloatWidget(
        onTap: () {
          Get.toNamed(GroupSetupScreen.routeName);
        },
      ),
    );
  }
}
