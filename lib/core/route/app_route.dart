import 'package:get/get.dart';
import 'package:store_pos/screen/cart/cart_screen.dart';
import 'package:store_pos/screen/cart/components/check_out_screen.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/home/home_screen.dart';
import 'package:store_pos/screen/main/main_screen.dart';
import 'package:store_pos/screen/menu/MenuScreen.dart';
import 'package:store_pos/screen/merchant/group/components/group_set_up_screen.dart';
import 'package:store_pos/screen/merchant/group/group_controller.dart';
import 'package:store_pos/screen/merchant/group/group_item_screen.dart';
import 'package:store_pos/screen/merchant/item/components/fetch_group_item_screen.dart';
import 'package:store_pos/screen/merchant/item/components/item_set_up_screen.dart';
import 'package:store_pos/screen/merchant/item/item_screen.dart';
import 'package:store_pos/screen/merchant/main_merchant_screen.dart';

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
  GetPage(
    name: MainMerchantScreen.routeName,
    page: () => const MainMerchantScreen(),
  ),
  GetPage(
    name: GroupSetupScreen.routeName,
    page: () => const GroupSetupScreen(),
  ),
  GetPage(
    name: CheckOutScreen.routeName,
    page: () => const CheckOutScreen(),
  ),
  GetPage(
    name: FetchGroupItemScreen.routeName,
    page: () => const FetchGroupItemScreen(),
    binding: BindingsBuilder(() {
      return Get.lazyPut(() => GroupController());
    }),
  ),
];
