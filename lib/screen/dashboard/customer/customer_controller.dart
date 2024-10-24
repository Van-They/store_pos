import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/model/customer_model.dart';
import 'package:store_pos/core/repository/merchant_menu_repo.dart';
import 'package:store_pos/core/service/image_storage_service.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/components/custom_dialog.dart';
import 'package:store_pos/widget/components/pick_image.dart';

class CustomerController extends GetxController {
  RxList<CustomerModel> dataSet = <CustomerModel>[].obs;

  RxBool isLoading = false.obs;

  final repo = Get.find<MerchantMenuRepo>();

  TextEditingController codeCtr = TextEditingController();
  TextEditingController firstNameCtr = TextEditingController();
  TextEditingController lastNameCtr = TextEditingController();
  TextEditingController phoneNumberCtr = TextEditingController();
  TextEditingController dayCtr = TextEditingController();
  TextEditingController monthCtr = TextEditingController();
  TextEditingController yearCtr = TextEditingController();
  RxString imagePath = ''.obs;
  RxString dob = ''.obs;
  final formState = GlobalKey<FormState>();
  String oldImagePath = '';

  @override
  void onInit() {
    getListCustomer();
    super.onInit();
  }

  Future<void> getListCustomer() async {
    try {
      isLoading.value = true;
      final result = await repo.getListCustomer();
      result.foldRight(
        null,
        (r, previous) {
          dataSet.value = r.record;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onDeleteCurrentRecord({required int index}) async {
    showYesNoDialog(
      content: "do_want_to_delete_this_record".tr,
      onConfirm: () async {
        Get.back();
        final result = await repo
            .onDeleteCurrentRecord(arg: {"code": dataSet[index].code});
        result.foldRight(
          null,
          (r, previous) {
            dataSet.removeWhere(
              (element) => element.code == dataSet[index].code,
            );
          },
        );
      },
    );
  }

  Future<void> createCustomer() async {
    if (!formState.currentState!.validate()) {
      return;
    }

    File imageFile = File(imagePath.value);
    String tmpImgPath = imagePath.value;
    if (imagePath.isNotEmpty) {
      tmpImgPath = await ImageStorageService.initImgPathTmp(imageFile);
    }

    final newRecord = <String, dynamic>{
      'code': codeCtr.text.trim(),
      'firstName': firstNameCtr.text.trim(),
      'lastName': lastNameCtr.text.trim(),
      'phoneNumber': phoneNumberCtr.text.trim(),
      'imagePath': tmpImgPath,
      'dob':
          '${yearCtr.text.trim()}-${monthCtr.text.trim()}-${dayCtr.text.trim()}',
    };

    final result = await repo.createCustomer(arg: newRecord);

    result.foldRight(
      null,
      (r, previous) {
        if (r.record) {
          _onCopyImageToSecureDir(imageFile, tmpImgPath);
          dataSet.add(CustomerModel.fromMap(newRecord));
        }
      },
    );
  }

  Future<void> onGetCustomerByCode() async {
    final arg = Get.arguments ?? {};
    final result = await repo.onGetCustomerByCode(arg: {"code": arg['code']});
    result.foldRight(
      null,
      (r, previous) {
        _onSetDataHolder(customer: r.record);
        oldImagePath = r.record.imagePath;
      },
    );
  }

  Future<void> updateCustomer() async {
    if (!formState.currentState!.validate()) {
      return;
    }
    File imageFile = File(imagePath.value);
    String tmpImgPath = imagePath.value;

    //update image
    if (oldImagePath != tmpImgPath) {
      oldImagePath = tmpImgPath;
    }

    //if customer do not has photo
    // if (tmpImgPath.isEmpty) {
    //   tmpImgPath = await ImageStorageService.initImgPathTmp(imageFile);
    // }

    final record = <String, dynamic>{
      'code': codeCtr.text.trim(),
      'firstName': firstNameCtr.text.trim(),
      'lastName': lastNameCtr.text.trim(),
      'phoneNumber': phoneNumberCtr.text.trim(),
      'imagePath': tmpImgPath,
      'dob':
          '${yearCtr.text.trim()}-${monthCtr.text.trim()}-${dayCtr.text.trim()}',
    };
    final result = await repo.updateCustomer(arg: record);

    result.foldRight(
      null,
      (r, previous) {
        int index = dataSet.indexWhere((p0) => p0.code == codeCtr.text.trim());
        dataSet[index] = r.record;
        _onCopyImageToSecureDir(imageFile, tmpImgPath);
        _onClearController();
      },
    );
  }

  void _onSetDataHolder({required CustomerModel customer}) {
    codeCtr.text = customer.code;
    firstNameCtr.text = customer.firstName;
    lastNameCtr.text = customer.lastName;
    phoneNumberCtr.text = customer.phoneNumber;
    if (customer.dob.isNotEmpty) {
      final dateStr = customer.dob.split("-");
      dayCtr.text = dateStr.last;
      monthCtr.text = dateStr[1];
      yearCtr.text = dateStr.first;
    }
    imagePath.value = customer.imagePath;
  }

  Future<void> onPickImage() async {
    final img = await customPickImageGallery();
    if (img == null) {
      return;
    }
    imagePath.value = img.path;
  }

  void _onCopyImageToSecureDir(File imageFile, String tmpImgPath) async {
    await ImageStorageService.saveImageToSecureDir(imageFile, path: tmpImgPath)
        .whenComplete(
      () {
        _onClearController();
        Get.back();
      },
    );
  }

  void _onClearController() {
    codeCtr.clear();
    firstNameCtr.clear();
    lastNameCtr.clear();
    phoneNumberCtr.clear();
    dayCtr.clear();
    monthCtr.clear();
    yearCtr.clear();
    imagePath.value = '';
    dob.value = '';
  }
}
