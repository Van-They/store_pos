import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/payment_method/payment_method_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/loading_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
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
        return ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildPaymentItem();
          },
        );
      }),
      bottomNavigationBar: PrimaryBtnWidget(
        onTap: () {},
        label: "create_payment".tr,
      ),
    );
  }

  Widget _buildPaymentItem() {
    return Container(
      margin: EdgeInsets.only(
        left: appSpace.scale,
        right: appSpace.scale,
        top: appSpace.scale,
      ),
      child: SlidableWidget(
        child: BoxWidget(
          child: SlidableWidget(
            child: Row(
              children: [
                ImageWidget(
                  width: 70.scale,
                  height: 70.scale,
                ),
                SizedBox(width: appSpace.scale),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(text: 'description',fontSize: 16.scale),
                    SizedBox(
                      height: appSpace.scale,
                    ),
                    TextWidget(text: 'description2'),
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
