class ValidateDeliveryParams {
  final int itemId;
  final String pinCode;
  final int agentId;

  ValidateDeliveryParams({
    required this.itemId,
    required this.pinCode,
    required this.agentId,
  });

  Map<String, dynamic> toJson() => {
        "item-id": itemId,
        "pin-code": pinCode,
        "agent-id": agentId,
      };
}
