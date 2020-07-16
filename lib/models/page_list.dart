class PageList<T> {
  PageList({
    this.page,
    this.pageSize,
    this.totalCount,
    this.order,
    this.data,
  });

  final int page;
  final int pageSize;
  final int totalCount;
  final String order;
  final List<T> data;

  factory PageList.create(Map<String, dynamic> map, List<T> data) {
    return PageList<T>(
      page: map['page'],
      pageSize: map['pageSize'],
      totalCount: map['totalCount'],
      order: map['order'],
      data: data,
    );
  }
}
