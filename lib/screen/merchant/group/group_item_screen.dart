import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/group/components/group_set_up_screen.dart';
import 'package:store_pos/screen/merchant/group/group_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/components/custom_dialog.dart';
import 'package:store_pos/widget/custom_empty_widget.dart';
import 'package:store_pos/widget/custom_error_widget.dart';
import 'package:store_pos/widget/group_item_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class GroupItemScreen extends GetView<GroupController> {
  const GroupItemScreen({super.key});

  static const String routeName = '/GroupItemScreen';

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> searchListener = ValueNotifier(false);
    return Scaffold(
      appBar: AppBarWidget(
        title: 'group_item'.tr,
        isBack: true,
        isSearch: true,
        onSearch: () => _onSearch(searchListener),
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: ValueListenableBuilder(
              valueListenable: searchListener,
              builder: (context, value, child) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: value
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
              },
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
      bottomNavigationBar: BoxWidget(
        margin: EdgeInsets.symmetric(
            horizontal: appPadding.scale, vertical: appSpace.scale),
        onTap: () => Get.toNamed(GroupSetupScreen.routeName),
        height: 45.scale,
        borderColor: kBgColor,
        backgroundColor: kPrimaryColor,
        padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
        enableShadow: true,
        child: TextWidget(
          text: 'add_group'.tr,
          color: kWhite,
        ),
      ),
    );
  }

  _onSearch(ValueNotifier<bool> searchListener) {
    searchListener.value = !searchListener.value;
  }
}
