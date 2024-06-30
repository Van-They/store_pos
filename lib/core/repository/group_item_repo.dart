import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/model/group_item_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/exception/failures.dart';
import 'package:store_pos/core/repository/repo_response.dart';

class GroupItemRepo {
  final Api api;

  const GroupItemRepo(this.api);

  Future<Either<Failure, RepoResponse<GroupItemModel>>> onCreateGroupItem(
      {required Map<String, dynamic> arg}) async {
    try {
      final result = await api.onCreateGroupItem(arg: arg);
      if (result.status != 'success') {
        throw GeneralException();
      }
      final record = GroupItemModel.fromMap(result.record);
      return Right(
        RepoResponse(record: record),
      );
    } on GeneralException {
      return Left(ServerFailure('failed'.tr));
    }
  }

  Future<Either<Failure, RepoResponse<List<GroupItemModel>>>>
      onGetGroupItem() async {
    try {
      final result = await api.onGetGroupItem();
      if (result.status != 'success') {
        throw GeneralException();
      }

      final List<GroupItemModel> records = [];

      for (var e in result.record) {
        records.add(GroupItemModel.fromMap(e));
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

  Future<Either<Failure, RepoResponse<String>>> onDeleteGroup(
      {required Map arg}) async {
    try {
      final result = await api.onDeleteGroup(arg: arg);
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

  Future<Either<Failure, RepoResponse<String>>> onUpdateGroup(
      {required Map<String, Object?> arg}) async {
    try {
      final result = await api.onUpdateGroup(arg: arg);
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

  Future<Either<Failure, RepoResponse<List<GroupItemModel>>>>
      onGetGroupItemHome() async {
    try {
      final result = await api.onGetGroupItemHome();
      if (result.status != 'success') {
        throw GeneralException();
      }

      final List<GroupItemModel> records = [];

      for (var e in result.record) {
        records.add(GroupItemModel.fromMap(e));
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

  Future<Either<Failure, RepoResponse<String>>> onToggleDisableGroup(
      {required Map<String, dynamic> arg}) async {
    try {
      final result = await api.onToggleDisableGroup(arg: arg);
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
}
