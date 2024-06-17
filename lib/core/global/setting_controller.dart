import 'package:get/get.dart';
import 'package:store_pos/core/data/model/setting_model.dart';
import 'package:store_pos/core/repository/setting_repo.dart';

class SettingController extends GetxController {
  Rx<SettingModel?> settingModel = Rx<SettingModel?>(null);

  final repo = Get.find<SettingRepo>();

  @override
  void onInit() {
    onGetSetting();
    super.onInit();
  }

  void onGetSetting() async {
    final result = await repo.onGetSetting();
    result.fold((l) {}, (r) {
      settingModel.value = r.record;
    });
  }
}
