import 'package:eagri_pro/features/order/data/models/delivery_model.dart';

class GetOrdersParams {
  final int supplierId;
  final int? limit;
  final int? page;
  final DeliveryStatus? status;
  final String? invoiceNumber;

  GetOrdersParams({
    this.limit,
    this.page,
    required this.supplierId,
    this.status,
    this.invoiceNumber,
  });

  toMap() {
    return {'limit': limit, 'page': page, 'status': status?.name, 'invoiceNumber': invoiceNumber};
  }
}
