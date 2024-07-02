import 'package:get/get.dart';

import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class ItemController extends GetxController with StateMixin<List<ItemModel>> {
  final itemRepo = Get.find<ItemRepo>();

  @override
  void onInit() {
    onGetItem();
    super.onInit();
  }

  Future<void> onGetItem() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await itemRepo.onGetItem();
      result.fold((l) {
        throw Exception();
      }, (r) {
        if (r.record.isEmpty) {
          change([], status: RxStatus.empty());
          return;
        }
        change(r.record, status: RxStatus.success());
      });
    } on Exception {
      change([], status: RxStatus.error());
      return;
    }
  }

  Future<bool> onCreateItem({required Map<String, dynamic> arg}) async {
    try {
      change(state, status: RxStatus.loading());
      final result = await itemRepo.onCreateItem(arg: arg);
      result.fold((l) {
        throw Exception();
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

  Future<void> onDeleteItem(String code) async {
    try {
      final result = await itemRepo.onDeleteItem(code);
      result.fold((l) {
        change(state, status: RxStatus.error());
      }, (r) {
        final data = state ?? [];
        final index = data.indexWhere((element) => element.code == code);
        if (index != -1) {
          data.removeAt(index);
        }
        if (data.isEmpty) {
          change(data, status: RxStatus.empty());
          return;
        }
        change(data, status: RxStatus.success());
      });
    } on Exception {
      rethrow;
    }
  }
}
