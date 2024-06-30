import 'package:get/get.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/repository/group_item_repo.dart';
import 'package:store_pos/core/util/helper.dart';

class GroupController extends GetxController
    with StateMixin<List<GroupItemModel>> {
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
        final data = r.record;
        if (data.isEmpty) {
          change(data, status: RxStatus.empty());
        } else {
          change(data, status: RxStatus.success());
        }
      });
    } on Exception {
      return;
    }
  }

  Future<bool> onCreateGroupItem({required Map<String, dynamic> arg}) async {
    try {
      final result = await groupRepo.onCreateGroupItem(arg: arg);
      result.fold((l) {
        throw Exception();
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

  Future<bool> onDeleteGroup({required Map arg}) async {
    try {
      final result = await groupRepo.onDeleteGroup(arg: arg);
      result.fold((l) {
        throw Exception();
      }, (r) {
        final data = state ?? [];
        final index = data.indexWhere((element) => element.code == arg['code']);
        if (index != -1) {
          data.removeAt(index);
        }
        if (data.isEmpty) {
          change([], status: RxStatus.empty());
          return;
        }
        change(data, status: RxStatus.success());
        showMessage(
            msg: '${arg['code']} ${'deleted'.tr}', status: Status.success);
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> onUpdateGroup({required Map<String, Object?> arg}) async {
    try {
      final result = await groupRepo.onUpdateGroup(arg: arg);
      result.fold((l) {
        throw Exception();
      }, (r) {
        final newGroup = GroupItemModel.fromMap(arg);
        final data = state ?? [];
        final index = data.indexWhere((element) => element.code == arg['code']);
        if (index != -1) {
          data[index] = newGroup;
        }
        change(data, status: RxStatus.success());
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> onToggleDisableGroup({required Map<String, dynamic> arg}) async {
    try {
      final result = await groupRepo.onToggleDisableGroup(arg: arg);
      result.fold((l) {
        throw Exception();
      }, (r) {
        final newGroup = GroupItemModel.fromMap(arg);
        final data = state ?? [];
        final index = data.indexWhere((element) => element.code == arg['code']);
        if (index != -1) {
          data[index] = newGroup;
        }
        change(data, status: RxStatus.success());
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
