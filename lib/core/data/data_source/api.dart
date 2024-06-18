import 'package:store_pos/core/data/data_source/api_response.dart';
import 'package:store_pos/core/data/model/item_model.dart';

abstract class Api {
  Future<ApiResponse> onGetHomeItems({Map? arg});

  Future<ApiResponse> onCreateGroupItem({required Map<String, dynamic> arg});

  Future<ApiResponse> onGetGroupItem();

  Future<ApiResponse> onCreateItem({required Map<String, dynamic> arg});

  Future<ApiResponse> onGetItem();

  Future<ApiResponse> toggleCart({required ItemModel arg});

  Future<ApiResponse> onGetItemCart();

  Future<ApiResponse> onGetSetting();

  Future<ApiResponse> onGetOrderHead();
}
