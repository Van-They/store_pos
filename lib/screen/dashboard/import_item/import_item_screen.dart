import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/service/xlsx_file_reader_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/import_item/import_item_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/empty_widget.dart';
import 'package:store_pos/widget/item_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';

class ImportItemScreen extends GetView<ImportItemController> {
  const ImportItemScreen({super.key});

  static const String routeName = "/ImportItemScreen";

  @override
  Widget build(BuildContext context) {
    bool isPickFile = false;
    return Scaffold(
      appBar: AppBarWidget(
        title: 'import_item'.tr,
        isBack: true,
        isReset: true,
        onReset: () {
          controller.itemList.clear();
        },
      ),
      body: Obx(
        () {
          final records = controller.itemList;
          if (records.isEmpty) {
            return const EmptyWidget();
          }
          return ListView.builder(
            itemCount: records.length,
            padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
            itemBuilder: (context, index) {
              final record = records[index];
              return ItemWidget(
                record: record,
                isList: true,
                notifyCheck: (isCheck) {},
                isNotSlideAble: true,
              );
            },
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return PrimaryBtnWidget(
            onTap: () async {
              if (isPickFile) {
                final data = controller.itemList;
                int i = 0;
                while (i < data.length) {
                  controller.onCreateImportItem(arg: data[i].toMap());
                  i++;
                }
                showMessage(msg: "success".tr, status: Status.success);
                controller.itemList.clear();
                Navigator.pop(context);
                return;
              }
              await XlsxFileReaderService.loadFile().whenComplete(() async {
                final result = await XlsxFileReaderService.readItem();
                if (result.isNotEmpty) {
                  List<ItemModel> listItem = [];
                  for (var element in result) {
                    listItem.add(ItemModel.fromMap(element));
                  }
                  controller.itemList.value = listItem;
                  isPickFile = true;
                }
              });
            },
            label: controller.itemList.isNotEmpty
                ? 'upload_data'.tr
                : 'pick_file'.tr,
          );
        },
      ),
    );
  }
}
