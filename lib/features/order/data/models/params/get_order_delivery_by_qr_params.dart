class GetOrderDeliveryByQrParams {
  final String qrCode;
  final int supplierId;
  final String? invoiceNumber;
  GetOrderDeliveryByQrParams({required this.qrCode, required this.supplierId, this.invoiceNumber});

  toMap() => {'qrCode': qrCode, 'supplierId': supplierId, 'invoiceNumber': invoiceNumber};
}
