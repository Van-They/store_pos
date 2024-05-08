import 'package:get/get.dart';
import 'package:store_pos/screen/cart/cart_screen.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/home/home_screen.dart';
import 'package:store_pos/screen/main/main_screen.dart';
import 'package:store_pos/screen/menu/MenuScreen.dart';
import 'package:store_pos/screen/menu/components/group_item_screen.dart';
import 'package:store_pos/screen/menu/components/item_screen.dart';
import 'package:store_pos/screen/menu/components/item_set_up_screen.dart';

List<GetPage<dynamic>> appRoute = [
  GetPage(
    name: MainScreen.routeName,
    page: () => const MainScreen(),
  ),
  GetPage(
    name: HomeScreen.routeName,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: CategoryScreen.routeName,
    page: () => const CategoryScreen(),
  ),
  GetPage(
    name: CartScreen.routeName,
    page: () => const CartScreen(),
  ),
  GetPage(
    name: MenuScreen.routeName,
    page: () => const MenuScreen(),
  ),
  GetPage(
    name: ItemScreen.routeName,
    page: () => const ItemScreen(),
  ),
  GetPage(
    name: ItemSetUpScreen.routeName,
    page: () => const ItemSetUpScreen(),
  ),
  GetPage(
    name: GroupItemScreen.routeName,
    page: () => const GroupItemScreen(),
  ),
];
