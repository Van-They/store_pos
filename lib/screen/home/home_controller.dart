import 'package:get/get.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/repository/group_item_repo.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class HomeController extends GetxController {
  RxList<GroupItemModel> groupList = <GroupItemModel>[].obs;
  RxList<ItemModel> itemList = <ItemModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isScrolled = false.obs;

  final GroupItemRepo groupItemRepo = Get.find<GroupItemRepo>();
  final ItemRepo repo = Get.find<ItemRepo>();


  @override
  void onInit() {
    super.onInit();
    onGetHomeItems();
    onGetGroup();
  }

  Future<void> onGetHomeItems({Map? arg}) async {
    try {
      isLoading.value = true;
      await repo.onGetHomeItems(arg: arg).then((value) {
        value.fold((l) => throw GeneralException(), (r) {
          itemList.value = r.record;
        });
      });
    } on GeneralException {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onGetGroup({Map? arg}) async {
    try {
      isLoading.value = true;
      await groupItemRepo.onGetGroupItemHome().then((value) {
        value.fold((l) => throw GeneralException(), (r) {
          groupList.value = r.record;
        });
      });
    } on GeneralException {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
