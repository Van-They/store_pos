import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class SelectPaymentScreen extends GetView<CartController> {
  const SelectPaymentScreen({super.key});
  static const String routeName = "/SelectPaymentScreen";
  @override
  Widget build(BuildContext context) {
    controller.onGetPaymentMethod();
    String code;
    String name;
    return Scaffold(
      appBar: AppBarWidget(
        title: 'payment'.tr,
        isBack: true,
      ),
      body: Obx(
        () {
          final records = controller.paymentMethods;
          return ListView.builder(
            itemCount: records.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final record = records[index];
              return GestureDetector(
                onTap: () {
                  code = record.code;
                  name = record.displayLang == Language.kh.name
                      ? record.description_2
                      : record.description;
                  Get.back(result: {"code": code, "name": name});
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: kborderColor),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
                    child: ListTile(
                      leading: TextWidget(text: '${index + 1}'),
                      title: TextWidget(
                        text: record.displayLang == Language.kh.name
                            ? record.description_2
                            : record.description,
                      ),
                    ),
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
