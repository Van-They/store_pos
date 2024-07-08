import 'package:get/get.dart';

import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class ItemController extends GetxController {
  RxList<ItemModel> itemList = <ItemModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isScrolled = false.obs;
  RxBool isSearching = false.obs;
  RxBool isAddingNew = false.obs;
  RxBool isUpdating = false.obs;

  final itemRepo = Get.find<ItemRepo>();

  @override
  void onInit() {
    onGetItem();
    super.onInit();
  }

  Future<void> onGetItem() async {
    try {
      isLoading.value = true;
      final result = await itemRepo.onGetItem();
      result.fold((l) {
        throw Exception();
      }, (r) {
        itemList.value = r.record;
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> onCreateItem({required Map<String, dynamic> arg}) async {
    try {
      isAddingNew.value = true;
      final result = await itemRepo.onCreateItem(arg: arg);
      result.fold((l) {
        throw Exception();
      }, (r) {
        final newItem = ItemModel.fromMap(arg);
        itemList.add(newItem);
        itemList.refresh();
      });
      return true;
    } on Exception {
      return false;
    } finally {
      isAddingNew.value = false;
    }
  }

  Future<void> onDeleteItem(String code) async {
    try {
      final result = await itemRepo.onDeleteItem(code);
      result.fold((l) {}, (r) {
        itemList.removeWhere((element) => element.code == code);
        itemList.refresh();
      });
    } on Exception {
      rethrow;
    }
  }

  Future<bool> onUpdateItem({required Map<String, dynamic> arg}) async {
    try {
      final result = await itemRepo.onUpdateItem(arg: arg);
      result.fold((l) {
        throw Exception();
      }, (r) {
        final newGroup = ItemModel.fromMap(arg);
        final data = itemList.obs.value ?? [];
        final index = data.indexWhere((element) => element.code == arg['code']);
        if (index != -1) {
          data[index] = newGroup;
          itemList.refresh();
        }
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
