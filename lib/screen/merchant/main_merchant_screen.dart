import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/group/group_item_screen.dart';
import 'package:store_pos/screen/merchant/item/item_screen.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class MainMerchantScreen extends StatefulWidget {
  const MainMerchantScreen({super.key});

  static const String routeName = "/MainMerchantScreen";

  @override
  State<MainMerchantScreen> createState() => _MainMerchantScreenState();
}

class _MainMerchantScreenState extends State<MainMerchantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Shop'),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // SliverGrid(
          //   delegate: SliverChildListDelegate(
          //     [
          //       Container(
          //         color: Colors.green,
          //       ),
          //       Container(
          //         color: Colors.blueAccent,
          //       ),
          //     ],
          //   ),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     childAspectRatio: 2,
          //     mainAxisSpacing: appSpace.scale,
          //     crossAxisSpacing: appSpace.scale,
          //     crossAxisCount: itemCanFitHorizontal(width: 150.scale),
          //   ),
          // ),

          SliverToBoxAdapter(child: SizedBox(height: appSpace.scale)),
          SliverToBoxAdapter(
            child: Wrap(
              children: [
                BoxWidget(
                  margin: EdgeInsets.only(right: appSpace.scale),
                  width: 70.scale,
                  height: 50.scale,
                  alignment: Alignment.center,
                  onTap: () {
                    Get.toNamed(ItemScreen.routeName);
                  },
                  child: TextWidget(
                    text: "Item",
                  ),
                ),
                BoxWidget(
                  margin: EdgeInsets.only(right: appSpace.scale),
                  width: 70.scale,
                  height: 50.scale,
                  onTap: () {
                    Get.toNamed(GroupItemScreen.routeName);
                  },
                  alignment: Alignment.center,
                  child: TextWidget(
                    text: "Group",
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: appSpace.scale)),

          // SliverToBoxAdapter(
          //   child: Container(
          //     margin: EdgeInsets.all(appSpace.scale),
          //     height: 50.scale,
          //     child: ListView.builder(
          //       itemBuilder: (context, index) {
          //         return BoxWidget(
          //           margin: EdgeInsets.only(right: appSpace.scale),
          //           width: 70.scale,
          //           height: 50.scale,
          //         );
          //       },
          //       itemCount: 5,
          //       scrollDirection: Axis.horizontal,
          //     ),
          //   ),
          // ),
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
          //   sliver: SliverToBoxAdapter(
          //     child: TextWidget(text: "recent_sale".tr),
          //   ),
          // ),
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
          //   sliver: SliverList.builder(
          //     itemCount: 5,
          //     itemBuilder: (context, index) {
          //       return TextWidget(text: "text");
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
