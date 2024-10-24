class RepoResponse<T> {
  T record;
  int currentPage;
  int lastPage;

  RepoResponse({
    required this.record,
    this.currentPage = 1,
    this.lastPage = 1,
  });
}
