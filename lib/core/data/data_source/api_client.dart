import 'package:sqflite/sqflite.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/data_source/api_response.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/service/db_service.dart';

class ApiClient extends Api {
  Future<Database> db() async => await DbService.instance.database;

  @override
  Future<ApiResponse> onGetHomeItems({Map? arg}) async {
    try {
      final record = [
        ItemModel(
            uId: 0,
            code: 'item0',
            description: 'description0',
            groupCode: 'group0'),
        ItemModel(
            uId: 1,
            code: 'item1',
            description: 'description1',
            groupCode: 'group1'),
        ItemModel(
            uId: 2,
            code: 'item2',
            description: 'description2',
            groupCode: 'group2'),
        ItemModel(
            uId: 3,
            code: 'item3',
            description: 'description3',
            groupCode: 'group3'),
        ItemModel(
            uId: 4,
            code: 'item4',
            description: 'description4',
            groupCode: 'group4'),
        ItemModel(
            uId: 5,
            code: 'item5',
            description: 'description5',
            groupCode: 'group5'),
      ];
      return ApiResponse(
        record: record,
        status: 'success',
      );
    } catch (e) {
      rethrow;
    }
  }
}
