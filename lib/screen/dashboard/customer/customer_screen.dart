import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/customer/component/customer_set_up.dart';
import 'package:store_pos/screen/dashboard/customer/component/customer_update.dart';
import 'package:store_pos/screen/dashboard/customer/customer_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/button_float_widget.dart';
import 'package:store_pos/widget/empty_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/slidable_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class CustomerScreen extends GetView<CustomerController> {
  const CustomerScreen({super.key});

  static const String routeName = "/CustomerScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "customer".tr,
        isBack: true,
      ),
      body: Obx(
        () {
          final dataSet = controller.dataSet;
          if (dataSet.isEmpty) {
            return const EmptyWidget();
          }
          return ListView.builder(
            itemCount: dataSet.length,
            padding: EdgeInsets.all(appSpace.scale),
            itemBuilder: (context, index) {
              final record = dataSet[index];
              return SizedBox(
                width: double.infinity,
                height: 100.scale,
                child: SlidableWidget(
                  onDelete: () {
                    controller.onDeleteCurrentRecord(index: index);
                  },
                  onEdit: () {
                    Get.toNamed(CustomerUpdate.routeName,
                        arguments: {"code": record.code});
                  },
                  child: BoxWidget(
                    enableShadow: true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageWidget(
                          imgPath: record.imagePath,
                          height: double.infinity,
                          width: 100.scale,
                        ),
                        SizedBox(width: appSpace.scale),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextWidget(
                                text: '${record.firstName} ${record.lastName}'),
                            TextWidget(text: record.phoneNumber)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: ButtonFloatWidget(
        onTap: () {
          Get.toNamed(CustomerSetUp.routeName);
        },
      ),
    );
  }
}
