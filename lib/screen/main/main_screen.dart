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
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: kWhite,
          selectedItemColor: kPrimaryColor,
          currentIndex: _controller.currentIndex.value,
          onTap: (value) {
            _controller.changeIndex(value);
            _pageCtr.jumpToPage(value);
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
        icon: GetBuilder<CartController>(
          builder: (controller) {
            final cartItem = controller.state ?? [];
            return Badge.count(
              isLabelVisible: cartItem.isNotEmpty,
              count: cartItem.length,
              offset: Offset(5.scale, -5.scale),
              child: Icon(
                Icons.shopping_bag_rounded,
                size: 24.scale,
              ),
            );
          },
        ),
        label: 'cart'.tr,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.menu_rounded,
          size: 24.scale,
        ),
        label: 'menu'.tr,
      ),
    ];
  }
}
