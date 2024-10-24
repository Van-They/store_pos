import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/repository/group_item_repo.dart';

class GroupController extends GetxController {
  RxList<GroupItemModel> groupItemList = <GroupItemModel>[].obs;
  RxBool isLoading = false.obs;

  final groupRepo = Get.find<GroupItemRepo>();

  RxBool searchListener = false.obs;

  late ScrollController scrollController;

  final keyForm = GlobalKey<FormState>();
  late TextEditingController groupCodeCtr;
  late TextEditingController groupDescEn;
  late TextEditingController groupDescKH;

  //create item
  Rx<Language> displayLanguage = Language.en.obs;
  RxString imgListener = ''.obs;

  //update
  String oldGroupImagePath = "";
  GroupItemModel? _groupUpdateModel;

  @override
  void onInit() {
    onGetGroupItem();
    scrollController = ScrollController()
      ..addListener(
        () {
          searchListener.value = false;
        },
      );
    super.onInit();
  }

  void onOpenTransaction() {
    groupCodeCtr = TextEditingController();
    groupDescEn = TextEditingController();
    groupDescKH = TextEditingController();
  }

  void onCloseTransaction() {
    groupCodeCtr.dispose();
    groupDescEn.dispose();
    groupDescKH.dispose();
  }

  void onGetGroupToUpdate({required String groupCode}) async {
    final result = await groupRepo.onGetGroupByCode(code: groupCode);
    try {
      result.fold(
        (l) => throw Exception(),
        (r) {
          _groupUpdateModel = r.record;
          _onSetDisplayData();
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  void _onSetDisplayData() {
    GroupItemModel? group = _groupUpdateModel;
    if (group != null) {
      groupCodeCtr.text = group.code;
      groupDescEn.text = group.description;
      groupDescKH.text = group.description_2;
      displayLanguage.value =
          group.displayLang == "KH" ? Language.kh : Language.en;
      oldGroupImagePath = group.imgPath;
      imgListener.value = group.imgPath;
    }
  }

  Future<void> onGetGroupItem() async {
    isLoading.value = true;
    final result = await groupRepo.onGetGroupItem();
    try {
      result.foldRight(
        null,
        (r, previous) {
          groupItemList.value = r.record;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> onCreateGroupItem({required Map<String, dynamic> arg}) async {
    try {
      final result = await groupRepo.onCreateGroupItem(arg: arg);
      result.fold(
        (l) => throw Exception(),
        (r) {
          final newGroup = GroupItemModel.fromMap(arg);
          groupItemList.add(newGroup);
          groupItemList.refresh();
        },
      );
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> onDeleteGroup({required Map arg}) async {
    try {
      final result = await groupRepo.onDeleteGroup(arg: arg);
      result.fold(
        (l) => throw Exception(),
        (r) {
          final index = groupItemList
              .indexWhere((element) => element.code == arg['code']);
          if (index != -1) {
            groupItemList.removeAt(index);
          }
          groupItemList.refresh();
        },
      );
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> onUpdateGroup({required Map<String, Object?> arg}) async {
    try {
      final result = await groupRepo.onUpdateGroup(arg: arg);
      result.fold((l) => throw Exception(), (r) {
        final newGroup = GroupItemModel.fromMap(arg);
        final index =
            groupItemList.indexWhere((element) => element.code == arg['code']);
        if (index != -1) {
          groupItemList[index] = newGroup;
        }
        groupItemList.refresh();
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> onToggleDisableGroup({required Map<String, dynamic> arg}) async {
    try {
      final result = await groupRepo.onToggleDisableGroup(arg: arg);
      result.fold((l) => throw Exception(), (r) {
        final newGroup = GroupItemModel.fromMap(arg);

        final index =
            groupItemList.indexWhere((element) => element.code == arg['code']);
        if (index != -1) {
          groupItemList[index] = newGroup;
        }
        groupItemList.refresh();
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
