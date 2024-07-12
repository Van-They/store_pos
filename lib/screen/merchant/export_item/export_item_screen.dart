import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

class ExportItemScreen extends StatelessWidget {
  const ExportItemScreen({super.key});
  static const String routeName = "/ExportItemScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'export_item'.tr,
        isBack: true,
      ),
    );
  }
}
