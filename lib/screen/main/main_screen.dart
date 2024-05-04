import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/cart/cart_screen.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/home/home_screen.dart';
import 'package:store_pos/screen/main/main_controller.dart';
import 'package:store_pos/screen/menu/MenuScreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    final pageCtr = PageController(initialPage: controller.currentIndex.value);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageCtr,
        children: const [
          HomeScreen(),
          CategoryScreen(),
          CartScreen(),
          MenuScreen(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          onTap: (value) {
            controller.changeIndex(value);
            pageCtr.jumpToPage(value);
          },
          items: _buildBottomNavItems(),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home_rounded,
          size: scaleFactor(24),
        ),
        label: 'home'.tr,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.category_rounded,
          size: scaleFactor(24),
        ),
        label: 'category'.tr,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_bag_rounded,
          size: scaleFactor(24),
        ),
        label: 'cart'.tr,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.settings_rounded,
          size: scaleFactor(24),
        ),
        label: 'menu'.tr,
      ),
    ];
  }
}
