import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/data_source/api_client.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/global/wish_list_controller.dart';
import 'package:store_pos/core/repository/cart_repo.dart';
import 'package:store_pos/core/repository/group_item_repo.dart';
import 'package:store_pos/core/repository/item_repo.dart';
import 'package:store_pos/core/repository/merchant_menu_repo.dart';
import 'package:store_pos/core/repository/order_head_repo.dart';
import 'package:store_pos/screen/dashboard/group/group_controller.dart';

class DInjection extends Bindings {
  Database database;
  DInjection(this.database);
  @override
  void dependencies() => _init(database);
}

void _init(Database database) async {
  Get.put<Api>(ApiClient(database), permanent: true);
  //repo
  Get.lazyPut<GroupItemRepo>(() => GroupItemRepo(Get.find<Api>()), fenix: true);
  Get.lazyPut<ItemRepo>(() => ItemRepo(Get.find<Api>()), fenix: true);
  Get.lazyPut<CartRepo>(() => CartRepo(Get.find<Api>()), fenix: true);
  Get.lazyPut<OrderHeadRepo>(() => OrderHeadRepo(Get.find<Api>()), fenix: true);
  Get.lazyPut<MerchantMenuRepo>(() => MerchantMenuRepo(Get.find<Api>()),
      fenix: true);

  //controller
  Get.lazyPut<CartController>(() => CartController(), fenix: true);
  Get.lazyPut<WishListController>(() => WishListController(), fenix: true);
  Get.lazyPut<GroupController>(() => GroupController(), fenix: true);
}

void clearDependencies() {
  // Clear all instances
  Get.delete<GroupItemRepo>();
  Get.delete<ItemRepo>();
  Get.delete<CartRepo>();
  Get.delete<CartController>();
  Get.delete<GroupController>();
}
