import 'package:get/get.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';

class ImportGroupItemController extends GetxController {
  RxList<GroupItemModel> itemGroupList = <GroupItemModel>[].obs;
  RxBool isLoading = false.obs;
}
