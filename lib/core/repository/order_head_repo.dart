import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/model/order_head_model.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/exception/failures.dart';
import 'package:store_pos/core/repository/repo_response.dart';

class OrderHeadRepo {
  final Api api;

  const OrderHeadRepo(this.api);

  Future<Either<Failure, RepoResponse<List<OrderHead>>>>
      onGetListInvoice() async {
    final record = await api.onGetListInvoice();
    try {
      if (record.status != Status.success) {
        throw GeneralException();
      }
      final List<OrderHead> records = [];

      for (var e in record.record) {
        records.add(OrderHead.fromMap(e));
      }
      return Right(RepoResponse(record: records));
    } catch (e) {
      return Left(ServerFailure(record.msg ?? "failed".tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<OrderTranModel>>>>
      onGetInvoiceDetail({required String invoice}) async {
    final record = await api.onGetInvoiceDetail(invoice: invoice);
    try {
      if (record.status != Status.success) {
        throw GeneralException();
      }
      final List<OrderTranModel> records = [];

      for (var e in record.record) {
        records.add(OrderTranModel.fromMap(e));
      }
      return Right(RepoResponse(record: records));
    } catch (e) {
      return Left(ServerFailure(record.msg ?? "failed".tr));
    }
  }
}
