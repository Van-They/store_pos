import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/home/home_controller.dart';
import 'package:store_pos/screen/menu/components/item_set_up_screen.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/item_widget.dart';
import 'package:store_pos/widget/loading_widget.dart';
import 'package:store_pos/widget/primary_btn_widget.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  static const String routeName = '/ItemScreen';

  @override
  Widget build(BuildContext context) {
    final controller = HomeController()..onGetHomeItems();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(title: 'item'),
      body: controller.obx(
        (state) => _buildItemList(state),
        onLoading: const LoadingWidget(),
        onError: (error) => const Center(child: Text('Empty')),
        onEmpty: const Center(child: Text('Empty')),
      ),
      bottomNavigationBar: PrimaryBtnWidget(
        onTap: () => Get.toNamed(ItemSetUpScreen.routeName),
        label: 'add_new',
      ),
    );
  }

  _buildItemList(List<ItemModel>? records) {
    if (records == null) {
      return Container();
    }
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: appSpace.scale),
              child: ItemWidget(
                record: record,
                isList: true,
              ),
            );
          },
        )
        // SliverToBoxAdapter(
        //   child: MasonryGridView.builder(
        //     itemCount: records.length,
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     crossAxisSpacing: scaleFactor(appSpace),
        //     padding: EdgeInsets.symmetric(horizontal: scaleFactor(appSpace)),
        //     gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: Get.width ~/ scaleFactor(150),
        //     ),
        //     itemBuilder: (context, index) {
        //       final record = records[index];
        //       return ItemWidget(record: record);
        //     },
        //   ),
        // ),
      ],
    );
  }
}
