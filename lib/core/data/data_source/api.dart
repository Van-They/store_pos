import 'package:store_pos/core/data/data_source/api_response.dart';

abstract class Api {
  Future<ApiResponse> onGetHomeItems({Map? arg});
}