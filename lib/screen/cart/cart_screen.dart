import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

class CartScreen extends GetView {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'cart'),
    );
  }
}
