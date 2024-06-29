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

      // final List<ItemModel> records = [];

      // for (var e in result.record) {
      //   records.add(ItemModel.fromMap(e));
      // }

      return Right(
        RepoResponse(
          record: result.record,
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
          record: '',
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

      // final List<ItemModel> records = [];
      //
      // for (var e in result.record) {
      //   records.add(ItemModel.fromMap(e));
      // }

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