import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/service/xlsx_file_reader_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/import_group_item/import_group_item_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/empty_widget.dart';
import 'package:store_pos/widget/group_item_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';

class ImportGroupItemScreen extends GetView<ImportGroupItemController> {
  const ImportGroupItemScreen({super.key});

  static const String routeName = "/ImportGroupItemScreen";

  @override
  Widget build(BuildContext context) {
    bool isPickFile = false;
    return Scaffold(
      appBar: AppBarWidget(
        title: 'import_group_item'.tr,
        isBack: true,
        isReset: true,
        onReset: () {
          controller.itemGroupList.clear();
        },
      ),
      body: Obx(
        () {
          final records = controller.itemGroupList;
          if (records.isEmpty) {
            return const EmptyWidget();
          }
          return ListView.builder(
            itemCount: records.length,
            padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
            itemBuilder: (context, index) {
              final record = records[index];
              return GroupItemWidget(record: record);
            },
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return PrimaryBtnWidget(
            onTap: () async {
              if (isPickFile) {
                final data = controller.itemGroupList;
                int i = 0;
                while (i < data.length) {
                  controller.onCreateImportGroupItem(arg: data[i].toMap());
                  i++;
                }
                showMessage(msg: "success".tr, status: Status.success);
                controller.itemGroupList.clear();
                Navigator.pop(context);
                return;
              }
              await XlsxFileReaderService.loadFile().whenComplete(() async {
                final result = await XlsxFileReaderService.readGroupItem();
                if (result.isNotEmpty) {
                  List<GroupItemModel> listItem = [];
                  for (var element in result) {
                    listItem.add(GroupItemModel.fromMap(element));
                  }
                  controller.itemGroupList.value = listItem;
                  isPickFile = true;
                }
              });
            },
            label: controller.itemGroupList.isNotEmpty
                ? 'upload_data'.tr
                : 'pick_file'.tr,
          );
        },
      ),
    );
  }
}
