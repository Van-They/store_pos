import 'package:get/get.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/repository/group_item_repo.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class HomeController extends GetxController with StateMixin<List<ItemModel>> {
  RxList<GroupItemModel> groupList = <GroupItemModel>[].obs;
  RxList<ItemModel> itemList = <ItemModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isLoadingScrolled = false.obs;

  final GroupItemRepo groupItemRepo = Get.find<GroupItemRepo>();
  final ItemRepo repo = Get.find<ItemRepo>();

  Future<void> onGetHomeItems({Map? arg}) async {
    try {
      change([], status: RxStatus.loading());
      await repo.onGetHomeItems(arg: arg).then((value) {
        value.fold((l) => throw GeneralException(), (r) {
          final record = r.record;
          if (record.isEmpty) {
            change([], status: RxStatus.empty());
          } else {
            change(record, status: RxStatus.success());
          }
        });
      });
    } on GeneralException {
      change([], status: RxStatus.error());
      rethrow;
    }
  }

  Future<void> onGetGroup({Map? arg}) async {
    try {
      isLoading.value = true;
      await groupItemRepo.onGetGroupItemHome().then((value) {
        value.fold((l) => throw GeneralException(), (r) {
          final record = r.record;
          if (record.isNotEmpty) {
            groupList.value = record;
          }
          isLoading.value = false;
        });
      });
    } on GeneralException {
      rethrow;
    }
  }
}
