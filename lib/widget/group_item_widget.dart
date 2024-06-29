import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

import 'box_widget.dart';

class GroupItemWidget extends GetView {
  const GroupItemWidget({
    super.key,
    required this.record,
  });

  final GroupItemModel record;

  @override
  Widget build(BuildContext context) {
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
                  margin: EdgeInsets.zero,
                  width: 90.scale,
                  height: 30.scale,
                  label: 'disable'.tr,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
