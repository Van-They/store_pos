import 'package:get/get.dart';
import 'package:store_pos/core/data_source/api.dart';
import 'package:store_pos/core/data_source/api_client.dart';
import 'package:store_pos/core/repository/product_repo.dart';

class Injection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Api>(() => ApiClient());
    Get.lazyPut<ProductRepo>(() => ProductRepo(Get.find()));
  }
}
