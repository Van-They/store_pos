import 'package:get/get.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/repository/cart_repo.dart';
import 'package:store_pos/core/repository/group_item_repo.dart';
import 'package:store_pos/core/repository/item_repo.dart';
import 'package:store_pos/screen/merchant/group/group_controller.dart';

class Injection extends Bindings {
  @override
  void dependencies() => _init();
}

void _init() {
  //repo
  Get.lazyPut<GroupItemRepo>(() => GroupItemRepo(Get.find<Api>()), fenix: true);
  Get.lazyPut<ItemRepo>(() => ItemRepo(Get.find<Api>()), fenix: true);
  Get.lazyPut<CartRepo>(() => CartRepo(Get.find<Api>()), fenix: true);

  //controller
  Get.lazyPut<CartController>(() => CartController(), fenix: true);
  Get.lazyPut<GroupController>(() => GroupController(), fenix: true);
}

void clearDependencies() {
  // Clear all instances
  Get.delete<GroupItemRepo>();
  Get.delete<ItemRepo>();
  Get.delete<CartRepo>();
  Get.delete<CartController>();
  Get.delete<GroupController>();
  _init();
}
