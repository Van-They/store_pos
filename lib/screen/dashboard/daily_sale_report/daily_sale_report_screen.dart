import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/daily_sale_report/daily_sale_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class DailySaleReportScreen extends GetView<DailySaleController> {
  const DailySaleReportScreen({super.key});

  static const String routeName = "/DailySaleReportScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'daily_report'.tr,
        isBack: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(appSpace.scale),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: BoxWidget(
                    margin: EdgeInsets.only(right: (appSpace/2).scale),
                    height: 100.scale,
                    child: TextWidget(text: 'Total'),
                  ),
                ),
                Expanded(
                  child: BoxWidget(
                    height: 100.scale,
                    margin: EdgeInsets.only(left: (appSpace/2).scale),
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                              text: '${controller.rsOrderTranList.length}'),
                          const TextWidget(text: 'count'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: appSpace.scale),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final record = controller.rsOrderTranList[index];
                  return TextWidget(text: record.code);
                },
                itemCount: controller.rsOrderTranList.length,
              );
            }),
          ],
        ),
      ),
    );
  }
}
