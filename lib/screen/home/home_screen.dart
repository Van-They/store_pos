import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/home/home_controller.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/hr.dart';
import 'package:store_pos/widget/loading_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController()..onGetHomeItems();
    return Scaffold(
      appBar: const AppBarWidget(title: 'home'),
      body: controller.obx(
        (state) => _buildItemList(state),
        onLoading: const LoadingWidget(),
        onEmpty: const Center(
          child: Text('Empty'),
        ),
      ),
    );
  }

  _buildItemList(List<ItemModel>? records) {
    if (records == null) {
      return Container();
    }
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: MasonryGridView.builder(
            itemCount: records.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: scaleFactor(appSpace),
            padding: EdgeInsets.symmetric(horizontal: scaleFactor(appSpace)),
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Get.width ~/ scaleFactor(150),
            ),
            itemBuilder: (context, index) {
              final record = records[index];
              return BoxWidget(
                margin: EdgeInsets.only(top: scaleFactor(appSpace)),
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.yellow,
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     image: MemoryImage(bytes),
                      //   ),
                      // ),
                      height: scaleFactor(100),
                    ),
                    Text(record.code),
                    Text(record.description),
                    Text('price'),
                    SizedBox(height: scaleFactor(4)),
                    const Hr(),
                    Container(
                      alignment: Alignment.center,
                      height: scaleFactor(35),
                      child: Text('add_to_cart'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
