import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/model/order_head_model.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/service/app_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/invoice_report/invoice_report_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class InvoiceDetailScreen extends GetView<InvoiceReportController> {
  const InvoiceDetailScreen({super.key});
  static const String routeName = "/InvoiceDetailScreen";
  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments ?? {};
    OrderHead orderHead = arg['header'];
    return Scaffold(
      appBar: AppBarWidget(
        title: arg['invoice'] ?? "",
        isBack: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoxWidget(
              margin: EdgeInsets.all(appSpace.scale),
              padding: EdgeInsets.all(appSpace.scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'summary_data'.tr,
                    fontSize: 18.scale,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: appSpace.scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'invoice_no'.tr),
                      TextWidget(
                        text: orderHead.invoiceNo,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                  SizedBox(height: appSpace.scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'date'.tr),
                      TextWidget(text: orderHead.date)
                    ],
                  ),
                  SizedBox(height: appSpace.scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'customer'.tr),
                      TextWidget(text: orderHead.custName)
                    ],
                  ),
                  SizedBox(height: appSpace.scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'paid_by'.tr),
                      TextWidget(
                        text: orderHead.paymentName,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: appSpace.scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'subtotal'.tr),
                      TextWidget(
                          text: AppService.displayFormat(orderHead.subtotal))
                    ],
                  ),
                  SizedBox(height: appSpace.scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'discount'.tr),
                      TextWidget(
                          text: AppService.displayFormat(
                              orderHead.discountAmount))
                    ],
                  ),
                  SizedBox(height: appSpace.scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'grand_total'.tr),
                      TextWidget(
                        text: AppService.displayFormat(orderHead.grandTotal),
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                ],
              ),
            ),
            BoxWidget(
              margin: EdgeInsets.all(appSpace.scale),
              padding: EdgeInsets.all(appSpace.scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'item_data'.tr,
                    fontSize: 18.scale,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: appSpace.scale),
                  const Divider(),
                  Obx(() {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final record = controller.orderTranList[index];
                        return _buildRowItem(record);
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: controller.orderTranList.length,
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRowItem(OrderTranModel record) {
    return Row(
      children: [
        ImageWidget(
          width: 70.scale,
          height: 70.scale,
          imgPath: record.imagePath,
        ),
        SizedBox(width: appSpace.scale),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: record.displayLang == Language.kh.name
                  ? record.description_2
                  : record.description,
              fontSize: 16.scale,
              fontWeight: FontWeight.w500,
            ),
            TextWidget(text: '${'code'.tr} : ${record.code}'),
            TextWidget(text: '${'qty'.tr} : ${record.qty.toInt()}')
          ],
        ),
        const Spacer(),
        TextWidget(
          text: AppService.displayFormat(record.grandTotal),
          color: kRed,
          fontSize: 16.scale,
        )
      ],
    );
  }
}
