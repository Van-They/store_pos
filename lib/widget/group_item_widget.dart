import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/slidable_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

import 'box_widget.dart';

class GroupItemWidget extends GetView {
  const GroupItemWidget({
    super.key,
    required this.record,
    this.margin,
    this.onDelete,
    this.onEdit,
    this.onDisable,
  });

  final GroupItemModel record;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onDelete, onEdit, onDisable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(top: appSpace.scale),
      height: 100.scale,
      child: SlidableWidget(
        onDelete: onDelete,
        onEdit: onEdit,
        child: BoxWidget(
          height: double.infinity,
          width: double.infinity,
          enableShadow: true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(1),
                child: ImageWidget(
                  imgPath: record.imgPath,
                  height: double.infinity,
                  width: 100.scale,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.scale),
                    TextWidget(
                      text: record.displayLang.contains("KH")
                          ? record.description_2
                          : record.description,
                      fontSize: 16.scale,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(appSpace.scale),
                      ),
                      child: TextWidget(
                        text: '${'code'.tr}: ${record.code}',
                        color: kWhite,
                        fontSize: 12.scale,
                      ),
                    ),
                    // const Spacer(),
                    //  SizedBox(
                    //    width: 80.scale,
                    //    height: 30.scale,
                    //    child: PrimaryBtnWidget(
                    //      onTap:onDisable,
                    //      color: record.active == 1 ? kPrimaryColor : kLabel,
                    //      margin: EdgeInsets.zero,
                    //      label: 'disable'.tr,
                    //    ),
                    //  ),
                    // SizedBox(height: 2.scale),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
