import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/model/setting_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/exception/failures.dart';
import 'package:store_pos/core/repository/repo_response.dart';

class SettingRepo {
  final Api api;
  const SettingRepo(this.api);

  Future<Either<Failure, RepoResponse<SettingModel>>> onGetSetting() async {
    try {
      final result = await api.onGetSetting();
      if (result.status != 'success') {
        throw GeneralException();
      }
      final record = SettingModel.fromMap(result.record);

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
