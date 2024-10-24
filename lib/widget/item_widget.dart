import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/global/wish_list_controller.dart';
import 'package:store_pos/core/service/app_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/slidable_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

import 'box_widget.dart';

class ItemWidget extends GetView {
  const ItemWidget({
    super.key,
    required this.record,
    this.isList = false,
    this.isNotSlideAble = false,
    this.onDelete,
    this.onEdit,
    this.margin,
    this.isCheck = false,
    this.notifyCheck,
  });

  final ItemModel record;
  final bool isList, isCheck;
  final VoidCallback? onDelete, onEdit;
  final EdgeInsetsGeometry? margin;
  final bool isNotSlideAble;
  final Function(bool?)? notifyCheck;

  @override
  Widget build(BuildContext context) {
    if (isNotSlideAble && isList) {
      // ValueNotifier<bool> isCheck = ValueNotifier(false);
      return Container(
        margin: margin ?? EdgeInsets.only(top: appSpace.scale),
        child: BoxWidget(
          height: 110.scale,
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
                  Padding(
                    padding: EdgeInsets.only(
                      right: appSpace.scale,
                      top: 4.scale,
                    ),
                    child: TextWidget(
                      text: AppService.displayFormat(record.unitPrice),
                      color: kErrorColor,
                    ),
                  ),
                ],
              ),
              // const Spacer(),
              // Container(
              //   alignment: Alignment.center,
              //   height: double.infinity,
              //   child: ValueListenableBuilder(
              //     valueListenable: isCheck,
              //     builder: (context, value, child) {
              //       return Checkbox(
              //         activeColor: kPrimaryColor,
              //         value: value,
              //         onChanged: (check) {
              //           isCheck.value = !value;
              //           if (notifyCheck != null) {
              //             notifyCheck!(isCheck.value);
              //           }
              //         },
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      );
    }
    if (isList) {
      return Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          maxLine: 2,
                          fontSize: 16.scale,
                          text: record.displayLang.contains("KH")
                              ? record.description_2
                              : record.description,
                        ),
                        SizedBox(height: appSpace.scale),
                        TextWidget(
                          text: '${"code".tr} : ${record.code}',
                          color: kLabel,
                          fontSize: 12.scale,
                        ),
                      ],
                    ),
                    TextWidget(
                      text: AppService.displayFormat(record.unitPrice),
                      color: kErrorColor,
                      fontSize: 18.scale,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    //item display on sale
    return BoxWidget(
      padding: EdgeInsets.only(bottom: appSpace.scale),
      borderRadius: const BorderRadius.all(Radius.circular(2)),
      enableShadow: true,
      blueRadius: 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageWidget(
                imgPath: record.imgPath,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                height: 130.scale,
              ),
              Positioned(
                top: 2.scale,
                right: 2.scale,
                child: GetBuilder<WishListController>(
                  builder: (controller) {
                    final isFavorite = controller.dataSet.contains(record.code);
                    return GestureDetector(
                        onTap: () {
                          // isFavorite.value = !isFavorite.value;
                          showMessage(msg: "ToDo Favorite");
                        },
                        child: CircleAvatar(
                          backgroundColor: isFavorite ? kRed : kWhite,
                          radius: 14.scale,
                          child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 16.scale,
                          color: isFavorite ? kWhite : kBorderColor,
                          ),
                          ),
                      ); 
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: appSpace),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: appSpace.scale),
                      child: TextWidget(
                        maxLine: 2,
                        fontSize: 16.scale,
                        text: record.displayLang.contains("KH")
                            ? record.description_2
                            : record.description,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: appSpace.scale),
                          child: TextWidget(
                            text: AppService.displayFormat(record.unitPrice),
                            fontWeight: FontWeight.w500,
                            fontSize: 14.scale,
                            color: kErrorColor,
                          ),
                        ),
                        GetBuilder<CartController>(
                          builder: (controller) {
                              final records = controller.orderTranList;
                                  final isCurrent = records.any(
                                        (element) => element.code == record.code,
                                  );
                            return GestureDetector(
                              onTap: () {
                                controller.toggleCart(record);
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.scale),
                                margin: EdgeInsets.only(right: 4.scale),
                                decoration: BoxDecoration(
                                  color: isCurrent
                                      ? kErrorColor
                                      : kPrimaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: isCurrent
                                    ? Icon(
                                  Icons.remove,
                                  color: kWhite,
                                  size: 16.scale,
                                )
                                    : Icon(
                                  Icons.add,
                                  color: kWhite,
                                  size: 16.scale,
                                ),
                              )
                          );
                          },
                    
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
