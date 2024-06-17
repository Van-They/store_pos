import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

import 'box_widget.dart';

class ItemWidget extends GetView<CartController> {
  const ItemWidget({
    super.key,
    required this.record,
    this.isList = false,
    this.isCart = false,
  });

  final ItemModel record;
  final bool isList, isCart;

  @override
  Widget build(BuildContext context) {
    if (isList) {
      return BoxWidget(
        margin: EdgeInsets.only(top: appSpace.scale),
        padding: EdgeInsets.zero,
        enableShadow: true,
        height: 105.scale,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(
              imgPath: record.imgPath,
              height: double.infinity,
              width: 105.scale,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: appSpace.scale),
                  if (record.displayLang.contains("KH"))
                    TextWidget(text: record.description_2),
                  if (record.displayLang.contains("EN"))
                    TextWidget(text: record.description),
                  SizedBox(height: 4.scale),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(appSpace.scale),
                    ),
                    child: TextWidget(
                      text: record.code,
                      color: kWhite,
                      fontSize: 12.scale,
                    ),
                  ),
                  const Spacer(),
                  PrimaryBtnWidget(
                    onTap: () {},
                    color: kLabel,
                    padding: EdgeInsets.zero,
                    width: 90.scale,
                    height: 30.scale,
                    label: 'disable'.tr,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                right: appSpace.scale,
                top: appSpace.scale,
              ),
              child: TextWidget(
                text: '\$${record.unitPrice}',
                color: kErrorColor,
              ),
            ),
          ],
        ),
      );
    }
    return BoxWidget(
      padding: EdgeInsets.only(bottom: appSpace.scale),
      borderRadius: BorderRadius.all(Radius.circular(appSpace.scale)),
      enableShadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageWidget(
                imgPath: '',
                height: 130.scale,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(appSpace.scale),
                  topRight: Radius.circular(appSpace.scale),
                ),
              ),
              Positioned(
                top: 1.scale,
                right: 1.scale,
                child: CircleAvatar(
                  backgroundColor: kWhite,
                  radius: 14.scale,
                  child: Icon(
                    FontAwesomeIcons.heart,
                    size: 18.scale,
                    color: kSecondaryColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: appSpace.scale),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: appSpace.scale),
                    child: TextWidget(
                      fontSize: 16.scale,
                      fontWeight: FontWeight.w500,
                      text: record.description,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: appSpace.scale),
                    child: TextWidget(
                      text: '\$${record.unitPrice}',
                      fontSize: 15.scale,
                      color: kSecondaryColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  controller.toggleCart(record);
                },
                child: GetBuilder<CartController>(
                  builder: (controller) {
                    final records = controller.state ?? [];
                    final currentItem = records
                        .indexWhere((element) => element.code == record.code);
                    if (currentItem != -1) {
                      return Container(
                        padding: EdgeInsets.all(4.scale),
                        margin: EdgeInsets.only(right: appSpace.scale),
                        decoration: BoxDecoration(
                            color: kErrorColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.5.scale),
                              bottomRight: Radius.circular(7.5.scale),
                            )),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: kWhite,
                          size: 20.scale,
                        ),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.all(4.scale),
                      margin: EdgeInsets.only(right: appSpace.scale),
                      decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7.5.scale),
                            bottomRight: Radius.circular(7.5.scale),
                          )),
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        color: kWhite,
                        size: 20.scale,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
