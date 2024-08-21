import 'dart:io';

import 'package:get/get.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/repository/merchant_menu_repo.dart';

class HomeSliderController extends GetxController {
  RxList<String> imgListSlider = <String>[].obs;
  RxBool isFile = false.obs;
  final MerchantMenuRepo _repo = Get.find<MerchantMenuRepo>();

  @override
  void onInit() {
    super.onInit();
    onGetSlider();
  }

  Future<void> onGetSlider() async {
    try {
      await _repo.onGetSlider().then((value) {
        value.fold((l) => throw GeneralException(), (r) {
          imgListSlider.value = r.record;
        });
      });
    } on GeneralException {
      rethrow;
    }
  }

  Future<void> onDeleteSlide(int index) async {
    try {
      final file = File(imgListSlider[index]);
      _repo.onDeleteSlide(imgListSlider[index]);
      file.deleteSync(recursive: true);
      imgListSlider.removeAt(index);
      imgListSlider.refresh();
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

  Future<bool> onSaveImageSlider(String path) async {
    try {
      final result = await _repo.onSaveImageSlider(path);

      result.fold((l) => throw Exception(), (r) {});
      return true;
    } catch (e) {
      return false;
    }
  }
}
