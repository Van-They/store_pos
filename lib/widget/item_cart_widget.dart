import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

import 'box_widget.dart';

class ItemCartWidget extends GetView<CartController> {
  const ItemCartWidget({
    super.key,
    required this.record,
  });

  final OrderTranModel record;

  @override
  Widget build(BuildContext context) {
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(appSpace.scale),
                      child: Row(
                        children: [
                          Container(
                            color: kborderColor,
                            width: 30.scale,
                            height: 30.scale,
                            child: Icon(
                              Icons.remove,
                              color: kWhite,
                              size: 18.scale,
                            ),
                          ),
                          SizedBox(width: appSpace.scale),
                          TextWidget(text: '${record.qty}'),
                          SizedBox(width: appSpace.scale),
                          Container(
                            color: kborderColor,
                            width: 30.scale,
                            height: 30.scale,
                            child: Icon(
                              Icons.add,
                              color: kWhite,
                              size: 18.scale,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextWidget(
                      text: '\$${record.unitPrice}',
                      color: kPrimaryColor,
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
}
