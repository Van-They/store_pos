import 'package:get/get.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/repository/group_item_repo.dart';
import 'package:store_pos/core/repository/item_repo.dart';
import 'package:store_pos/core/repository/merchant_menu_repo.dart';

class HomeController extends GetxController {
  RxList<GroupItemModel> groupList = <GroupItemModel>[].obs;
  RxList<ItemModel> itemList = <ItemModel>[].obs;
  RxList<String> imgSlider = <String>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isScrolled = false.obs;

  final GroupItemRepo groupItemRepo = Get.find<GroupItemRepo>();
  final ItemRepo repo = Get.find<ItemRepo>();
  final merChantRepo = Get.find<MerchantMenuRepo>();

  Future<void> onGetHomeItems({Map? arg}) async {
    try {
      await repo.onGetHomeItems(arg: arg).then((value) {
        value.fold((l) => throw GeneralException(), (r) {
          itemList.value = r.record;
        });
      });
    } on GeneralException {
      rethrow;
    }
  }

  Future<void> onGetGroup({Map? arg}) async {
    try {
      await groupItemRepo.onGetGroupItemHome().then((value) {
        value.fold((l) => throw GeneralException(), (r) {
          groupList.value = r.record;
        });
      });
    } on GeneralException {
      rethrow;
    }
  }

  Future<void> onGetSlider() async {
    try {
      await merChantRepo.onGetSlider().then((value) {
        value.fold((l) => throw GeneralException(), (r) {
          imgSlider.value = r.record;
        });
      });
    } on GeneralException {
      rethrow;
    }
  }
}
