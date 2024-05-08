import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    10,
                    (index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(appSpace.scale),
                          ),
                          width: 100.scale,
                          height: 80.scale,
                        ),
                        const TextWidget(text: 'categ')
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: MasonryGridView.builder(
                shrinkWrap: true,
                crossAxisSpacing: appSpace.scale,
                itemCount: 10,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Get.width ~/ 150.scale,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(appSpace.scale),
                        ),
                        width: double.infinity,
                        height: 80.scale,
                      ),
                      const TextWidget(text: 'pro')
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
