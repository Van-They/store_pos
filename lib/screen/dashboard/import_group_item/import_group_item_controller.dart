import 'package:get/get.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/repository/group_item_repo.dart';

class ImportGroupItemController extends GetxController {
  RxList<GroupItemModel> itemGroupList = <GroupItemModel>[].obs;
  RxBool isLoading = false.obs;
  final _repo = Get.find<GroupItemRepo>();

  Future<void> onCreateImportGroupItem({
    required Map<String, dynamic> arg,
  }) async {
    try {
      final result = await _repo.onCreateImportGroupItem(arg: arg);
      result.fold((l) => throw Exception(), (r) {

      });
    } catch (e) {
      rethrow;
    }
  }
}
