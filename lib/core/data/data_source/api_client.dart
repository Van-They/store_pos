import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/data_source/api_response.dart';
import 'package:store_pos/core/data/model/customer_model.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/data/model/order_head_model.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/data/model/payment_method_model.dart';
import 'package:store_pos/core/data/model/posh_cash.dart';
import 'package:store_pos/core/data/model/setting_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/exception/failures.dart';
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/service/db_service.dart';
import 'package:store_pos/core/util/helper.dart';

class ApiClient extends Api {
  late Database db;

  Future<void> getDatabase() async => db = await DbService.instance.database;

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
      final response = await db.insert(
        GroupItemModel.tableName,
        arg,
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
      if (response == -1) {
        throw SqlException();
      }

      return ApiResponse(
        record: arg,
        status: Status.success.name,
      );
    } catch (e) {
      ServerFailure('group_already_exist'.tr);
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetGroupItem() async {
    try {
      final response = await db.query(GroupItemModel.tableName);
      return ApiResponse(
        record: response,
        status: Status.success.name,
      );
    } on Exception {
      ServerFailure('something_went_wrong'.tr);
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetGroupItemHome() async {
    try {
      final response = await db.query(GroupItemModel.tableName,
          where: 'active=?', whereArgs: ['1'], limit: 10);
      return ApiResponse(
        record: response,
        status: Status.success.name,
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onCreateItem({required Map<String, dynamic> arg}) async {
    try {
      final result = await db.insert(
        ItemModel.tableName,
        arg,
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
      if (result == -1) {
        throw GeneralException();
      }
      return ApiResponse(
        record: Status.success.name,
        status: Status.success.name,
      );
    } catch (e) {
      showMessage(msg: 'item_already_exist'.tr, status: Status.failed);
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetItem() async {
    try {
      final result = await db.query(ItemModel.tableName);
      return ApiResponse(
        record: result,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetItemCart() async {
    try {
      final result = await db.query(OrderTranModel.orderTranTmp);

      return ApiResponse(
        record: result,
        status: Status.success.name,
      );
    } catch (e) {
      logger.i(e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetOrderHead() async {
    try {
      final settingList = await db.query(SettingModel.tableName);

      if (settingList.isEmpty) {
        throw GeneralException();
      }

      final setting = SettingModel.fromMap(settingList[0]);

      final orderHead = await db.query(OrderHead.orderHeadTmp);

      Map<String, Object?> response;

      //if order head not exist
      if (orderHead.isEmpty) {
        //if order head does not exist create new orderhead
        final data = {
          'orderId': "${setting.orderNo}",
          'invoiceNo':
              "${setting.invoiceText}${invoiceFormater(setting.invoiceNo)}",
          'subtotal': 0.0,
          'discountAmount': 0.0,
          'discountPercentage': 0.0,
          'taxAmount': 0.0,
          'taxPercentage': 0.0,
          'grandTotal': 0.0,
          'date': formatDate(DateTime.now()),
        };

        final createHead = await db.insert(OrderHead.orderHeadTmp, data);
        //if create new orderHead not success throw exception
        if (createHead == -1) {
          throw GeneralException();
        }
        response = data;

        //update setting when orderHead create success
        setting.orderNo++;
        setting.invoiceNo++;
        await db.update(SettingModel.tableName, setting.toMap());
      } else {
        response = orderHead[0];
      }

      return ApiResponse(
        record: response,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> toggleCart({required ItemModel arg}) async {
    try {
      //orderHead only exist 1 during process
      final orderHead = Get.find<CartController>().orderHead;

      //check if item already exist in cart
      final isItemExist = await db.delete(OrderTranModel.orderTranTmp,
          where: "code=?", whereArgs: [arg.code]);

      final orderTran = {
        'orderId': orderHead.value!.orderId,
        'invoiceNo': orderHead.value!.invoiceNo,
        'code': arg.code,
        'groupCode': arg.groupCode,
        'description': arg.description,
        'description_2': arg.description_2,
        'unitPrice': arg.unitPrice,
        'qty': 1,
        'displayLang': arg.displayLang,
        'taxAmount': 0.0,
        'taxPercentage': 0.0,
        'discountAmount': 0.0,
        'discountPercentage': 0.0,
        'extendPrice': 0.0,
        'subtotal': arg.unitPrice,
        'grandTotal': arg.unitPrice,
        'imagePath': arg.imgPath,
        'date': orderHead.value!.date,
      };

      if (isItemExist < 1) {
        final createOrderTran =
            await db.insert(OrderTranModel.orderTranTmp, orderTran);
        if (createOrderTran == -1) {
          throw GeneralException();
        }
      }

      final records = await db.query(OrderTranModel.orderTranTmp);

      List<OrderTranModel> orderTranList = [];

      for (var e in records) {
        orderTranList.add(OrderTranModel.fromMap(e));
      }

      final subtotal = OrderTranModel.calculateSubtotal(orderTranList);
      orderHead.value!.subtotal = subtotal;
      orderHead.value!.grandTotal =
          OrderHead.calculateGrandtotal(orderHead.value!);
      await db.update(OrderHead.orderHeadTmp, orderHead.value!.toMap());

      debugPrint(orderHead.value!.toString());

      return ApiResponse(
        record: orderTran,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onUpdateCart(
      {required String code, required double qty}) async {
    try {
      //orderHead only exist 1 during process
      final orderHead = Get.find<CartController>().orderHead;

      final currentItemList = await db.query(OrderTranModel.orderTranTmp,
          where: 'code=?', whereArgs: [code]);

      if (currentItemList.isEmpty) throw GeneralException();

      final currrentItemMap = currentItemList[0];

      final currentItem = OrderTranModel.fromMap(currrentItemMap);

      currentItem.qty = qty;
      currentItem.subtotal =
          OrderTranModel.calculateSubtotalByItem(currentItem);
      currentItem.grandTotal =
          OrderTranModel.calculateSubtotalByItem(currentItem);

      await db.update(
        OrderTranModel.orderTranTmp,
        currentItem.toMap(),
        where: "code=?",
        whereArgs: [code],
      );

      final records = await db.query(OrderTranModel.orderTranTmp);

      List<OrderTranModel> orderTranList = [];

      for (var e in records) {
        orderTranList.add(OrderTranModel.fromMap(e));
      }

      final subtotal = OrderTranModel.calculateSubtotal(orderTranList);
      orderHead.value!.subtotal = subtotal;
      orderHead.value!.grandTotal =
          OrderHead.calculateGrandtotal(orderHead.value!);
      await db.update(OrderHead.orderHeadTmp, orderHead.value!.toMap());

      debugPrint(orderHead.value!.toString());

      final indexCurrentItem =
          orderTranList.indexWhere((element) => element.code == code);

      final orderTran = orderTranList[indexCurrentItem];

      return ApiResponse(
        record: orderTran.toMap(),
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetCustomer() async {
    try {
      final records = await db.query(CustomerModel.tableName);
      return ApiResponse(
        record: records,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetPaymentMethod() async {
    try {
      final records = await db.query(PaymentMethodModel.tableName);
      return ApiResponse(
        record: records,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onCheckOutCart() async {
    try {
      final orderHead = Get.find<CartController>().orderHead.value;

      if (orderHead == null) {
        throw GeneralException();
      }

      final poshCash = {
        'orderId': orderHead.orderId,
        'invoiceNo': orderHead.invoiceNo,
        'paymentCode': "CASH",
        'paymentDesc': "CASH",
        'amount': orderHead.grandTotal,
        'date': orderHead.date,
      };

      await db.insert(PoshCash.tableName, poshCash);

      // await db.execute("INSERT INTO order_head SELECT * FROM order_head_tmp");
      // await db.execute("INSERT INTO order_tran SELECT * FROM order_tran_tmp");
      // await db.execute("DELETE FROM order_head_tmp");
      // await db.execute("DELETE FROM order_tran_tmp");

      final fileScript =
          await rootBundle.loadString("asset/sql/check_out_scripts.sql");

      final listCheckOutScripts = fileScript.split(";");

      for (var e in listCheckOutScripts) {
        if (e.isNotEmpty) {
          await db.execute(e.trim());
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
  Future<ApiResponse> onDeleteGroup({Map? arg}) async {
    try {
      final response = await db.query(ItemModel.tableName,
          where: 'groupCode=?', whereArgs: [arg?['code']]);
      if (response.isNotEmpty) {
        return ApiResponse(
          record: Status.failed.name,
          msg: 'can_not_delete_group_is_not_empty',
          status: Status.failed.name,
        );
      }
      final result = await db.delete(
        GroupItemModel.tableName,
        where: 'code=?',
        whereArgs: [arg?['code']],
      );
      if (result != -1) {
        return ApiResponse(
          record: Status.success.name,
          status: Status.success.name,
        );
      }
      return ApiResponse(
        record: Status.failed.name,
        msg: 'can_not_delete_group_is_not_empty',
        status: Status.failed.name,
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onToggleDisableGroup(
      {required Map<String, Object?> arg}) async {
    try {
      final response = await db.update(GroupItemModel.tableName, arg,
          where: 'code=?', whereArgs: [arg['code']]);
      if (response == -1) {
        throw SqlException();
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
  Future<ApiResponse> onUpdateGroup({required Map<String, Object?> arg}) async {
    try {
      final response = await db.update(GroupItemModel.tableName, arg,
          where: 'code=?', whereArgs: [arg['code']]);
      if (response == -1) {
        throw SqlException();
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
  Future<ApiResponse> onDeleteItem(String code) async {
    try {
      final orderTranTmp = await db.query(OrderTranModel.orderTranTmp,
          where: 'code=?', whereArgs: [code]);
      if (orderTranTmp.isNotEmpty) {
        throw SqlException();
      }

      final orderTran = await db
          .query(OrderTranModel.orderTran, where: 'code=?', whereArgs: [code]);
      if (orderTran.isNotEmpty) {
        return ApiResponse(
          record: Status.success.name,
          status: Status.failed.name,
        );
      }

      await db.delete(ItemModel.tableName, where: 'code=?', whereArgs: [code]);
      return ApiResponse(
        record: Status.success.name,
        status: Status.success.name,
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> toggleWishlist(String code) async {
    try {
      // final script = await rootBundle.loadString('/asset/sql/wish_list.sql');

      final result = await db.insert('wishlist', {"code": code},
          conflictAlgorithm: ConflictAlgorithm.rollback);

      if (result == -1) {
        throw GeneralException();
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
  Future<ApiResponse> onUpdateItem({required Map<String, dynamic> arg}) async {
    try {
      final response = await db.update(ItemModel.tableName, arg,
          where: 'code=?', whereArgs: [arg['code']]);
      if (response == -1) {
        throw SqlException();
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
  Future<ApiResponse> onDeleteHomeSlider({Map? arg}) async {
    //  try {
    //   final response = await db.update(ItemModel.tableName, arg,
    //       where: 'code=?', whereArgs: [arg?['code']]);
    //   if (response == -1) {
    //     throw SqlException();
    //   }
    //   return ApiResponse(
    //     record: Status.success.name,
    //     status: Status.success.name,
    //   );
    // } on Exception {
    //   rethrow;
    // }
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> onGetHomeSldier() async {
    // try {
    //   final response = await db.update(ItemModel.tableName, arg,
    //       where: 'code=?', whereArgs: [arg['code']]);
    //   if (response == -1) {
    //     throw SqlException();
    //   }
    //   return ApiResponse(
    //     record: Status.success.name,
    //     status: Status.success.name,
    //   );
    // } on Exception {
    //   rethrow;
    // }
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> onInsertHomeSlder({Map? arg}) async {
    // try {
    //   final response = await db.update(ItemModel.tableName, arg,
    //       where: 'code=?', whereArgs: [arg['code']]);
    //   if (response == -1) {
    //     throw SqlException();
    //   }
    //   return ApiResponse(
    //     record: Status.success.name,
    //     status: Status.success.name,
    //   );
    // } on Exception {
    //   rethrow;
    // }
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> onGetItemByCategory({Map? arg}) async {
    try {
      final response = await db.query(
        ItemModel.tableName,
        where: "groupCode=?",
        whereArgs: [
          arg?['code'],
        ],
      );
      return ApiResponse(
        record: response,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetWishList({Map? arg}) async {
    try {
      //wishlist
      const query =
          "SELECT * FROM ${ItemModel.tableName} t JOIN ON wishlist w WHERE t.code==w.code";
      final response = await db.rawQuery(query);
      return ApiResponse(
        record: response,
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onToggleWishList({Map? arg}) async {
    try {
      const table = "wishlist";
      final isExit = await db.query(
        table,
        where: "code=?",
        whereArgs: [arg?['code']],
      );
      if (isExit.isNotEmpty) {
        await db.delete(
          table,
          where: 'code=?',
          whereArgs: [arg?['code']],
        );
        return ApiResponse(
          record: "Delete",
          status: Status.success.name,
        );
      }
      await db.insert(
        table,
        {"code": arg?['code']},
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
      return ApiResponse(
        record: "Insert",
        status: Status.success.name,
      );
    } catch (e) {
      rethrow;
    }
  }
}
