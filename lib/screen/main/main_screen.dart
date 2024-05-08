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

  static const String routeName = '/main';

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
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: controller.currentIndex.value,
          onTap: (value) {
            controller.changeIndex(value);
            pageCtr.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
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
          size: 24.scale,
        ),
        label: 'home'.tr,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.category_rounded,
          size: 24.scale,
        ),
        label: 'category'.tr,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_bag_rounded,
          size: 24.scale,
        ),
        label: 'cart'.tr,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.settings_rounded,
          size: 24.scale,
        ),
        label: 'menu'.tr,
      ),
    ];
  }
}
