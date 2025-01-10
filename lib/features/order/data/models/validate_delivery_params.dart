class ValidateDeliveryParams {
  final int deliveryId;
  final String pinCode;
  final int agentId;
  final int supplierId;

  ValidateDeliveryParams({
    required this.deliveryId,
    required this.pinCode,
    required this.agentId,
    required this.supplierId,
  });

  Map<String, dynamic> toJson() => {
        "delivery-id": deliveryId,
        "pin-code": pinCode,
        "agent-id": agentId,
        "supplier-id": supplierId,
      };
}
