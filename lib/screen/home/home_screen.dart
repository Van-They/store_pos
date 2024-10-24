import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/images.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/category/components/fetch_item_by_category_screen.dart';
import 'package:store_pos/screen/home/home_controller.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/image_widget.dart';
import 'package:store_pos/widget/item_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController _controller;
  late ValueNotifier<int> _indicator;

  @override
  void initState() {
    _controller = Get.put<HomeController>(HomeController());
    _controller.onGetHomeItems();
    _controller.onGetGroup();
    _controller.onGetSlider();
    _indicator = ValueNotifier(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildItemList(_indicator),
    );
  }

  _buildItemList(ValueNotifier<int> indicator) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        Obx(() => _buildImageSlider(indicator)),
        SliverToBoxAdapter(child: SizedBox(height: appSpace.scale)),
        Obx(
          () {
            final groupList = _controller.groupList;
            return _buildCategory(groupList);
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20.scale)),
        _buildItem(),
        SliverToBoxAdapter(child: SizedBox(height: appSpace.scale)),
      ],
    );
  }

  SliverToBoxAdapter _buildItem() {
    return SliverToBoxAdapter(
      child: Obx(
        () {
          final records = _controller.itemList;
          if (records.isEmpty) {
            return const SizedBox.shrink();
          }
          return MasonryGridView.builder(
            itemCount: records.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
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
    );
  }

  SliverToBoxAdapter _buildCategory(RxList<GroupItemModel> groupList) {
    if (groupList.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(CategoryScreen.routeName, arguments: {"back": true});
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: appPadding.scale),
          child: Column(
            children: [
              SizedBox(height: appSpace.scale),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'browse_by_category'.tr,
                    fontSize: 20.scale,
                    fontWeight: FontWeight.w500,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18.scale,
                  ),
                ],
              ),
              SizedBox(height: appSpace.scale),
              SizedBox(
                height: 60.scale,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: groupList.length,
                  itemBuilder: (context, index) {
                    final record = groupList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          FetchItemByCategory.routeName,
                          arguments: {"title": record.code},
                        );
                      },
                      child: BoxWidget(
                        width: 130.scale,
                        enableShadow: true,
                        margin: EdgeInsets.only(right: appSpace.scale),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.scale),
                              ),
                              width: 60.scale,
                              height: double.infinity,
                              child: ImageWidget(
                                imgPath: record.imgPath,
                              ),
                            ),
                            SizedBox(width: appSpace.scale),
                            Flexible(
                              child: TextWidget(
                                text: record.description,
                                maxLine: 2,
                                color: kBlack,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildImageSlider(
    ValueNotifier<int> indicator,
  ) {
    if (_controller.imgSlider.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }
    return SliverToBoxAdapter(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: _controller.imgSlider.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _loadImage(
                      _controller.imgSlider[index],
                    ),
                  ),
                ),
                width: double.infinity,
              );
            },
            options: CarouselOptions(
              autoPlay: false,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                indicator.value = index;
              },
              autoPlayInterval: const Duration(seconds: 5),
              height: 200.scale,
            ),
          ),
          Positioned(
            bottom: 8.scale,
            child: ValueListenableBuilder(
              valueListenable: indicator,
              builder: (context, value, child) {
                return AnimatedSmoothIndicator(
                  activeIndex: value,
                  count: _controller.imgSlider.length,
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
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      titleSpacing: appSpace.scale,
      toolbarHeight: kToolbarHeight + (appSpace.scale),
      centerTitle: false,
      actions: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 16.scale,
          child: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: kBlack,
            size: 16.scale,
          ),
        ),
        SizedBox(width: appSpace.scale),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 16.scale,
          child: Icon(
            Icons.notifications_active,
            size: 18.scale,
            color: kBlack,
          ),
        ),
        SizedBox(width: appSpace.scale),
      ],
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
        child: TextWidget(
          text: 'Hello Vanthey',
          fontSize: 18.scale,
          fontWeight: FontWeight.w500,
          color: kBlack,
        ),
      ),
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

  _loadImage(String path) {
    if (!File(path).existsSync()) {
      return const AssetImage(no_photo);
    }
    return FileImage(File(path));
  }
}
