import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/screen/dashboard/invoice_report/invoice_report_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

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
    );
  }
}
