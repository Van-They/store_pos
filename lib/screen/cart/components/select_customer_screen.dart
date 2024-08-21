import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class SelectCustomerScreen extends GetView<CartController> {
  const SelectCustomerScreen({super.key});
  static const String routeName = "/SelectCustomerScreen";
  @override
  Widget build(BuildContext context) {
    controller.onGetCustomer();
    String code;
    String name;
    return Scaffold(
      appBar: AppBarWidget(
        title: 'customer'.tr,
        isBack: true,
      ),
      body: Obx(
        () {
          final records = controller.customers;
          return ListView.builder(
            itemCount: records.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final record = records[index];
              return GestureDetector(
                onTap: () {
                  code = record.code;
                  name = '${record.firstName} ${record.lastName}';
                  Get.back(result: {"code": code, "name": name});
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
                  child: ListTile(
                    leading: TextWidget(text: '${index + 1}'),
                    title: TextWidget(
                        text: '${record.firstName} ${record.lastName}'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
