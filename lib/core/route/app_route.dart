import 'package:get/get.dart';
import 'package:store_pos/screen/cart/cart_screen.dart';
import 'package:store_pos/screen/cart/components/check_out_screen.dart';
import 'package:store_pos/screen/cart/components/select_customer_screen.dart';
import 'package:store_pos/screen/cart/components/select_payment_screen.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/category/components/fetch_item_by_category_screen.dart';
import 'package:store_pos/screen/dashboard/home_slider/home_slider_controller.dart';
import 'package:store_pos/screen/home/home_screen.dart';
import 'package:store_pos/screen/main/main_screen.dart';
import 'package:store_pos/screen/menu/menu_screen.dart';
import 'package:store_pos/screen/dashboard/group/components/group_set_up_screen.dart';
import 'package:store_pos/screen/dashboard/group/group_item_screen.dart';
import 'package:store_pos/screen/dashboard/home_slider/home_slider_screen.dart';
import 'package:store_pos/screen/dashboard/import_item/import_item_controller.dart';
import 'package:store_pos/screen/dashboard/import_item/import_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/components/fetch_group_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/components/item_set_up_screen.dart';
import 'package:store_pos/screen/dashboard/item/item_controller.dart';
import 'package:store_pos/screen/dashboard/item/item_screen.dart';
import 'package:store_pos/screen/dashboard/main_merchant_screen.dart';
import 'package:store_pos/screen/menu/components/change_language_screen.dart';
import 'package:store_pos/screen/menu/components/wishlist_screen.dart';

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
      binding: BindingsBuilder.put(() => ItemController())),
  GetPage(
      name: FetchItemByCategory.routeName,
      page: () => const FetchItemByCategory(),
      binding: BindingsBuilder.put(() => ItemController())),
  GetPage(
      name: WishlistScreen.routeName,
      page: () => const WishlistScreen(),
      binding: BindingsBuilder.put(() => ItemController())),
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
    name: SelectCustomerScreen.routeName,
    page: () => const SelectCustomerScreen(),
  ),
  GetPage(
    name: SelectPaymentScreen.routeName,
    page: () => const SelectPaymentScreen(),
  ),
  GetPage(
    name: FetchGroupItemScreen.routeName,
    page: () => const FetchGroupItemScreen(),
  ),
  GetPage(
    name: ChangeLanguageScreen.routeName,
    page: () => const ChangeLanguageScreen(),
  ),
  GetPage(
    name: ImportItemScreen.routeName,
    binding: BindingsBuilder.put(() => ImportItemController()),
    page: () => const ImportItemScreen(),
  ),
  GetPage(
    name: HomeSliderScreen.routeName,
    binding: BindingsBuilder.put(() => HomeSliderController()),
    page: () => const HomeSliderScreen(),
  ),
];
