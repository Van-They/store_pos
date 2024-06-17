import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/home/home_controller.dart';
import 'package:store_pos/screen/merchant/group/group_item_screen.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/item_widget.dart';
import 'package:store_pos/widget/loading_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const String routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    Get.put<HomeController>(HomeController());
    controller.onGetHomeItems();
    controller.onGetGroup();
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(text: 'Cambodia Modern Drone', fontSize: 18.scale),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active_rounded,
                size: 24.scale,
              ),
            ),
          ],
        ),
        titleSpacing: appSpace.scale,
        toolbarHeight: kToolbarHeight,
      ),
      body: _buildItemList(),
    );
  }

  _buildItemList() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(appSpace.scale),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(appSpace.scale),
                ),
                width: double.infinity,
                height: 150.scale,
              ),
              Positioned(
                bottom: 15.scale,
                child: AnimatedSmoothIndicator(
                  activeIndex: 1,
                  count: 5,
                  effect: ExpandingDotsEffect(
                    expansionFactor: 2,
                    dotWidth: appSpace.scale,
                    dotHeight: appSpace.scale,
                  ),
                ),
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: BoxWidget(
            onTap: () {
              Get.toNamed(CategoryScreen.routeName);
            },
            padding: EdgeInsets.symmetric(
              horizontal: 16.scale,
              vertical: appSpace.scale,
            ),
            radius: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: 'category'.tr),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(GroupItemScreen.routeName);
                      },
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18.scale,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: appSpace.scale),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                        List.generate(controller.groupList.length, (index) {
                      final record = controller.groupList[index];
                      return Padding(
                        padding: EdgeInsets.only(right: appSpace.scale),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius:
                                    BorderRadius.circular(appSpace.scale),
                              ),
                              width: 70.scale,
                              height: 70.scale,
                              child: ImageWidget(
                                imgPath: record.imgPath,
                              ),
                            ),
                            TextWidget(text: record.description)
                          ],
                        ),
                      );
                    }),
                  );
                }),

                // SizedBox(
                //   height: 100.scale,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 5,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         margin: EdgeInsets.only(right: appSpace.scale),
                //         decoration: BoxDecoration(
                //           color: Colors.blueAccent,
                //           borderRadius: BorderRadius.circular(appSpace.scale),
                //         ),
                //         width: 160.scale,
                //         height: double.infinity,
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: controller.obx(
            (state) {
              final records = state ?? [];
              return MasonryGridView.builder(
                itemCount: records.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16.scale,
                mainAxisSpacing: 16.scale,
                padding: EdgeInsets.all(16.scale),
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: itemCanFitHorizontal(width: 150.scale),
                ),
                itemBuilder: (context, index) {
                  final record = records[index];
                  return ItemWidget(record: record);
                },
              );
            },
            onLoading: const LoadingWidget(),
            onEmpty: const Center(
              child: Text('Empty'),
            ),
          ),
        ),
      ],
    );
  }
}
