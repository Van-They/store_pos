import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/screen/dashboard/cash_report/cash_report_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

class CashReportScreen extends GetView<CashReportController> {
  const CashReportScreen({super.key});

  static const String routeName = "/CashReportScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'cash_report'.tr,
        isBack: true,
      ),
    );
  }
}
