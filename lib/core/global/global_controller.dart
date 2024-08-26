import 'package:get/get.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class GlobalController extends GetxController {
  RxList<String> itemCartCode = <String>[].obs;
  RxList<String> itemWishListCode = <String>[].obs;

  final _repo = Get.find<ItemRepo>();

  @override
  void onInit() {
    _onGetItemCartListCodes();
    super.onInit();
  }

  Future<void> _onGetItemCartListCodes() async {
    final result = await _repo.onGetItemCartListCodes();
    result.foldRight(null, (r, previous) {
      itemCartCode.value = r.record;
    });
  }

  Future<void> _onGetItemWishListCodes() async {
    final result = await _repo.onGetItemWishListCodes();
    result.foldRight(null, (r, previous) {
      itemWishListCode.value = r.record;
    });
  }
}
