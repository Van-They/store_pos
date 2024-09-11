import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class ItemController extends GetxController {
  RxList<ItemModel> itemList = <ItemModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isScrolled = false.obs;
  RxBool isSearching = false.obs;
  RxBool isAddingNew = false.obs;
  RxBool isUpdating = false.obs;

  RxBool searchListener = false.obs;

  late ScrollController scrollController;
  late TextEditingController searchController;

  final itemRepo = Get.find<ItemRepo>();

  //status
  bool isCreateItem = false;
  bool isUpdate = false;

  //create item
  Rx<Language> language = Language.en.obs;
  RxString imageListener = ''.obs;
  Rx<ItemModel?> itemModel = null.obs;
  late TextEditingController groupCodeCtr;
  late TextEditingController itemCodeCtr;

  late TextEditingController itemCostCtr;

  late TextEditingController unitPriceCtr;
  late TextEditingController groupDescEnCtr;
  late TextEditingController groupDescKHCtr;
  late TextEditingController qtyCtr;
  final formState = GlobalKey<FormState>();

  @override
  void onInit() {
    if (!isUpdate || !isCreateItem) {
      onGetItem();
      searchController = TextEditingController();
      scrollController = ScrollController();
      scrollController.addListener(() {
        searchListener.value = false;
      });
    }

    super.onInit();
  }

  void onOpenTransaction() {
    groupCodeCtr = TextEditingController();
    itemCodeCtr = TextEditingController();
    itemCostCtr = TextEditingController();
    qtyCtr = TextEditingController(text: "0");
    unitPriceCtr = TextEditingController();
    groupDescEnCtr = TextEditingController();
    groupDescKHCtr = TextEditingController();
  }

  void onCloseTransaction() {
    groupCodeCtr.clear();
    itemCodeCtr.clear();
    itemCostCtr.clear();
    unitPriceCtr.clear();
    groupDescEnCtr.clear();
    groupDescKHCtr.clear();
    qtyCtr.clear();
  }

  Future<void> onSearchItem(String query) async {
    final result = await itemRepo.onSearchItem(query: query);
    result.foldRight(null, (r, previous) {
      itemList.value = r.record;
    });
  }

  Future<void> onGetWishList({Map? arg}) async {
    final result = await itemRepo.onGetWishList(arg: arg);
    result.foldRight(null, (r, previous) {
      itemList.value = r.record;
    });
  }

  Future<void> onGetItem() async {
    final result = await itemRepo.onGetItem();
    result.foldRight(null, (r, previous) {
      itemList.value = r.record;
    });
  }

  Future<bool> onCreateItem({required Map<String, dynamic> arg}) async {
    try {
      final result = await itemRepo.onCreateItem(arg: arg);
      result.fold((l) => throw Exception(), (r) {
        final newItem = ItemModel.fromMap(arg);
        itemList.add(newItem);
        itemList.refresh();
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<void> onDeleteItem(String code) async {
    final result = await itemRepo.onDeleteItem(code);
    result.foldRight(null, (r, previous) {
      itemList.removeWhere((element) => element.code == code);
    });
  }

  Future<bool> onUpdateItem({required Map<String, dynamic> arg}) async {
    try {
      final result = await itemRepo.onUpdateItem(arg: arg);
      result.fold((l) {
        throw Exception();
      }, (r) {
        final newGroup = ItemModel.fromMap(arg);
        final data = itemList.obs.value;
        final index = data.indexWhere((element) => element.code == arg['code']);
        if (index != -1) {
          data[index] = newGroup;
          itemList.refresh();
        }
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<void> onGetItemByCategory({Map? arg}) async {
    try {
      isLoading.value = true;
      final result = await itemRepo.onGetItemByCategory(arg: arg);
      result.fold((l) => throw Exception(), (r) {
        itemList.value = r.record;
      });
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
