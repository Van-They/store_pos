import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/cart/cart_screen.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/home/home_screen.dart';
import 'package:store_pos/screen/main/main_controller.dart';
import 'package:store_pos/screen/menu/menu_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = MainController();
  late PageController _pageCtr;

  @override
  void initState() {
    _pageCtr = PageController(initialPage: _controller.currentIndex.value);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageCtr,
        children: const [
          HomeScreen(),
          CategoryScreen(),
          CartScreen(),
          MenuScreen(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.scale),
          topLeft: Radius.circular(20.scale),
        ),
        child: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: kBlack.withOpacity(0.5),
            backgroundColor: kWhite,
            selectedItemColor: kBlack,
            iconSize: 24.scale,
            elevation: 4,
            currentIndex: _controller.currentIndex.value,
            onTap: (value) {
              _controller.changeIndex(value);
              _pageCtr.animateToPage(
                value,
                duration: const Duration(milliseconds: 120),
                curve: Curves.bounceInOut,
              );
            },
            items: _buildBottomNavItems(),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavItems() {
    return [
      BottomNavigationBarItem(
        icon: _controller.currentIndex.value == 0
            ? const Icon(Icons.home_rounded)
            : const Icon(Icons.home_outlined),
        label: 'home'.tr,
      ),
      BottomNavigationBarItem(
        icon: _controller.currentIndex.value == 1
            ? const Icon(Icons.category_rounded)
            : const Icon(Icons.category_outlined),
        label: 'category'.tr,
      ),
      BottomNavigationBarItem(
        icon: GetBuilder<CartController>(
          builder: (controller) {
            final cartItem = controller.orderTranList;
            return Badge.count(
              isLabelVisible: cartItem.isNotEmpty,
              count: cartItem.length,
              offset: Offset(5.scale, -5.scale),
              child: _controller.currentIndex.value == 2
                  ? const Icon(Icons.shopping_bag_rounded)
                  : const Icon(Icons.shopping_bag_outlined),
            );
          },
        ),
        label: 'cart'.tr,
      ),
      BottomNavigationBarItem(
        icon: _controller.currentIndex.value == 3
            ? const Icon(Icons.menu_rounded)
            : const Icon(Icons.menu_outlined),
        label: 'menu'.tr,
      ),
    ];
  }
}
