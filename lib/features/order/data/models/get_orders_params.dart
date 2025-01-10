class GetOrdersParams {
  final int supplierId;
  final int? limit;
  final int? page;

  GetOrdersParams({
    this.limit,
    this.page,
    required this.supplierId,
  });

  toMap() {
    return {
      'limit': limit,
      'page': page,
    };
  }
}
