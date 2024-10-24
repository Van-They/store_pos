import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/model/payment_method_model.dart';
import 'package:store_pos/core/repository/merchant_menu_repo.dart';

class PaymentMethodController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<PaymentMethodModel> paymentList = <PaymentMethodModel>[].obs;

  final repo = Get.find<MerchantMenuRepo>();

  late ScrollController scrollController;

  final formState = GlobalKey<FormState>();

  Rx<Language> language = Language.en.obs;
  PaymentMethodModel paymentUpdate = PaymentMethodModel.fromMap({});
  RxString imageListener = ''.obs;
  late TextEditingController descEnCtr;
  late TextEditingController codeCtr;
  late TextEditingController descKhCtr;

  @override
  void onInit() {
    _onGetAllPaymentMethod();
    scrollController = ScrollController();
    descKhCtr = TextEditingController();
    descEnCtr = TextEditingController();
    codeCtr = TextEditingController();
    super.onInit();
  }

  void onUpdateTransaction() {
    descKhCtr.text = paymentUpdate.description_2;
    descEnCtr.text = paymentUpdate.description;
    codeCtr.text = paymentUpdate.code;
    imageListener.value = paymentUpdate.imagePath;
  }

  void onCloseTransaction() {
    descKhCtr.clear();
    descEnCtr.clear();
    codeCtr.clear();
    imageListener.value = '';
  }

  void _onGetAllPaymentMethod() async {
    final result = await repo.onGetAllPaymentMethod();
    result.foldRight(
      null,
      (r, previous) {
        paymentList.value = r.record;
      },
    );
  }

  FutureOr<bool> onCreatePaymentMethod(
      {required Map<String, dynamic> arg}) async {
    final result = await repo.onCreatePaymentMethod(arg: arg);
    try {
      result.fold(
        (l) => throw Exception(),
        (r) {
          paymentList.add(PaymentMethodModel.fromMap(arg));
          paymentList.refresh();
        },
      );
      onCloseTransaction();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> onUpdatePaymentMethod(
      {required Map<String, dynamic> arg}) async {
    final result = await repo.onUpdatePaymentMethod(arg: arg);
    try {
      result.fold(
        (l) => throw Exception(),
        (r) {
          int index = paymentList.indexWhere(
            (element) => element.code.contains(arg['code']),
          );
          paymentList[index] = PaymentMethodModel.fromMap(arg);
          paymentList.refresh();
        },
      );
      onCloseTransaction();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> onDeletePaymentMethod(
      {required Map<String, dynamic> arg}) async {
    final result = await repo.onDeletePaymentMethod(arg: arg);
    result.foldRight(
      null,
      (r, previous) {
        paymentList.removeWhere(
          (element) => element.code.contains(arg['code']),
        );
        paymentList.refresh();
      },
    );
  }
}
