// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:eagri_pro/features/order/data/models/delivery_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final Customer customer;
  final String invoiceNumber;
  final DateTime createdAt;
  final DeliveryStatus status;

  OrderModel(
      {required this.customer,
      required this.invoiceNumber,
      required this.createdAt,
      required this.status});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        customer: Customer.fromJson(json["customer"]),
        invoiceNumber: json["invoiceNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        status: DeliveryStatus.fromString(json["deliveryStatus"])!,
      );

  Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "invoiceNumber": invoiceNumber,
        "createdAt": createdAt,
        "status": status.name,
      };
}

class Customer {
  final int id;
  final String username;
  final String name;
  final String phone;
  final String? email;
  final String? whatsAppId;
  final String typeAccount;

  Customer({
    required this.id,
    required this.username,
    required this.name,
    required this.phone,
    this.email,
    this.whatsAppId,
    required this.typeAccount,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        whatsAppId: json["whatsAppId"],
        typeAccount: json["typeAccount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "phone": phone,
        "email": email,
        "whatsAppId": whatsAppId,
        "typeAccount": typeAccount,
      };
}
