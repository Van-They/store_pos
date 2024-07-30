import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/group/group_item_screen.dart';
import 'package:store_pos/screen/dashboard/home_slider/home_slider_screen.dart';
import 'package:store_pos/screen/dashboard/import_group_item/import_group_item_screen.dart';
import 'package:store_pos/screen/dashboard/import_item/import_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/item_screen.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/hr.dart';
import 'package:store_pos/widget/text_widget.dart';

class MainMerchantScreen extends StatelessWidget {
  const MainMerchantScreen({super.key});

  static const String routeName = "/MainMerchantScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'dashboard'.tr,
        centerTitle: true,
        isBack: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoxWidget(
              padding: EdgeInsets.all(appSpace.scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'preference'.tr,
                    fontSize: 18.scale,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                  _buildMenu(
                    title: 'home_slider'.tr,
                    onTap: () {
                      Get.toNamed(HomeSliderScreen.routeName);
                    },
                  ),
                  _buildMenu(
                    title: 'payment_method'.tr,
                    onTap: () {},
                  ),
                  _buildMenu(
                    title: 'item'.tr,
                    onTap: () => Get.toNamed(ItemScreen.routeName),
                  ),
                  _buildMenu(
                    title: 'group_item'.tr,
                    onTap: () => Get.toNamed(GroupItemScreen.routeName),
                  ),
                  _buildMenu(
                    title: 'company'.tr,
                    onTap: () {},
                  ),
                  _buildMenu(
                    title: 'configure'.tr,
                    isLast: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: appSpace.scale),
            BoxWidget(
              padding: EdgeInsets.all(appSpace.scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'customer'.tr,
                    fontSize: 18.scale,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                  _buildMenu(title: 'customer'.tr, onTap: () {}, isLast: true),
                ],
              ),
            ),
            SizedBox(height: appSpace.scale),
            BoxWidget(
              padding: EdgeInsets.all(appSpace.scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'report'.tr,
                    fontSize: 18.scale,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                  _buildMenu(
                    title: 'daily_sale'.tr,
                    onTap: () {},
                  ),
                  _buildMenu(
                    title: 'cash_register'.tr,
                    onTap: () {},
                  ),
                  _buildMenu(
                    title: 'invoice_register'.tr,
                    onTap: () {},
                    isLast: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: appSpace.scale),
            BoxWidget(
              padding: EdgeInsets.all(appSpace.scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'import_data'.tr,
                    fontSize: 18.scale,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                  _buildMenu(
                    title: 'import_group_item'.tr,
                    onTap: () {
                      Get.toNamed(ImportGroupItemScreen.routeName);
                    },
                  ),
                  _buildMenu(
                    title: 'import_item'.tr,
                    isLast: true,
                    onTap: () {
                      Get.toNamed(ImportItemScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: appSpace.scale),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(
      {VoidCallback? onTap,
      required String title,
      double? height,
      bool isLast = false}) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: Column(
          children: [
            SizedBox(height: (appSpace / 2).scale),
            SizedBox(
              height: height ?? (isLast ? 35.scale : 40.scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: title),
                      // Icon(Icons.arrow_forward_ios_rounded, size: 18.scale)
                    ],
                  ),
                  TextWidget(
                    text: 'do something',
                    fontSize: 12.scale,
                    color: kLabel,
                  ),
                ],
              ),
            ),
            if (!isLast) const Hr(),
          ],
        ),
      ),
    );
  }

  CustomScrollView _list() {
    return CustomScrollView(
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
                width: double.infinity,
                height: 100.scale,
                backgroundColor: kPrimaryColor,
                alignment: Alignment.center,
                onTap: () {
                  Get.toNamed(ItemScreen.routeName);
                },
                child: const TextWidget(text: "Item"),
              ),
              BoxWidget(
                width: double.infinity,
                height: 100.scale,
                backgroundColor: kSecondaryColor,
                onTap: () {
                  Get.toNamed(GroupItemScreen.routeName);
                },
                alignment: Alignment.center,
                child: const TextWidget(
                  text: "Group",
                ),
              ),
              BoxWidget(
                width: double.infinity,
                height: 100.scale,
                backgroundColor: kSecondaryColor,
                onTap: () {
                  Get.toNamed(GroupItemScreen.routeName);
                },
                alignment: Alignment.center,
                child: const TextWidget(
                  text: "Customer",
                ),
              ),
              BoxWidget(
                width: double.infinity,
                height: 100.scale,
                backgroundColor: kSecondaryColor,
                onTap: () {
                  Get.toNamed(GroupItemScreen.routeName);
                },
                alignment: Alignment.center,
                child: const TextWidget(
                  text: "Payment",
                ),
              ),
              BoxWidget(
                width: double.infinity,
                height: 100.scale,
                backgroundColor: kSecondaryColor,
                onTap: () {
                  Get.toNamed(GroupItemScreen.routeName);
                },
                alignment: Alignment.center,
                child: const TextWidget(
                  text: "Setting",
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
    );
  }
}
