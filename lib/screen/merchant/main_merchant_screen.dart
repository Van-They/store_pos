import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/sales_data.dart';
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
  final List<SalesData> chartData = [
    SalesData(DateTime(2010), 35),
    SalesData(DateTime(2011), 28),
    SalesData(DateTime(2012), 34),
    SalesData(DateTime(2013), 32),
    SalesData(DateTime(2014), 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'dashboard'.tr,
        centerTitle: false,
        isBack: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SfCartesianChart(
            //     primaryXAxis: const DateTimeAxis(),
            //     series: <CartesianSeries>[
            //       LineSeries<SalesData, DateTime>(
            //           dataSource: chartData,
            //           xValueMapper: (SalesData sales, _) => sales.year,
            //           yValueMapper: (SalesData sales, _) => sales.sales)
            //     ]),
            TextWidget(text: 'menu'.tr),
            ListTile(
              onTap: () {
                Get.toNamed(ItemScreen.routeName);
              },
              leading: Icon(
                Icons.abc,
                size: 22.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'item'.tr),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(GroupItemScreen.routeName);
              },
              leading: Icon(
                Icons.abc,
                size: 22.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'group_item'.tr),
            ),
            TextWidget(text: 'customer'.tr),
            ListTile(
              leading: Icon(
                Icons.abc,
                size: 22.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'customer'.tr),
            ),
            TextWidget(text: 'preference'.tr),
            ListTile(
              leading: Icon(
                Icons.abc,
                size: 22.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'company'.tr),
            ),
            ListTile(
              leading: Icon(
                Icons.abc,
                size: 22.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'setting'.tr),
            ),
            TextWidget(text: 'payment'.tr),
            ListTile(
              leading: Icon(
                Icons.abc,
                size: 22.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'expand'.tr),
            ),
            ListTile(
              leading: Icon(
                Icons.abc,
                size: 22.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'income'.tr),
            ),
            ListTile(
              leading: Icon(
                Icons.abc,
                size: 22.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'payment'.tr),
            ),
            TextWidget(text: 'report'.tr),
            ListTile(
              leading: Icon(
                Icons.abc,
                size: 22.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'report'.tr),
            ),
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
