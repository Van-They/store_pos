import 'package:get/get.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class WishListController extends GetxController {
  RxList<String> dataSet = <String>[].obs;
  final itemRepo = Get.find<ItemRepo>();

  @override
  void onInit() {
    onGetWishlist();
    super.onInit();
  }

  void onGetWishlist() async {
    final result = await itemRepo.onGetWishList();
    result.foldRight(
      null,
      (r, previous) {
        dataSet.value = r.record.map((e) => e.code).toList();
      },
    );
  }
}
