import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/service/app_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

import 'box_widget.dart';

class ItemCartWidget extends GetView<CartController> {
  const ItemCartWidget({
    super.key,
    required this.record,
    this.isCart = true,
  });

  final OrderTranModel record;
  final bool isCart;

  @override
  Widget build(BuildContext context) {
    if (isCart) {
      return BoxWidget(
        margin: EdgeInsets.only(top: appSpace.scale),
        padding: EdgeInsets.all(appSpace.scale),
        height: 120.scale,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextWidget(
                          text: record.displayLang == "KH"
                              ? record.description_2
                              : record.description,
                          fontSize: 15.scale,
                        ),
                      ),
                      Icon(
                        Icons.delete,
                        size: 18.scale,
                        color: kErrorColor,
                      )
                    ],
                  ),
                  SizedBox(width: appSpace.scale),
                  TextWidget(
                    text: '${'code'.tr}: ${record.code}',
                    fontSize: 14.scale,
                  ),
                  TextWidget(
                    text: '\$${record.unitPrice} / ${'unit'.tr}',
                    color: kPrimaryColor,
                    fontSize: 14.scale,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (record.qty == 1) {
                                showMessage(
                                  msg: 'not_allow_quantity_smaller_than_one',
                                  status: Status.warning,
                                );
                                return;
                              }
                              controller.onUpdateCart(
                                  code: record.code, qty: record.qty - 1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: kBorderColor),
                              ),
                              width: 30.scale,
                              height: 30.scale,
                              child: Icon(
                                Icons.remove,
                                color: kBorderColor,
                                size: 18.scale,
                              ),
                            ),
                          ),
                          SizedBox(width: appSpace.scale),
                          TextWidget(
                              text: '${AppService.convertToInt(record.qty)}'),
                          SizedBox(width: appSpace.scale),
                          GestureDetector(
                            onTap: () {
                              controller.onUpdateCart(
                                  code: record.code, qty: record.qty + 1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: kBorderColor),
                              ),
                              width: 30.scale,
                              height: 30.scale,
                              child: Icon(
                                Icons.add,
                                color: kBorderColor,
                                size: 18.scale,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextWidget(
                        text: '\$${record.grandTotal}',
                        color: kErrorColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return BoxWidget(
      margin: EdgeInsets.only(top: appSpace.scale),
      padding: EdgeInsets.all(appSpace.scale),
      height: 100.scale,
      enableShadow: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(
            imgPath: record.imagePath,
            height: double.infinity,
            width: 80.scale,
          ),
          SizedBox(width: appSpace.scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: record.displayLang == "KH"
                            ? record.description_2
                            : record.description,
                        fontSize: 15.scale,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: appSpace.scale),
                TextWidget(
                  text: '${'code'.tr} : ${record.code}',
                  fontSize: 14.scale,
                ),
                TextWidget(
                    text:
                        '${'qty'.tr} : ${AppService.convertToInt(record.qty)}'),
                const Spacer(),
                TextWidget(
                  text: '\$${record.grandTotal}',
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
