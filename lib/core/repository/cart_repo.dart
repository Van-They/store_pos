import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/data/model/order_head_model.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/exception/failures.dart';
import 'package:store_pos/core/repository/repo_response.dart';

class CartRepo {
  final Api api;
  const CartRepo(this.api);

  Future<Either<Failure, RepoResponse<OrderTranModel>>> toggleCart(
      {required ItemModel arg}) async {
    try {
      final result = await api.toggleCart(arg: arg);
      if (result.status != 'success') {
        throw GeneralException();
      }

      final orderTrand = OrderTranModel.fromMap(result.record);

      return Right(
        RepoResponse(
          record: orderTrand,
        ),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<OrderTranModel>>>>
      onGetItemCart() async {
    try {
      final result = await api.onGetItemCart();
      if (result.status != 'success') {
        throw GeneralException();
      }

      final List<OrderTranModel> records = [];

      for (var e in result.record) {
        records.add(OrderTranModel.fromMap(e));
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

  Future<Either<Failure, RepoResponse<OrderHead>>> onGetOrderHead() async {
    try {
      final result = await api.onGetOrderHead();
      if (result.status != 'success') {
        throw GeneralException();
      }

      final OrderHead record = OrderHead.fromMap(result.record);
      
      return Right(
        RepoResponse(
          record: record,
        ),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }
}
