import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/model/payment_method_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/payment_method/payment_method_controller.dart';
import 'package:store_pos/screen/dashboard/payment_method/payment_set_up_screen.dart';
import 'package:store_pos/screen/dashboard/payment_method/payment_update_screen.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/button_float_widget.dart';
import 'package:store_pos/widget/empty_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/loading_widget.dart';
import 'package:store_pos/widget/slidable_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class PaymentMethodScreen extends GetView<PaymentMethodController> {
  const PaymentMethodScreen({super.key});

  static const String routeName = "/PaymentMethodScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'payment_method'.tr,
        isBack: true,
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const LoadingWidget();
        }

        final records = controller.paymentList;

        if (records.isEmpty) {
          return const EmptyWidget();
        }

        return ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            return _buildPaymentItem(record);
          },
        );
      }),
      floatingActionButton: ButtonFloatWidget(
        onTap: () {
          Get.toNamed(PaymentSetupScreen.routeName);
        },
      ),
    );
  }

  Widget _buildPaymentItem(PaymentMethodModel record) {
    return Container(
      margin: EdgeInsets.only(
        left: appSpace.scale,
        right: appSpace.scale,
        top: appSpace.scale,
      ),
      child: SlidableWidget(
        onDelete: () {
          controller.onDeletePaymentMethod(arg: {"code": record.code});
        },
        onEdit: () {
          controller.paymentUpdate = record;
          controller.onUpdateTransaction();
          Get.toNamed(PaymentUpdateScreen.routeName);
        },
        child: BoxWidget(
          child: SlidableWidget(
            child: Row(
              children: [
                ImageWidget(
                  width: 70.scale,
                  height: 70.scale,
                  imgPath: record.imagePath,
                ),
                SizedBox(width: appSpace.scale),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: record.displayLang == "KH"
                          ? record.description_2
                          : record.description,
                      fontSize: 16.scale,
                    ),
                    SizedBox(height: appSpace.scale),
                    TextWidget(text: record.code),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
