class ApiResponse<T> {
  T record;
  int currentPage;
  int lastPage;
  T? status;
  String? msg;

  ApiResponse({
    required this.record,
    this.status,
    this.msg,
    this.currentPage = 1,
    this.lastPage = 1,
  });
}
