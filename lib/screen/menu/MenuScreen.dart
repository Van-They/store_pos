import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/screen/menu/components/item_screen.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

import 'components/group_item_screen.dart';

class MenuScreen extends GetView {
  const MenuScreen({super.key});

  static const String routeName = '/MenuScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'menu'),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Get.toNamed(GroupItemScreen.routeName);
            },
            child: Text('category'),
          ), ElevatedButton(
            onPressed: () {
              Get.toNamed(ItemScreen.routeName);
            },
            child: Text('item'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('customer'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('vendor'),
          ),
        ],
      ),
    );
  }
}
