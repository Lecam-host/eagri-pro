
class PaymentModel {
  final DateTime? createdAt;
  final bool? deleted;
  final dynamic deletedAt;
  final dynamic updatedAt;
  final int? id;
  final String? paymentId;
  final String? band;
  final String? period;
  final PaymentItemModel? payment;
  PaymentModel({
    this.createdAt,
    this.deleted,
    this.deletedAt,
    this.updatedAt,
    this.id,
    this.paymentId,
    this.band,
    this.period,
    this.payment,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deleted: json["deleted"],
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        paymentId: json["paymentId"],
        band: json["band"],
        period: json["period"],
        payment: json["payment"] == null
            ? null
            : PaymentItemModel.fromJson(json["payment"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "deleted": deleted,
        "deletedAt": deletedAt,
        "updatedAt": updatedAt,
        "id": id,
        "paymentId": paymentId,
        "band": band,
        "period": period,
        "payment": payment,
      };
}

class PaymentItemModel  {
  final int? id;
  final String? name;
  final String? code;
  PaymentItemModel({
    this.id,
    this.name,
    this.code,
  });

  factory PaymentItemModel.fromJson(Map<String, dynamic> json) =>
      PaymentItemModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
