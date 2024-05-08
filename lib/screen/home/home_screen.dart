import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/home/home_controller.dart';
import 'package:store_pos/widget/box_widget.dart';
import 'package:store_pos/widget/input_text_widget.dart';
import 'package:store_pos/widget/item_widget.dart';
import 'package:store_pos/widget/loading_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    final controller = HomeController()..onGetHomeItems();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.qr_code_2_rounded,
                size: 24.scale,
              ),
            ),
            const Expanded(child: InputTextWidget()),
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
      backgroundColor: kBgColor,
      body: GestureDetector(
        onTap: () => Get.focusScope!.unfocus(),
        child: controller.obx(
          (state) => _buildItemList(state),
          onLoading: const LoadingWidget(),
          onEmpty: const Center(
            child: Text('Empty'),
          ),
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
            margin: EdgeInsets.zero,
            radius: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(text: 'category'),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18.scale,
                    ),
                  ],
                ),
                SizedBox(height: appSpace.scale),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: appSpace.scale,
                  children: List.generate(
                    5,
                    (index) => Column(
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
                    ),
                  ),
                ),
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
          child: MasonryGridView.builder(
            itemCount: records.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: appSpace.scale,
            padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Get.width ~/ 150.scale,
            ),
            itemBuilder: (context, index) {
              final record = records[index];
              return ItemWidget(record: record);
            },
          ),
        ),
      ],
    );
  }
}
