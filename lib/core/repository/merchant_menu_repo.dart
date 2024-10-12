import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/constant.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/model/customer_model.dart';
import 'package:store_pos/core/data/model/payment_method_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/exception/failures.dart';
import 'package:store_pos/core/repository/repo_response.dart';

class MerchantMenuRepo {
  final Api api;

  const MerchantMenuRepo(this.api);

  Future<Either<Failure, RepoResponse<List<String>>>> onGetSlider() async {
    final result = await api.onGetSlider();
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      final List<String> record = [];

      for (var e in result.record) {
        record.add(e['imgPath']);
      }
      return Right(RepoResponse(record: record));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<bool>>> onDeleteSlide(
      String imgListSlider) async {
    final result = await api.onDeleteSlide(imgListSlider);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: true));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  void onAddSlide() {}

  Future<Either<Failure, RepoResponse<bool>>> onSaveImageSlider(
      String path) async {
    final result = await api.onSaveImageSlider(path);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: true));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<PaymentMethodModel>>>>
      onGetAllPaymentMethod() async {
    final result = await api.onGetAllPaymentMethod();
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      final List<PaymentMethodModel> record = [];

      for (var e in result.record) {
        record.add(PaymentMethodModel.fromMap(e));
      }
      return Right(RepoResponse(record: record));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<bool>>> onCreatePaymentMethod(
      {required Map<String, dynamic> arg}) async {
    final result = await api.onCreatePaymentMethod(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: true));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<bool>>> onDeletePaymentMethod(
      {required Map<String, dynamic> arg}) async {
    final result = await api.onDeletePaymentMethod(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: true));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<bool>>> onUpdatePaymentMethod(
      {required Map<String, dynamic> arg}) async {
    final result = await api.onUpdatePaymentMethod(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: true));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<CustomerModel>>>>
      getListCustomer() async {
    final result = await api.onGetListCustomer();
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }

      final List<CustomerModel> dataSet = [];

      for (var e in result.record) {
        dataSet.add(CustomerModel.fromMap(e));
      }

      return Right(RepoResponse(record: dataSet));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<bool>>> createCustomer(
      {required Map<String, dynamic> arg}) async {
    final result = await api.createCustomer(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: true));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<bool>>> onDeleteCurrentRecord(
      {required Map<String, String> arg}) async {
    final result = await api.onDeleteCurrentRecord(arg: arg);
    try {
      if (result.status != Status.success) {
        throw GeneralException();
      }
      return Right(RepoResponse(record: true));
    } on GeneralException {
      return Left(ServerFailure(result.msg ?? 'failed'.tr));
    }
  }
}
