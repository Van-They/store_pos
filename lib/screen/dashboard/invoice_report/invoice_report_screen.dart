import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/order_head_model.dart';
import 'package:store_pos/core/service/app_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/dashboard/invoice_report/component/invoice_detail_screen.dart';
import 'package:store_pos/screen/dashboard/invoice_report/invoice_report_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/empty_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class InvoiceReportScreen extends GetView<InvoiceReportController> {
  const InvoiceReportScreen({super.key});

  static const String routeName = "/InvoiceReportScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'invoice_report'.tr,
        isBack: true,
      ),
      body: Obx(
        () {
          final records = controller.invoiceList;
          if (records.isEmpty) return const EmptyWidget();
          return ListView.builder(
            itemCount: records.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _header();
              }
              final currentIndex = index - 1;
              final invoice = records[index - 1];
              return _rowInvoice(
                invoice,
                currentIndex,
                isOdd: currentIndex.isOdd,
              );
            },
          );
        },
      ),
    );
  }

  Widget _header() {
    return BoxWidget(
      height: 45.scale,
      backgroundColor: kPrimaryColor,
      margin: const EdgeInsets.only(top: 1),
      padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
      radius: 0,
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(1.5),
          4: FlexColumnWidth(2),
        },
        children: [
          TableRow(children: [
            TextWidget(
              text: "num_row".tr,
              color: kWhite,
              textAlign: TextAlign.center,
            ),
            TextWidget(
              text: "invoice_no".tr,
              color: kWhite,
              textAlign: TextAlign.center,
            ),
            TextWidget(
              color: kWhite,
              text: "subtotal".tr,
              textAlign: TextAlign.center,
            ),
            TextWidget(
              text: "discount".tr,
              color: kWhite,
              textAlign: TextAlign.center,
            ),
            TextWidget(
              text: "amount".tr,
              color: kWhite,
              textAlign: TextAlign.center,
            ),
          ])
        ],
      ),
    );
  }

  Widget _rowInvoice(OrderHead invoice, int index, {bool isOdd = false}) {
    return BoxWidget(
      radius: 0,
      backgroundColor: isOdd ? kLabel : kWhite,
      margin: EdgeInsets.only(top: 4.scale),
      padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
      onTap: () => Get.toNamed(
        InvoiceDetailScreen.routeName,
        arguments: {
          "invoice": invoice.invoiceNo,
          "header": invoice,
        },
      ),
      height: 45.scale,
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(1.5),
          4: FlexColumnWidth(2),
        },
        children: [
          TableRow(
            children: [
              TextWidget(
                text: '${index + 1}',
                textAlign: TextAlign.center,
                color: isOdd ? kWhite : null,
              ),
              TextWidget(
                text: invoice.invoiceNo,
                textAlign: TextAlign.center,
                color: isOdd ? kWhite : null,
                fontWeight: FontWeight.w500,
              ),
              TextWidget(
                text: AppService.displayFormat(invoice.subtotal),
                textAlign: TextAlign.center,
                color: isOdd ? kWhite : null,
              ),
              TextWidget(
                text: AppService.displayFormat(invoice.discountAmount),
                textAlign: TextAlign.center,
                color: kRed,
              ),
              TextWidget(
                text: AppService.displayFormat(invoice.grandTotal),
                textAlign: TextAlign.center,
                color: isOdd ? kWhite : null,
              ),
            ],
          )
        ],
      ),
    );
  }
}
