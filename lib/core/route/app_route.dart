import 'package:get/get.dart';
import 'package:store_pos/screen/cart/cart_screen.dart';
import 'package:store_pos/screen/cart/components/check_out_screen.dart';
import 'package:store_pos/screen/cart/components/select_customer_screen.dart';
import 'package:store_pos/screen/cart/components/select_payment_screen.dart';
import 'package:store_pos/screen/category/category_screen.dart';
import 'package:store_pos/screen/category/components/fetch_item_by_category_screen.dart';
import 'package:store_pos/screen/dashboard/cash_report/cash_report_controller.dart';
import 'package:store_pos/screen/dashboard/cash_report/cash_report_screen.dart';
import 'package:store_pos/screen/dashboard/customer/customer_controller.dart';
import 'package:store_pos/screen/dashboard/customer/customer_screen.dart';
import 'package:store_pos/screen/dashboard/daily_sale_report/daily_sale_controller.dart';
import 'package:store_pos/screen/dashboard/daily_sale_report/daily_sale_report_screen.dart';
import 'package:store_pos/screen/dashboard/group/components/update_group_screen.dart';
import 'package:store_pos/screen/dashboard/group/group_controller.dart';
import 'package:store_pos/screen/dashboard/home_slider/home_slider_controller.dart';
import 'package:store_pos/screen/dashboard/import_group_item/import_group_item_controller.dart';
import 'package:store_pos/screen/dashboard/import_group_item/import_group_item_screen.dart';
import 'package:store_pos/screen/dashboard/invoice_report/component/invoice_detail_screen.dart';
import 'package:store_pos/screen/dashboard/invoice_report/invoice_report_controller.dart';
import 'package:store_pos/screen/dashboard/invoice_report/invoice_report_screen.dart';
import 'package:store_pos/screen/dashboard/item/components/update_item_controller.dart';
import 'package:store_pos/screen/dashboard/item/components/update_item_screen.dart';
import 'package:store_pos/screen/dashboard/payment_method/payment_method_controller.dart';
import 'package:store_pos/screen/dashboard/payment_method/payment_method_screen.dart';
import 'package:store_pos/screen/dashboard/setting/setting_controller.dart';
import 'package:store_pos/screen/dashboard/setting/setting_screen.dart';
import 'package:store_pos/screen/home/home_screen.dart';
import 'package:store_pos/screen/main/main_screen.dart';
import 'package:store_pos/screen/menu/controller/language_controller.dart';
import 'package:store_pos/screen/menu/menu_screen.dart';
import 'package:store_pos/screen/dashboard/group/components/group_set_up_screen.dart';
import 'package:store_pos/screen/dashboard/group/group_item_screen.dart';
import 'package:store_pos/screen/dashboard/home_slider/home_slider_screen.dart';
import 'package:store_pos/screen/dashboard/import_item/import_item_controller.dart';
import 'package:store_pos/screen/dashboard/import_item/import_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/components/fetch_group_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/components/set_up_item_screen.dart';
import 'package:store_pos/screen/dashboard/item/item_controller.dart';
import 'package:store_pos/screen/dashboard/item/item_screen.dart';
import 'package:store_pos/screen/dashboard/dashboard_screen.dart';
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
    name: SetupItemScreen.routeName,
    page: () {
      Get.find<ItemController>().onOpenTransaction();
      return const SetupItemScreen();
    },
  ),
  GetPage(
    name: GroupItemScreen.routeName,
    page: () => const GroupItemScreen(),
  ),
  GetPage(
    name: DashboardScreen.routeName,
    page: () => const DashboardScreen(),
  ),
  GetPage(
    name: GroupSetupScreen.routeName,
    page: () {
      Get.find<GroupController>().onOpenTransaction();
      return const GroupSetupScreen();
    },
  ),
  GetPage(
    name: UpdateGroupScreen.routeName,
    page: () {
      final arg = Get.arguments ?? {};
      Get.find<GroupController>()
        ..onOpenTransaction()
        ..onGetGroupToUpdate(groupCode: arg['code']);
      return const UpdateGroupScreen();
    },
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
    binding: BindingsBuilder.put(() => LanguageController()),
    page: () => const ChangeLanguageScreen(),
  ),
  GetPage(
    name: ImportItemScreen.routeName,
    binding: BindingsBuilder.put(() => ImportItemController()),
    page: () => const ImportItemScreen(),
  ),
  GetPage(
    name: ImportGroupItemScreen.routeName,
    binding: BindingsBuilder.put(() => ImportGroupItemController()),
    page: () => const ImportGroupItemScreen(),
  ),
  GetPage(
    name: CashReportScreen.routeName,
    binding: BindingsBuilder.put(() => CashReportController()),
    page: () => const CashReportScreen(),
  ),
  GetPage(
    name: UpdateItemScreen.routeName,
    binding: BindingsBuilder.put(() => UpdateItemController()),
    page: () => const UpdateItemScreen(),
  ),
  GetPage(
    name: InvoiceReportScreen.routeName,
    binding: BindingsBuilder.put(
      () => InvoiceReportController()..onGetInvoiceList(),
    ),
    page: () => const InvoiceReportScreen(),
  ),
  GetPage(
    name: InvoiceDetailScreen.routeName,
    binding: BindingsBuilder.put(
      () {
        final arg = Get.arguments ?? {};
        return Get.find<InvoiceReportController>()
          ..onGetInvoiceDetail(arg['invoice'] ?? "");
      },
    ),
    page: () => const InvoiceDetailScreen(),
  ),
  GetPage(
    name: DailySaleReportScreen.routeName,
    binding: BindingsBuilder.put(() => DailySaleController()),
    page: () => const DailySaleReportScreen(),
  ),
  GetPage(
    name: SettingScreen.routeName,
    binding: BindingsBuilder.put(() => SettingController()),
    page: () => const SettingScreen(),
  ),
  GetPage(
    name: PaymentMethodScreen.routeName,
    binding: BindingsBuilder.put(() {
      return PaymentMethodController();
    }),
    page: () => const PaymentMethodScreen(),
  ),
  GetPage(
    name: CustomerScreen.routeName,
    binding: BindingsBuilder.put(() {
      return CustomerController();
    }),
    page: () => const CustomerScreen(),
  ),
  GetPage(
    name: HomeSliderScreen.routeName,
    binding: BindingsBuilder.put(() => HomeSliderController()),
    page: () => const HomeSliderScreen(),
  ),
];
