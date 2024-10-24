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
import 'package:store_pos/core/global/cart_controller.dart';
import 'package:store_pos/core/util/helper.dart';

class ApiClient extends Api {
  final Database _db;

  ApiClient(this._db);

  String? _error;

  Database get db => _db;

  @override
  Future<ApiResponse> onGetHomeItems({Map? arg}) async {
    try {
      final record = [];
      return ApiResponse(
        record: record,
        status: Status.success,
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
        throw GeneralException();
      }

      return ApiResponse(
        record: arg,
        status: Status.success,
      );
    } catch (e) {
      _error = 'group_already_exist'.tr;
      return ApiResponse(
        record: '',
        msg: _error,
        status: Status.failed,
      );
    }
  }

  @override
  Future<ApiResponse> onGetGroupItem() async {
    try {
      final response = await db.query(GroupItemModel.tableName);
      return ApiResponse(
        record: response,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: '',
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onGetGroupItemHome() async {
    try {
      final response = await db.query(GroupItemModel.tableName,
          where: 'active=?', whereArgs: ['1'], limit: 10);
      return ApiResponse(
        record: response,
        status: Status.success,
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
        record: Status.success,
        status: Status.success,
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
        status: Status.success,
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
        status: Status.success,
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
        _error = "Setting not initialize";
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
          _error = "Header not initialize";
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
        status: Status.success,
      );
    } catch (e) {
      return ApiResponse(
        record: {},
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> toggleCart({required ItemModel arg}) async {
    try {
      //orderHead only exist 1 during process
      final orderHeadObx = Get.find<CartController>().orderHead;
      final orderHead = orderHeadObx.value;
      if (orderHead == null) {
        throw Exception("Can't add item to cart");
      }

      //check if item already exist in cart
      final isItemExist = await db.delete(OrderTranModel.orderTranTmp,
          where: "code=?", whereArgs: [arg.code]);

      final orderTran = {
        'orderId': orderHead.orderId,
        'invoiceNo': orderHead.invoiceNo,
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
        'date': formatDate(DateTime.now()),
      };

      if (isItemExist < 1) {
        final createOrderTran = await db.insert(
          OrderTranModel.orderTranTmp,
          orderTran,
        );
        if (createOrderTran == -1) {
          throw Exception("Can't add item to cart");
        }
      }

      final records = await db.query(OrderTranModel.orderTranTmp);

      List<OrderTranModel> orderTranList = [];

      for (var e in records) {
        orderTranList.add(OrderTranModel.fromMap(e));
      }

      final subtotal = OrderTranModel.calculateSubtotal(orderTranList);
      orderHead.subtotal = subtotal;
      orderHead.grandTotal = OrderHead.calculateGrandtotal(orderHead);

      orderHead.date = formatDate(DateTime.now());

      await db.update(OrderHead.orderHeadTmp, orderHead.toMap());

      logger.d(orderHead);

      return ApiResponse(
        record: orderTran,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: {},
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onUpdateCart({
    required String code,
    required double qty,
  }) async {
    try {
      //orderHead only exist 1 during process
      final orderHeadObx = Get.find<CartController>().orderHead;

      final orderHead = orderHeadObx.value;

      if (orderHead == null) {
        _error = "Can't update item";
        throw GeneralException();
      }

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

      orderHead.subtotal = subtotal;

      orderHead.grandTotal = OrderHead.calculateGrandtotal(orderHead);

      await db.update(OrderHead.orderHeadTmp, orderHead.toMap());

      logger.d(orderHead.toString());

      final indexCurrentItem =
          orderTranList.indexWhere((element) => element.code == code);

      final orderTran = orderTranList[indexCurrentItem];

      return ApiResponse(
        record: orderTran.toMap(),
        status: Status.success,
      );
    } catch (e) {
      return ApiResponse(
        record: {},
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onGetCustomer() async {
    try {
      final records = await db.query(CustomerModel.tableName);
      return ApiResponse(
        record: records,
        status: Status.success,
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
        status: Status.success,
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
        record: Status.success,
        status: Status.success,
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
          record: Status.failed,
          msg: 'can_not_delete_group_is_not_empty',
          status: Status.failed,
        );
      }
      final result = await db.delete(
        GroupItemModel.tableName,
        where: 'code=?',
        whereArgs: [arg?['code']],
      );
      if (result != -1) {
        return ApiResponse(
          record: Status.success,
          status: Status.success,
        );
      }
      return ApiResponse(
        record: Status.failed,
        msg: 'can_not_delete_group_is_not_empty',
        status: Status.failed,
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
        record: Status.success,
        status: Status.success,
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
        record: Status.success,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: Status.failed,
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onDeleteItem(String code) async {
    try {
      final orderTranTmp = await db.query(
        OrderTranModel.orderTranTmp,
        where: 'code=?',
        whereArgs: [code],
      );

      if (orderTranTmp.isNotEmpty) {
        _error = "can_not_delete_item_transaction".tr;
        throw GeneralException();
      }

      final orderTran = await db.query(
        OrderTranModel.orderTran,
        where: 'code=?',
        whereArgs: [code],
      );

      if (orderTran.isNotEmpty) {
        _error = "can_not_delete_item_transaction".tr;
        throw GeneralException();
      }

      await db.delete(ItemModel.tableName, where: 'code=?', whereArgs: [code]);

      return ApiResponse(
        record: Status.success,
        status: Status.success,
      );
    } on Exception {
      return ApiResponse(
        record: Status.failed,
        status: Status.failed,
        msg: _error,
      );
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
        record: Status.success,
        status: Status.success,
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
        record: Status.success,
        status: Status.success,
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
    //     record: Status.success,
    //     status: Status.success,
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
    //     record: Status.success,
    //     status: Status.success,
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
    //     record: Status.success,
    //     status: Status.success,
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
        status: Status.success,
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
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: [],
        status: Status.failed,
      );
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
          status: Status.success,
        );
      }
      await db.insert(
        table,
        {"code": arg?['code']},
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
      return ApiResponse(
        record: "Insert",
        status: Status.success,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onCreateImportItem(
      {required Map<String, dynamic> arg}) async {
    try {
      final response = await db.insert(ItemModel.tableName, arg,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      if (response == -1) {
        throw GeneralException();
      }
      return ApiResponse(
        record: Status.success,
        status: Status.success,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onCreateBatchItems(
      {required List<Map<String, dynamic>> itemList}) async {
    try {
      final batch = db.batch();
      for (var i in itemList) {
        batch.insert(ItemModel.tableName, i,
            conflictAlgorithm: ConflictAlgorithm.ignore);
      }
      await batch.commit(noResult: false, continueOnError: true);
      //will return error item in response
      return ApiResponse(
        record: Status.success,
        status: Status.success,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onSaveImageSlider(String path) async {
    try {
      final response = await db.insert('home_slide', {"imgPath": path});
      if (response == -1) {
        return ApiResponse(
          record: Status.failed,
          status: Status.failed,
        );
      }
      return ApiResponse(
        record: Status.success,
        status: Status.success,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetSlider() async {
    try {
      final response = await db.query('home_slide');

      return ApiResponse(
        record: response,
        status: Status.success,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onDeleteSlide(String imgListSlider) async {
    try {
      final response = await db.delete(
        'home_slide',
        where: "imgPath=?",
        whereArgs: [imgListSlider],
      );
      if (response == -1) {
        return ApiResponse(
          record: Status.failed,
          status: Status.failed,
        );
      }
      return ApiResponse(
        record: Status.success,
        status: Status.success,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onCreateImportGroupItem(
      {required Map<String, dynamic> arg}) async {
    try {
      final response = await db.insert(GroupItemModel.tableName, arg,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      if (response == -1) {
        throw GeneralException();
      }
      return ApiResponse(
        record: Status.success,
        status: Status.success,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetItemTran() async {
    try {
      final response = await db.query(OrderTranModel.orderTran);
      return ApiResponse(
        record: response,
        status: Status.success,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetItemById({required String itemCode}) async {
    try {
      final response = await db
          .query(ItemModel.tableName, where: "code=?", whereArgs: [itemCode]);
      return ApiResponse(
        record: response.isEmpty ? [] : response,
        status: Status.success,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onGetListInvoice() async {
    try {
      final response = await db.query(
        OrderHead.orderHead,
        orderBy: "orderId DESC",
      );
      return ApiResponse(
        record: response.isEmpty ? [] : response,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(record: [], status: Status.failed, msg: _error);
    }
  }

  @override
  Future<ApiResponse> onGetInvoiceDetail({required String invoice}) async {
    try {
      final response = await db.query(
        OrderTranModel.orderTran,
        where: "invoiceNo=?",
        whereArgs: [invoice],
      );
      return ApiResponse(
        record: response.isEmpty ? [] : response,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(record: [], status: Status.failed, msg: _error);
    }
  }

  @override
  Future<ApiResponse> onGetItemCartListCodes() async {
    try {
      final response =
          await db.rawQuery('SELECT code from ${OrderTranModel.orderTranTmp}');
      return ApiResponse(
        record: response.isEmpty ? [] : response,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(record: [], status: Status.failed, msg: _error);
    }
  }

  @override
  Future<ApiResponse> onGetItemWishListCodes() async {
    try {
      final response = await db.query('wishlist');
      return ApiResponse(
        record: response.isEmpty ? [] : response,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: [],
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onSearchItem({required String query}) async {
    try {
      final response = await db.query(
        ItemModel.tableName,
        where: "code LIKE ? OR description LIKE ? OR description_2 LIKE ?",
        whereArgs: ["%$query%", "%$query%", "%$query%"],
      );
      return ApiResponse(
        record: response.isEmpty ? [] : response,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: [],
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onGetGroupByCode({required String code}) async {
    try {
      final response = await db
          .query(GroupItemModel.tableName, where: "code=?", whereArgs: [code]);

      if (response.isEmpty) {
        _error = "group_code_not_found".tr;
        throw Exception();
      }

      return ApiResponse(
        record: response[0],
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: {},
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onGetAllPaymentMethod() async {
    try {
      final response = await db.query(PaymentMethodModel.tableName);
      return ApiResponse(
        record: response,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: [],
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onCreatePaymentMethod({
    required Map<String, dynamic> arg,
  }) async {
    try {
      final response = await db.insert(PaymentMethodModel.tableName, arg);
      if (response == -1) {
        throw SqlException();
      }
      return ApiResponse(
        record: response,
        status: Status.success,
      );
    } catch (e) {
      _error = "payment_method_already_exist".tr;
      return ApiResponse(
        record: "",
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onDeletePaymentMethod(
      {required Map<String, dynamic> arg}) async {
    try {
      final response = await db.query(OrderHead.orderHead,
          where: "paymentId=?", whereArgs: [arg['code']]);
      if (response.isNotEmpty) {
        throw SqlException();
      }
      await db.delete(PaymentMethodModel.tableName,
          where: "code=?", whereArgs: [arg['code']]);
      return ApiResponse(
        record: response,
        status: Status.success,
      );
    } catch (e) {
      _error = "can_not_delete_payment_has_transaction".tr;
      return ApiResponse(
        record: "",
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onUpdatePaymentMethod(
      {required Map<String, dynamic> arg}) async {
    try {
      final response = await db.update(PaymentMethodModel.tableName, arg);
      if (response == -1) {
        throw SqlException();
      }
      return ApiResponse(
        record: response,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: "",
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onGetListCustomer() async {
    try {
      final response = await db.query(CustomerModel.tableName);
      return ApiResponse(
        record: response,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: [],
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> createCustomer(
      {required Map<String, dynamic> arg}) async {
    try {
      await db.insert(CustomerModel.tableName, arg,
          conflictAlgorithm: ConflictAlgorithm.abort);
      return ApiResponse(
        record: true,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: false,
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> updateCustomer(
      {required Map<String, dynamic> arg}) async {
    try {
      final response = await db.update(CustomerModel.tableName, arg,
          where: "code=?", whereArgs: [arg['code']]);

      logger.d(response);

      return ApiResponse(
        record: true,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: false,
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onDeleteCurrentRecord(
      {required Map<String, String> arg}) async {
    try {
      final response = await db.rawDelete(
          "DELETE FROM customer WHERE code = '${arg['code']}' AND code NOT IN (SELECT custId FROM ${OrderHead.orderHead})");

      return ApiResponse(
        record: true,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: false,
        status: Status.failed,
        msg: _error,
      );
    }
  }

  @override
  Future<ApiResponse> onGetCustomerByCode(
      {required Map<String, dynamic> arg}) async {
    try {
      final response = await db.query(CustomerModel.tableName,
          where: "code=?", whereArgs: [arg['code']]);
      return ApiResponse(
        record: response,
        status: Status.success,
      );
    } catch (e) {
      _error = e.toString();
      return ApiResponse(
        record: [],
        status: Status.failed,
        msg: _error,
      );
    }
  }

//end
}
