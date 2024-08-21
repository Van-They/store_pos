import 'package:get/get.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class UpdateItemController extends GetxController {
  Rx<ItemModel> itemModel = ItemModel.fromMap({}).obs;
  RxBool isLoading = false.obs;
  final itemRepo = Get.find<ItemRepo>();

  Future<void> onGetItemById({required String itemCode}) async {
    try {
      isLoading.value = true;
      final result = await itemRepo.onGetItemById(itemCode: itemCode);
      result.fold((l) => throw Exception(), (r) {
        itemModel.value = r.record;
        isLoading.value = false;
      });
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<bool> onUpdateItem({required Map<String, dynamic> arg}) async {
    try {
      final result = await itemRepo.onUpdateItem(arg: arg);
      result.fold((l) {
        throw Exception();
      }, (r) {});
      return true;
    } on Exception {
      return false;
    }
  }
}
