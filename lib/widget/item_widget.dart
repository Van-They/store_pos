import 'package:flutter/material.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

import 'box_widget.dart';
import 'hr.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.record,
    this.isList = false,
  });

  final ItemModel record;
  final bool isList;

  @override
  Widget build(BuildContext context) {
    if (isList) {
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
                  child: TextWidget(text: record.code),
                ),
                SizedBox(height: appSpace.scale),
                Padding(
                  padding: EdgeInsets.only(left: appSpace.scale),
                  child: TextWidget(text: record.description),
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
    }
    return BoxWidget(
      margin: EdgeInsets.only(top: appSpace.scale),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(imgPath: '', height: 100.scale),
          SizedBox(height: (appSpace / 2).scale),
          Padding(
            padding: EdgeInsets.only(left: appSpace.scale),
            child: Text(record.description),
          ),
          Padding(
            padding: EdgeInsets.only(left: appSpace.scale),
            child: Text('price'),
          ),
          SizedBox(height: (appSpace / 2).scale),
          const Hr(),
          Container(
            alignment: Alignment.center,
            height: 35.scale,
            child: Text('add_to_cart'),
          ),
        ],
      ),
    );
  }
}
