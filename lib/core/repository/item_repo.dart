import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/exception/failures.dart';
import 'package:store_pos/core/repository/repo_response.dart';

class ItemRepo {
  final Api api;

  const ItemRepo(this.api);

  Future<Either<Failure, RepoResponse<List<ItemModel>>>> onGetHomeItems(
      {Map? arg}) async {
    final result = await api.onGetItem();
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }

      final List<ItemModel> records = [];

      for (var e in result.record) {
        records.add(ItemModel.fromMap(e));
      }

      return Right(RepoResponse(record: records));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<String>>> onCreateItem(
      {required Map<String, dynamic> arg}) async {
    final result = await api.onCreateItem(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: ''));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<ItemModel>>>> onGetItem() async {
    final result = await api.onGetItem();
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }

      final List<ItemModel> records = [];

      for (var e in result.record) {
        records.add(ItemModel.fromMap(e));
      }

      return Right(RepoResponse(record: records));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<Status>>> onDeleteItem(
      String code) async {
    final result = await api.onDeleteItem(code);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: result.record));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<String>>> onUpdateItem(
      {required Map<String, dynamic> arg}) async {
    final result = await api.onUpdateItem(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: ''));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<ItemModel>>>> onGetItemByCategory({
    Map? arg,
  }) async {
    final result = await api.onGetItemByCategory(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      final List<ItemModel> record = [];

      for (var e in result.record) {
        record.add(ItemModel.fromMap(e));
      }

      return Right(RepoResponse(record: record));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<ItemModel>>>> onGetWishList(
      {Map? arg}) async {
    final result = await api.onGetWishList(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      final List<ItemModel> record = [];

      for (var e in result.record) {
        record.add(ItemModel.fromMap(e));
      }

      return Right(RepoResponse(record: record));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<String>>> onToggleWishList(
      {Map? arg}) async {
    final result = await api.onToggleWishList(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: result.record));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<String>>> onCreateImportItem(
      {required Map<String, dynamic> arg}) async {
    final result = await api.onCreateImportItem(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(
        RepoResponse(record: result.record),
      );
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<OrderTranModel>>>>
      onGetItemTran() async {
    final result = await api.onGetItemTran();
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      final List<OrderTranModel> records = [];

      for (var e in result.record) {
        records.add(OrderTranModel.fromMap(e));
      }

      return Right(RepoResponse(record: records));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  //TODO
  Future<Either<Failure, RepoResponse<ItemModel>>> onGetItemById({
    required String itemCode,
  }) async {
    final result = await api.onGetItemById(itemCode: itemCode);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      final records = result.record;

      if (records.isEmpty) {
        throw Exception('empty');
      }
      final record = ItemModel.fromMap(records[0]);
      return Right(RepoResponse(record: record));
    } catch (e) {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<String>>>>
      onGetItemCartListCodes() async {
    final result = await api.onGetItemCartListCodes();
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      final List<String> records = [];

      for (var e in result.record) {
        records.add(e);
      }

      return Right(RepoResponse(record: records));
    } catch (e) {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<String>>>>
      onGetItemWishListCodes() async {
    final result = await api.onGetItemWishListCodes();
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      final List<String> records = [];

      for (var e in result.record) {
        records.add(e);
      }

      return Right(RepoResponse(record: records));
    } catch (e) {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<ItemModel>>>> onSearchItem(
      {required String query}) async {
    final result = await api.onSearchItem(query: query);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      final List<ItemModel> records = [];

      for (var e in result.record) {
        records.add(ItemModel.fromMap(e));
      }

      return Right(RepoResponse(record: records));
    } catch (e) {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }
}
