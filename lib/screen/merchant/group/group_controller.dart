import 'package:get/get.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/repository/group_item_repo.dart';

class GroupController extends GetxController
    with StateMixin<List<GroupItemModel>> {
  RxString imgPath = ''.obs;

  final groupRepo = Get.find<GroupItemRepo>();

  @override
  void onInit() {
    onGetGroupItem();
    super.onInit();
  }

  Future<void> onGetGroupItem() async {
    try {
      change(state, status: RxStatus.loading());
      final result = await groupRepo.onGetGroupItem();
      result.fold((l) {
        change(state, status: RxStatus.empty());
      }, (r) {
        change(r.record, status: RxStatus.success());
      });
    } on Exception {
      return;
    }
  }

  Future<bool> onCreateGroupItem({required Map<String, dynamic> arg}) async {
    try {
      change(state, status: RxStatus.loading());
      final result = await groupRepo.onCreateGroupItem(arg: arg);
      result.fold((l) {
        change(state, status: RxStatus.error());
      }, (r) {
        final newGroup = GroupItemModel.fromMap(arg);
        final data = state ?? [];
        data.add(newGroup);
        change(data, status: RxStatus.success());
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
