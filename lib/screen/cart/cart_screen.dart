import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/cart/components/check_out_screen.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/empty_widget.dart';
import 'package:store_pos/widget/item_cart_widget.dart';
import 'package:store_pos/widget/loading_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  static const String routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'cart'.tr),
      body: controller.obx(
        onEmpty: const EmptyWidget(),
        onLoading: const LoadingWidget(),
        onError: (error) => const EmptyWidget(),
        (state) => _buildListItem(state ?? []),
      ),
      bottomNavigationBar: BoxWidget(
        height: 160.scale,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.all(appSpace.scale),
        child: Obx(
          () {
            final ordeHead = controller.orderHead.value;
            final counter = controller.state?.length ?? 0;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: 'subtotal'.tr),
                    TextWidget(text: '\$${ordeHead?.subtotal ?? 0.0}'),
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
                          text: '(${ordeHead?.discountPercentage ?? ''}%)',
                          color: kErrorColor,
                        ),
                      ],
                    ),
                    TextWidget(text: '\$${ordeHead?.discountAmount ?? 0.0}'),
                  ],
                ),
                SizedBox(height: appSpace.scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: 'amount_to_pay'.tr),
                    TextWidget(text: '\$${ordeHead?.grandTotal ?? 0.0}'),
                  ],
                ),
                const Spacer(),
                PrimaryBtnWidget(
                  margin: EdgeInsets.zero,
                  label: '${'check_out'.tr} ($counter)',
                  onTap: () {
                    Get.toNamed(CheckOutScreen.routeName);
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _buildListItem(List<OrderTranModel> records) {
    return ListView.builder(
      itemCount: records.length,
      padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
      itemBuilder: (context, index) {
        final record = records[index];
        return ItemCartWidget(record: record);
      },
    );
  }
}
