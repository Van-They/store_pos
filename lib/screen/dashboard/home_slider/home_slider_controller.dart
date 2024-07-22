import 'package:get/get.dart';
import 'package:store_pos/core/repository/merchant_menu_repo.dart';

class HomeSliderController extends GetxController {
  RxList<String> imgSlider = <String>[].obs;

  final MerchantMenuRepo _repo = Get.find<MerchantMenuRepo>();

  @override
  void onInit() {
    super.onInit();
    onGetSlider();
  }

  Future<void> onGetSlider() async {
    try {
      _repo.onGetSlider();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> onDeleteSlide() async {
    try {
      _repo.onDeleteSlide();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> onAddSlide() async {
    try {
      _repo.onAddSlide();
    } catch (e) {
      rethrow;
    }
  }
}
