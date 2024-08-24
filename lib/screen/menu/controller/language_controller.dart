import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_pos/core/constant/constant.dart';

class LanguageController extends GetxController {
  RxString language = "".obs;

  @override
  void onInit() {
    _onGetLanguagePreference();
    super.onInit();
  }

  Future<void> _onGetLanguagePreference() async {
    final sharedPref = await SharedPreferences.getInstance();
    final savedLang = sharedPref.getString("language");
    language.value = savedLang ?? Language.en.name;
  }

  Future<void> saveChange(String code) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("language", code);
  }
}
