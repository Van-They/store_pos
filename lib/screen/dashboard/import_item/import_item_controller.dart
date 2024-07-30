import 'package:get/get.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class ImportItemController extends GetxController {
  RxList<ItemModel> itemList = <ItemModel>[].obs;
  RxBool isLoading = false.obs;

  final repo = Get.find<ItemRepo>();

  Future<bool> onCreateImportItem({required Map<String, dynamic> arg}) async {
    try {
      final result = await repo.onCreateImportItem(arg: arg);
      result.fold((l) => throw Exception(), (r) => {});
      return true;
    } catch (e) {
      return false;
    }
  }
}
