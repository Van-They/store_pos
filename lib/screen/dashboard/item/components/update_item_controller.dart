import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class UpdateItemController extends GetxController {
  Rx<ItemModel> itemModel = ItemModel.fromMap({}).obs;
  RxBool isLoading = false.obs;
  final itemRepo = Get.find<ItemRepo>();

  //updateItem item
  Rx<Language> language = Language.en.obs;
  RxString imageListener = ''.obs;
  Rx<ItemModel> itemUpdate = ItemModel.fromMap({}).obs;
  late TextEditingController groupCodeCtr;
  late TextEditingController itemCodeCtr;
  late TextEditingController itemCostCtr;
  late TextEditingController unitPriceCtr;
  late TextEditingController descEnCtr;
  late TextEditingController descKHCtr;
  final formState = GlobalKey<FormState>();

  @override
  void onInit() {
    final arg = Get.arguments;
    itemUpdate.value = arg['item'] as ItemModel;
    onOpenTransaction();
    super.onInit();
  }

  @override
  void onClose() {
    onCloseTransaction();
    super.onClose();
  }

  void onOpenTransaction() {
    groupCodeCtr = TextEditingController(text: itemUpdate.value.groupCode);
    itemCodeCtr = TextEditingController(text: itemUpdate.value.code);
    itemCostCtr = TextEditingController(text: '${itemUpdate.value.cost}');
    unitPriceCtr = TextEditingController(text: '${itemUpdate.value.unitPrice}');
    descEnCtr = TextEditingController(text: itemUpdate.value.description);
    descKHCtr = TextEditingController(text: itemUpdate.value.description_2);
    imageListener.value = itemUpdate.value.imgPath;
    language.value =
        itemUpdate.value.displayLang == "KH" ? Language.kh : Language.en;
  }

  void onCloseTransaction() {
    groupCodeCtr.dispose();
    itemCodeCtr.dispose();
    itemCostCtr.dispose();
    unitPriceCtr.dispose();
    descEnCtr.dispose();
    descKHCtr.dispose();
  }

  Future<void> onGetItemById({required String itemCode}) async {
    try {
      isLoading.value = true;
      final result = await itemRepo.onGetItemById(itemCode: itemCode);
      result.fold((l) => throw Exception(), (r) {
        itemModel.value = r.record;
        isLoading.value = false;
      });
    } on Exception {
      isLoading.value = false;
    }
  }

  Future<bool> onUpdateItem({required Map<String, dynamic> arg}) async {
    try {
      final result = await itemRepo.onUpdateItem(arg: arg);
      result.fold((l) {
        throw Exception();
      }, (r) {});
      return true;
    } on Exception {
      return false;
    }
  }
}
