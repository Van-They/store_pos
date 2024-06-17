import 'package:get/get.dart';

import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class ItemController extends GetxController with StateMixin<List<ItemModel>> {
  RxString imgPath = ''.obs;

  final itemRepo = Get.find<ItemRepo>();

  @override
  void onInit() {
    onGetGroupItem();
    super.onInit();
  }

  Future<void> onGetGroupItem() async {
    try {
      change(state, status: RxStatus.loading());
      final result = await itemRepo.onGetItem();
      result.fold((l) {
        change(state, status: RxStatus.empty());
      }, (r) {
        if (r.record.isEmpty) {
          change(r.record, status: RxStatus.empty());
          return;
        }
        change(r.record, status: RxStatus.success());
      });
    } on Exception {
      return;
    }
  }

  Future<bool> onCreateItem({required Map<String, dynamic> arg}) async {
    try {
      change(state, status: RxStatus.loading());
      final result = await itemRepo.onCreateItem(arg: arg);
      result.fold((l) {
        change(state, status: RxStatus.error());
      }, (r) {
        final newItem = ItemModel.fromMap(arg);
        final data = state ?? [];
        data.add(newItem);
        change(data, status: RxStatus.success());
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
