import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class CategoryScreen extends GetView {
  const CategoryScreen({super.key});

  static const String routeName = '/CategoryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'category'),
      body: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(appSpace.scale),
                ),
                width: 80.scale,
                height: 80.scale,
              ),
              const TextWidget(text: 'categ')
            ],
          );
        },
      ),
    );
  }
}
