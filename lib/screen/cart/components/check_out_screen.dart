import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/cart/components/select_customer_screen.dart';
import 'package:store_pos/screen/cart/components/select_payment_screen.dart';
import 'package:store_pos/screen/main/main_screen.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/item_cart_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class CheckOutScreen extends GetView<CartController> {
  const CheckOutScreen({super.key});
  static const String routeName = "/CheckOutScreen";

  @override
  Widget build(BuildContext context) {
    var customerCode = '';
    var paymentCode = '';
    return Scaffold(
      appBar: AppBarWidget(
        title: 'check_out'.tr,
        isBack: true,
        onBack: () {
          controller.onResetCode();
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'to_customer'.tr,
              fontSize: 16.scale,
            ),
            SizedBox(height: appSpace.scale),
            Container(
              decoration: BoxDecoration(
                color: kWhite,
                border: Border.all(color: kborderColor),
                borderRadius: BorderRadius.circular(appSpace),
              ),
              child: ListTile(
                dense: true,
                onTap: () async {
                  final customer =
                      await Get.toNamed(SelectCustomerScreen.routeName);
                  if (customer != null) {
                    controller.customerName.value = customer['name'];
                    customerCode = customer['code'];
                  }
                },
                title: Obx(
                  () {
                    return TextWidget(
                      text: controller.customerName.value,
                      fontWeight: customerCode.isNotEmpty
                          ? FontWeight.w500
                          : FontWeight.normal,
                    );
                  },
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18.scale,
                ),
              ),
            ),
            SizedBox(height: 20.scale),
            TextWidget(
              text: 'payment_type'.tr,
              fontSize: 16.scale,
            ),
            SizedBox(height: appSpace.scale),
            Container(
              decoration: BoxDecoration(
                color: kWhite,
                border: Border.all(color: kborderColor),
                borderRadius: BorderRadius.circular(appSpace),
              ),
              child: ListTile(
                dense: true,
                onTap: () async {
                  final payment =
                      await Get.toNamed(SelectPaymentScreen.routeName);
                  if (payment != null) {
                    controller.paymentName.value = payment['name'];
                    paymentCode = payment['code'];
                  }
                },
                title: Obx(
                  () {
                    return TextWidget(
                      text: controller.paymentName.value,
                      fontWeight: paymentCode.isNotEmpty
                          ? FontWeight.w500
                          : FontWeight.normal,
                    );
                  },
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18.scale,
                ),
              ),
            ),
            SizedBox(height: 20.scale),
            TextWidget(
              text: 'product_list'.tr,
              fontSize: 16.scale,
            ),
            _buildListItem(),
            SizedBox(height: 20.scale),
            Obx(
              () {
                final orderHead = controller.orderHead.value;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(text: 'subtotal'.tr),
                        TextWidget(text: '\$${orderHead?.subtotal ?? 0.0}'),
                      ],
                    ),
                    SizedBox(height: 4.scale),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidget(text: 'discount'.tr),
                            SizedBox(width: appSpace.scale),
                            TextWidget(
                              text: '(${orderHead?.discountPercentage ?? ''}%)',
                              color: kErrorColor,
                            ),
                          ],
                        ),
                        TextWidget(
                            text: '\$${orderHead?.discountAmount ?? 0.0}'),
                      ],
                    ),
                    SizedBox(height: appSpace.scale),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(text: 'amount_to_pay'.tr),
                        TextWidget(text: '\$${orderHead?.grandTotal ?? 0.0}'),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        margin: EdgeInsets.symmetric(horizontal: 20.scale),
        onTap: () {
          if (customerCode.isEmpty) {
            showMessage(
                msg: 'please_select_customer'.tr, status: Status.warning);
            return;
          }
          if (paymentCode.isEmpty) {
            showMessage(
                msg: 'please_select_payment'.tr, status: Status.warning);
            return;
          }
          controller.onCheckOutCart().then((success) {
            if (success) {
              controller.onClearCartState();
              Get.offAllNamed(MainScreen.routeName);
            }
          });
        },
        label:
            '${'pay_now'.tr} (\$${controller.orderHead.value?.grandTotal ?? 0})',
      ),
    );
  }

  _buildListItem() {
    final records = controller.state ?? [];
    return ListView.builder(
      itemCount: records.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final record = records[index];
        return ItemCartWidget(
          record: record,
          isCart: false,
        );
      },
    );
  }
}
