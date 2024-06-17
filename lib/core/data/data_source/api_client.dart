import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/data_source/api_response.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/data/model/order_head_model.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/data/model/setting_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/exception/failures.dart';
import 'package:store_pos/core/global/setting_controller.dart';
import 'package:store_pos/core/service/db_service.dart';
import 'package:store_pos/core/util/helper.dart';

class ApiClient extends Api {
  Database? _db;

  Future<Database> get db async => _db ??= await DbService.instance.database;

  @override
  Future<ApiResponse> onGetHomeItems({Map? arg}) async {
    try {
      final record = [];
      return ApiResponse(
        record: record,
        status: 'success',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onCreateGroupItem({
    required Map<String, dynamic> arg,
  }) async {
    try {
      final response = await db.then(
        (value) => value.insert(
          GroupItemModel.tableName,
          arg,
          conflictAlgorithm: ConflictAlgorithm.ignore,
        ),
      );
      if (response == -1) {
        throw GeneralException();
      }
      if (response == 0) {
        throw ServerFailure('group_already_exist'.tr);
      }

      return ApiResponse(
        record: Status.success.name,
        status: Status.success.name,
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetGroupItem() async {
    try {
      final scrip =
          await rootBundle.loadString("asset/sql/group_scripts/get_groups.sql");

      final response = await db.then((value) => value.rawQuery(scrip));
      return ApiResponse(
        record: response,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onCreateItem({required Map<String, dynamic> arg}) async {
    try {
      final result = await db.then(
        (value) => value.insert(ItemModel.tableName, arg,
            conflictAlgorithm: ConflictAlgorithm.ignore),
      );
      if (result == -1) {
        return ApiResponse(
          record: Status.failed.name,
          status: Status.failed.name,
        );
      }
      return ApiResponse(
        record: Status.success.name,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetItem() async {
    try {
      // final result = await _db.query(ItemModel.tableName);
      final result = [
        ItemModel(
          code: "00A",
          groupCode: '001',
          description: "Wing small",
          description_2: "ស្លាបតូច",
          unitPrice: 10,
          cost: 8,
          displayLang: "KH",
          imgPath: '',
        ),
        ItemModel(
          code: "00B",
          groupCode: '001',
          description: "Wing Big",
          description_2: "ស្លាបធំ",
          unitPrice: 15,
          cost: 10,
          displayLang: "KH",
          imgPath: '',
        ),
        ItemModel(
          code: "00C",
          groupCode: '001',
          description: "Stand",
          description_2: "ជើង",
          unitPrice: 15,
          cost: 10,
          displayLang: "KH",
          imgPath: '',
        ),
        ItemModel(
          code: "00D",
          groupCode: '002',
          description: "Remote",
          description_2: "ក្បាលបញ្ញា",
          unitPrice: 15,
          cost: 10,
          displayLang: "KH",
          imgPath: '',
        ),
        ItemModel(
          code: "00E",
          groupCode: '002',
          description: "Spray head",
          description_2: "ក្បាលបាញ់",
          unitPrice: 15,
          cost: 10,
          displayLang: "KH",
          imgPath: '',
        ),
        ItemModel(
          code: "00F",
          groupCode: '002',
          description: "Hand wing",
          description_2: "ដៃស្លាប",
          unitPrice: 15,
          cost: 10,
          displayLang: "KH",
          imgPath: '',
        ),
      ];
      return ApiResponse(
        record: result,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> toggleCart({required ItemModel arg}) async {
    try {
      final database = await db;

      final orderHead = await database.query(OrderHead.orderHeadTmp);

      final setting = Get.find<SettingController>().settingModel;

      if (orderHead.isEmpty) {
        final data = {
          'orderId': setting.value!.orderNo,
          'invoiceNo': "R${setting.value!.invoiceNo}",
          'subtotal': 0,
          'discountAmount': 0,
          'discountPercentage': 0,
          'taxAmount': 0,
          'taxPercentage': 0,
          'grandTotal': 0,
          'date': formatDate(DateTime.now()),
        };
        final createHead = await database.insert(OrderHead.orderHeadTmp, data);
        if (createHead == -1) {
          throw GeneralException();
        }
        final orderTran = {
          'orderId': data['orderId'],
          'invoiceNo': data['invoiceNo'],
          'code': arg.code,
          'groupCode': arg.groupCode,
          'description': arg.description,
          'description_2': arg.description_2,
          'unitPrice': arg.unitPrice,
          'qty': 1,
          'displayLang': arg.displayLang,
          'taxAmount': 0,
          'taxPercentage': 0,
          'discountAmount': 0,
          'discountPercentage': 0,
          'extendPrice': 0,
          'subtotal': arg.unitPrice,
          'grandTotal': arg.unitPrice,
          'imagePath': arg.imgPath,
          'date': data['date'],
        };
        final createOrderTran =
            await database.insert(OrderTranModel.orderTranTmp, orderTran);
        if (createOrderTran == -1) {
          throw GeneralException();
        }
      } else {
        final header = OrderHead.fromMap(orderHead[0]);
        final orderTran = {
          'orderId': header.orderId,
          'invoiceNo': header.invoiceNo,
          'code': arg.code,
          'groupCode': arg.groupCode,
          'description': arg.description,
          'description_2': arg.description_2,
          'unitPrice': arg.unitPrice,
          'qty': 1,
          'displayLang': arg.displayLang,
          'taxAmount': 0,
          'taxPercentage': 0,
          'discountAmount': 0,
          'discountPercentage': 0,
          'extendPrice': 0,
          'subtotal': arg.unitPrice,
          'grandTotal': arg.unitPrice,
          'imagePath': arg.imgPath,
          'date': header.date,
        };
        final createOrderTran =
            await database.insert(OrderTranModel.orderTranTmp, orderTran);
        if (createOrderTran == -1) {
          throw GeneralException();
        }
      }

      return ApiResponse(
        record: Status.success.name,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetItemCart() async {
    try {
      final result = await db.then(
        (value) => value.query(OrderTranModel.orderTranTmp),
      );

      return ApiResponse(
        record: result,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetSetting() async {
    try {
      final database = await db;

      final setting = await database.query(SettingModel.tableName);

      Map<String, int> data;

      if (setting.isEmpty) {
        data = {
          'invoiceNo': 1,
          'orderNo': 1,
        };
        final result = await database.insert(SettingModel.tableName, data);
        if (result == -1) {
          throw GeneralException();
        } else {
          return ApiResponse(
            record: data,
            status: Status.success.name,
          );
        }
      }
      return ApiResponse(
        record: setting[0],
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }
}
