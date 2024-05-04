import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

class MenuScreen extends GetView {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'menu'),
    );
  }
}
