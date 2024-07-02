import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_pos/core/constant/colors.dart';
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
      body: _buildItemList(),
    );
  }

  _buildItemList() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          titleSpacing: appSpace.scale,
          toolbarHeight: kToolbarHeight + (appSpace.scale),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Good morning...',
                      fontSize: 18.scale,
                      color: kPrimaryColor,
                    ),
                    TextWidget(text: 'Vanthey Thorng', fontSize: 24.scale,color: Colors.black.withOpacity(0.8),),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20.scale,
                  child: Icon(
                    FontAwesomeIcons.user,
                    size: 20.scale,
                    color: kWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: appPadding.scale),
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
        SliverToBoxAdapter(child: SizedBox(height: appSpace.scale)),
        SliverToBoxAdapter(
          child: BoxWidget(
            onTap: () {
              Get.toNamed(CategoryScreen.routeName);
            },
            padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
            radius: 0,
            child: Column(
              children: [
                SizedBox(height: appSpace.scale),
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
                Obx(
                  () {
                    return SizedBox(
                      height: 90.scale,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.groupList.length,
                        itemBuilder: (context, index) {
                          final record = controller.groupList[index];
                          return Container(
                            margin: EdgeInsets.only(right: appSpace.scale),
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
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: appSpace.scale),
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
                crossAxisSpacing: appSpace.scale,
                mainAxisSpacing: appSpace.scale,
                padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
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
        SliverToBoxAdapter(child: SizedBox(height: appSpace.scale)),
      ],
    );
  }
}
