import 'package:get/get.dart';
import 'package:store_pos/screen/cart/cart_screen.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/home/home_controller.dart';
import 'package:store_pos/screen/home/home_screen.dart';
import 'package:store_pos/screen/main/main_controller.dart';
import 'package:store_pos/screen/main/main_screen.dart';
import 'package:store_pos/screen/menu/MenuScreen.dart';

List<GetPage<dynamic>> appRoute = [
  GetPage(
    name: '/main',
    page: () => const MainScreen(),
    transition: Transition.zoom,
  ),
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: '/category',
    page: () => const CategoryScreen(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: '/cart',
    page: () => const CartScreen(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: '/menu',
    page: () => const MenuScreen(),
    transition: Transition.leftToRight,
  ),
];
