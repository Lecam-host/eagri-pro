class PaginateQueries {
  final int? page;
  final int? limit;
  final String? sortBy;

  PaginateQueries({this.page = 1, this.limit, this.sortBy});

  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
        'sortBy': sortBy,
      };
}
