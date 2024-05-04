import 'package:get/get.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/data_source/api_client.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class Injection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Api>(() => ApiClient());
    Get.lazyPut<ItemRepo>(() => ItemRepo(Get.find<Api>()));
  }
}
