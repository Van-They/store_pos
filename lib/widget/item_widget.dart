import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/slidable_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

import 'box_widget.dart';

class ItemWidget extends GetView<CartController> {
  const ItemWidget({
    super.key,
    required this.record,
    this.isList = false,
    this.onDelete,
    this.onEdit,
    this.margin,
  });

  final ItemModel record;
  final bool isList;
  final VoidCallback? onDelete, onEdit;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    if (isList) {
      return BoxWidget(
        margin: margin ?? EdgeInsets.only(top: appSpace.scale),
        height: 100.scale,
        child: SlidableWidget(
          onDelete: onDelete,
          onEdit: onEdit,
          child: BoxWidget(
            enableShadow: true,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageWidget(
                  imgPath: record.imgPath,
                  height: double.infinity,
                  width: 100.scale,
                ),
                SizedBox(width: appSpace.scale),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.scale),
                    TextWidget(
                      maxLine: 2,
                      fontSize: 16.scale,
                      text: record.displayLang.contains("KH")
                          ? record.description_2
                          : record.description,
                    ),
                    SizedBox(height: appSpace.scale),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: appSpace.scale, vertical: 2.scale),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(appSpace.scale),
                      ),
                      child: TextWidget(
                        text: "${'code'.tr}: ${record.code}",
                        color: kWhite,
                        fontSize: 12.scale,
                      ),
                    ),
                    SizedBox(height: 4.scale),
                    TextWidget(text: "${'qty'.tr}: ${record.qty}"),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    right: appSpace.scale,
                    top: 4.scale,
                  ),
                  child: TextWidget(
                    text: '\$${record.unitPrice}',
                    color: kErrorColor,
                  ),
                ),
              ],
            ),
          ),
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
                imgPath: record.imgPath,
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
                        decoration: const BoxDecoration(
                          color: kErrorColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.remove,
                          color: kWhite,
                          size: 20.scale,
                        ),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.all(4.scale),
                      margin: EdgeInsets.only(right: appSpace.scale),
                      decoration: const BoxDecoration(
                        color: kSecondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
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