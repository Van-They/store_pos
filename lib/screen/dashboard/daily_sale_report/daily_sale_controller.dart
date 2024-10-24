import 'package:get/get.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class DailySaleController extends GetxController {
  RxList<OrderTranModel> rsOrderTranList = <OrderTranModel>[].obs;
  RxBool isLoading = false.obs;
  final itemRepo = Get.find<ItemRepo>();

  @override
  void onInit() {
    onGetItemTran();
    super.onInit();
  }


  Future<void> onGetItemTran() async {
    try {
      isLoading.value = true;
      final result = await itemRepo.onGetItemTran();
      result.fold((l) => throw Exception(), (r) {
        isLoading.value = false;
        rsOrderTranList.value = r.record;
      });
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }
}
