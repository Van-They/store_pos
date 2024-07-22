import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/category/components/fetch_item_by_category_screen.dart';
import 'package:store_pos/screen/home/home_controller.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/item_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const String routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    Get.put<HomeController>(HomeController());
    final ValueNotifier<int> indicator = ValueNotifier(0);
    return Scaffold(
      body: _buildItemList(indicator),
    );
  }

  _buildItemList(ValueNotifier<int> indicator) {
    final listSlider = [
      'asset/images/mustang.jpg',
      'asset/images/mustang_2.jpg',
      'asset/images/img_not_available.jpg'
    ];
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          titleSpacing: appSpace.scale,
          toolbarHeight: kToolbarHeight + (appSpace.scale),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: _greeting(),
                      fontSize: 20.scale,
                      color: kPrimaryColor,
                    ),
                    TextWidget(
                      text: 'Vanthey Thorng',
                      fontSize: 22.scale,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ],
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20.scale,
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: kWhite,
                    size: 18.scale,
                  ),
                ),
                SizedBox(width: appSpace.scale),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20.scale,
                  child: Icon(
                    Icons.notifications_active,
                    size: 20.scale,
                    color: kWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: appSpace.scale)),
        SliverToBoxAdapter(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider.builder(
                itemCount: listSlider.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: appPadding.scale),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(listSlider[index]),
                      ),
                      borderRadius: BorderRadius.circular(appSpace.scale),
                    ),
                    width: double.infinity,
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    indicator.value = index;
                  },
                  autoPlayInterval: const Duration(seconds: 5),
                  height: 170.scale,
                ),
              ),
              Positioned(
                bottom: 8.scale,
                child: ValueListenableBuilder(
                  valueListenable: indicator,
                  builder: (context, value, child) {
                    return AnimatedSmoothIndicator(
                      activeIndex: value,
                      count: listSlider.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: kPrimaryColor,
                        dotColor: kWhite,
                        expansionFactor: 2,
                        dotWidth: 6.scale,
                        dotHeight: 4.scale,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: appSpace.scale)),
        SliverToBoxAdapter(
          child: BoxWidget(
            backgroundColor: kTransparent,
            onTap: () {
              Get.toNamed(CategoryScreen.routeName, arguments: {"back": true});
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
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18.scale,
                    ),
                  ],
                ),
                SizedBox(height: appSpace.scale),
                Obx(
                  () {
                    return SizedBox(
                      height: 120.scale,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.groupList.length,
                        itemBuilder: (context, index) {
                          final record = controller.groupList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                FetchItemByCategory.routeName,
                                arguments: {"title": record.code},
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: appSpace.scale),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(4.scale),
                                    ),
                                    width: 120.scale,
                                    height: double.infinity,
                                    child: ImageWidget(
                                      imgPath: record.imgPath,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: 120.scale,
                                      height: 30.scale,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                            appSpace.scale,
                                          ),
                                          bottomRight: Radius.circular(
                                            appSpace.scale,
                                          ),
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            kPrimaryColor.withOpacity(0.001),
                                            kPrimaryColor.withOpacity(0.7),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: TextWidget(
                                        text: record.description,
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: appPadding.scale)),
        SliverToBoxAdapter(
          child: Obx(
            () {
              final records = controller.itemList.obs.value;
              if (records.isEmpty) {
                return const SizedBox.shrink();
              }
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
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: appSpace.scale)),
      ],
    );
  }

  String _greeting() {
    final hour = TimeOfDay.fromDateTime(DateTime.now()).hour;
    if (hour >= 12 && hour <= 1) {
      return 'good_morning'.tr;
    }
    if (hour >= 12 && hour <= 13) {
      return 'good_afternoon'.tr;
    }
    return 'good_evening'.tr;
  }
}
