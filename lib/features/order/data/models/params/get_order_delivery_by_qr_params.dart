class GetOrderDeliveryByQrParams {
  final String qrCode;
  final int supplierId;

  GetOrderDeliveryByQrParams({required this.qrCode, required this.supplierId});

  toMap() => {'qrCode': qrCode, 'supplierId': supplierId};
}
