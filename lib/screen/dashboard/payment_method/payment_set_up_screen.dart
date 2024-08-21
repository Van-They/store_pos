import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/screen/dashboard/payment_method/payment_method_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

class PaymentSetupScreen extends GetView<PaymentMethodController> {
  const PaymentSetupScreen({super.key});

  static const String routeName = "/PaymentSetupScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "set_up_payment_method".tr,
        isBack: true,
      ),
    );
  }
}
