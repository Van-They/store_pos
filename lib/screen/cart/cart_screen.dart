import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class CartScreen extends GetView {
  const CartScreen({super.key});

  static const String routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'cart'),
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
        itemBuilder: (context, index) {
          return BoxWidget(
            margin: EdgeInsets.only(top: appSpace.scale),
            padding: EdgeInsets.zero,
            height: 100.scale,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageWidget(
                  imgPath: '',
                  height: double.infinity,
                  width: 100.scale,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: appSpace.scale),
                      child: TextWidget(text: 'record.code'),
                    ),
                    SizedBox(height: appSpace.scale),
                    Padding(
                      padding: EdgeInsets.only(left: appSpace.scale),
                      child: TextWidget(text: 'record.description'),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(left: appSpace.scale),
                      child: const TextWidget(text: 'add_to_cart'),
                    ),
                  ],
                ),
                const Spacer(),
                const TextWidget(text: 'price'),
                // SizedBox(height: scaleFactor(appSpace/2)),
                // const Hr(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BoxWidget(
        height: 150.scale,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: 'subtotal'),
                TextWidget(text: '0.0'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: 'discount'),
                TextWidget(text: '0.0'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: 'amount_to_pay'),
                TextWidget(text: '0.0'),
              ],
            ),
            const Spacer(),
            PrimaryBtnWidget(
              padding: EdgeInsets.zero,
              label: 'check_out',
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
