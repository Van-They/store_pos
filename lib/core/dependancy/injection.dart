import 'package:get/get.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/data_source/api_client.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/global/setting_controller.dart';
import 'package:store_pos/core/repository/cart_repo.dart';
import 'package:store_pos/core/repository/group_item_repo.dart';
import 'package:store_pos/core/repository/item_repo.dart';
import 'package:store_pos/core/repository/setting_repo.dart';
import 'package:store_pos/screen/merchant/group/group_controller.dart';

class Injection extends Bindings {
  @override
  void dependencies() {
    Get.put<Api>(permanent: true, ApiClient());
    Get.put<SettingRepo>(SettingRepo(Get.find<Api>()), permanent: true);
    Get.put<SettingController>(SettingController(), permanent: true);
    Get.put<CartRepo>(CartRepo(Get.find<Api>()), permanent: true);
    Get.put<GroupItemRepo>(GroupItemRepo(Get.find<Api>()), permanent: true);
    Get.put<ItemRepo>(ItemRepo(Get.find<Api>()), permanent: true);
    Get.put<CartController>(CartController(), permanent: true);
    Get.put<GroupController>(GroupController());
  }
}
