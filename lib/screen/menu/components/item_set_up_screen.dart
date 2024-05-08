import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';

class ItemSetUpScreen extends StatelessWidget {
  const ItemSetUpScreen({super.key});
  static const String routeName = '/ItemSetUpScreen';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(title: 'item_setup'),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(appSpace.scale),
          child: Column(
            children: [
              InputTextWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        onTap: () {},
        label: 'save'.tr,
      ),
    );
  }
}
