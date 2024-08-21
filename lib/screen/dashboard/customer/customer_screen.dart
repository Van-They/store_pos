import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/screen/dashboard/customer/customer_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';

class CustomerScreen extends GetView<CustomerController> {
  const CustomerScreen({super.key});

  static const String routeName = "/CustomerScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "customer".tr,
        isBack: true,
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        onTap: () {

        },
        label: "create_customer".tr,
      ),
    );
  }
}
