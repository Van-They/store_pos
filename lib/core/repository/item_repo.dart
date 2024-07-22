import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/exception/failures.dart';
import 'package:store_pos/core/repository/repo_response.dart';

class ItemRepo {
  final Api api;

  const ItemRepo(this.api);

  Future<Either<Failure, RepoResponse<List<ItemModel>>>> onGetHomeItems(
      {Map? arg}) async {
    try {
      final result = await api.onGetItem();
      if (result.status != 'success') {
        throw GeneralException();
      }

      final List<ItemModel> records = [];

      for (var e in result.record) {
        records.add(ItemModel.fromMap(e));
      }

      return Right(
        RepoResponse(
          record: records,
        ),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<String>>> onCreateItem(
      {required Map<String, dynamic> arg}) async {
    try {
      final result = await api.onCreateItem(arg: arg);
      if (result.status != 'success') {
        throw GeneralException();
      }
      return Right(
        RepoResponse(
          record: result.status,
        ),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<ItemModel>>>> onGetItem() async {
    try {
      final result = await api.onGetItem();
      if (result.status != 'success') {
        throw GeneralException();
      }

      final List<ItemModel> records = [];

      for (var e in result.record) {
        records.add(ItemModel.fromMap(e));
      }

      return Right(
        RepoResponse(
          record: records,
        ),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<String>>> onDeleteItem(
      String code) async {
    try {
      final result = await api.onDeleteItem(code);
      if (result.status != 'success') {
        throw GeneralException();
      }
      return Right(
        RepoResponse(record: result.record),
      );
    } on GeneralException {
      return Left(ServerFailure('can_not_delete_item_has_transaction'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<String>>> onUpdateItem(
      {required Map<String, dynamic> arg}) async {
    try {
      final result = await api.onUpdateItem(arg: arg);
      if (result.status != 'success') {
        throw GeneralException();
      }
      return Right(
        RepoResponse(
          record: result.status,
        ),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<ItemModel>>>> onGetItemByCategory({
    Map? arg,
  }) async {
    try {
      final result = await api.onGetItemByCategory(arg: arg);
      if (result.status != 'success') {
        throw GeneralException();
      }
      final List<ItemModel> record = [];

      for (var e in result.record) {
        record.add(ItemModel.fromMap(e));
      }

      return Right(
        RepoResponse(
          record: record,
        ),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<ItemModel>>>> onGetWishList(
      {Map? arg}) async {
    final result = await api.onGetWishList(arg: arg);
    try {
      if (result.status != 'success') {
        throw GeneralException();
      }
      final List<ItemModel> record = [];

      for (var e in result.record) {
        record.add(ItemModel.fromMap(e));
      }

      return Right(
        RepoResponse(
          record: record,
        ),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<String>>> onToggleWishList(
      {Map? arg}) async {
    final result = await api.onToggleWishList(arg: arg);
    try {
      if (result.status != 'success') {
        throw GeneralException();
      }
      return Right(
        RepoResponse(
          record: result.record,
        ),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }
}
