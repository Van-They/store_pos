import 'package:store_pos/core/constant/constant.dart';

class ApiResponse<T> {
  T record;
  int currentPage;
  int lastPage;
  Status? status;
  String? msg;

  ApiResponse({
    required this.record,
    this.status,
    this.msg,
    this.currentPage = 1,
    this.lastPage = 1,
  });
}
