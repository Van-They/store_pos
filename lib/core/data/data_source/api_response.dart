class ApiResponse<T> {
  T record;
  int currentPage;
  int lastPage;
  String? status;

  ApiResponse({
    required this.record,
    this.status,
    this.currentPage = 1,
    this.lastPage = 1,
  });
}
