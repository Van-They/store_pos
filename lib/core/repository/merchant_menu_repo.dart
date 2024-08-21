import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/exception/failures.dart';
import 'package:store_pos/core/repository/repo_response.dart';

class MerchantMenuRepo {
  final Api api;

  const MerchantMenuRepo(this.api);

  Future<Either<Failure, RepoResponse<List<String>>>> onGetSlider() async {
    final result = await api.onGetSlider();
    try {
      if (result.status != 'success') {
        throw GeneralException();
      }
      final List<String> record = [];

      for (var e in result.record) {
        record.add(e['imgPath']);
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

  Future<Either<Failure, RepoResponse<bool>>> onDeleteSlide(String imgListSlider) async {
    final result = await api.onDeleteSlide(imgListSlider);
    try {
      if (result.status != 'success') {
        throw GeneralException();
      }
      return Right(
        RepoResponse(record: true),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }

  void onAddSlide() {}

  Future<Either<Failure, RepoResponse<bool>>> onSaveImageSlider(
      String path) async {
    final result = await api.onSaveImageSlider(path);
    try {
      if (result.status != 'success') {
        throw GeneralException();
      }
      return Right(
        RepoResponse(record: true),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }
}
