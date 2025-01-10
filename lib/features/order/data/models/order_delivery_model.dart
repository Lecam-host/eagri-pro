// To parse this JSON data, do
//
//     final orderDeliveryModel = orderDeliveryModelFromJson(jsonString);

import 'dart:convert';

import 'package:eagri_pro/features/order/data/models/delivery_model.dart';

OrderDeliveryModel orderDeliveryModelFromJson(String str) =>
    OrderDeliveryModel.fromJson(json.decode(str));

String orderDeliveryModelToJson(OrderDeliveryModel data) =>
    json.encode(data.toJson());

class OrderDeliveryModel {
  final Delivery delivery;
  final Customer customer;
  final List<OrderDeliveryModelItem> items;

  OrderDeliveryModel({
    required this.delivery,
    required this.customer,
    required this.items,
  });

  factory OrderDeliveryModel.fromJson(Map<String, dynamic> json) =>
      OrderDeliveryModel(
        delivery: Delivery.fromJson(json["delivery"]),
        customer: Customer.fromJson(json["customer"]),
        items: List<OrderDeliveryModelItem>.from(
            json["items"].map((x) => OrderDeliveryModelItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "delivery": delivery.toJson(),
        "customer": customer.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
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
  final List<String>? registrationIds;

  Customer({
    required this.id,
    required this.username,
    required this.name,
    required this.phone,
    this.email,
    this.whatsAppId,
    required this.typeAccount,
    this.registrationIds,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        whatsAppId: json["whatsAppId"],
        typeAccount: json["typeAccount"],
        registrationIds: json["registrationIds"] == null
            ? []
            : List<String>.from(json["registrationIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "phone": phone,
        "email": email,
        "whatsAppId": whatsAppId,
        "typeAccount": typeAccount,
        "registrationIds": registrationIds == null
            ? []
            : List<dynamic>.from(registrationIds!.map((x) => x)),
      };
}

class Delivery {
  final int id;
  final DeliveryStatus status;
  final int customerId;
  final double totalAmount;
  final String invoiceNumber;
  final DateTime creationDate;
  final List<DeliveryItem> items;

  Delivery({
    required this.id,
    required this.status,
    required this.customerId,
    required this.totalAmount,
    required this.invoiceNumber,
    required this.creationDate,
    required this.items,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        id: json["id"],
        status:
            DeliveryStatus.fromString(json["status"]) ?? DeliveryStatus.pending,
        customerId: json["customerId"],
        totalAmount: json["totalAmount"],
        invoiceNumber: json["invoiceNumber"],
        creationDate: DateTime.parse(json["creationDate"]),
        items: List<DeliveryItem>.from(
            json["items"].map((x) => DeliveryItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "customerId": customerId,
        "totalAmount": totalAmount,
        "invoiceNumber": invoiceNumber,
        "creationDate": creationDate.toIso8601String(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class DeliveryItem {
  final int id;
  final DeliveryStatus status;
  final int productId;
  final int supplierId;
  final int? deliveredBy;
  final double unitPrice;
  final int quantity;
  final DateTime? deliveryDate;

  DeliveryItem({
    required this.id,
    required this.status,
    required this.productId,
    required this.supplierId,
     this.deliveredBy,
    required this.unitPrice,
    required this.quantity,
     this.deliveryDate,
  });

  factory DeliveryItem.fromJson(Map<String, dynamic> json) => DeliveryItem(
        id: json["id"],
        status:
            DeliveryStatus.fromString(json["status"]) ?? DeliveryStatus.pending,
        productId: json["productId"],
        supplierId: json["supplierId"],
        deliveredBy: json["deliveredBy"],
        unitPrice: json["unitPrice"],
        quantity: json["quantity"],
        deliveryDate: json["deliveryDate"] == null ? null : DateTime.parse(json["deliveryDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "productId": productId,
        "supplierId": supplierId,
        "deliveredBy": deliveredBy,
        "unitPrice": unitPrice,
        "quantity": quantity,
        "deliveryDate": deliveryDate?.toIso8601String(),
      };
}

class OrderDeliveryModelItem {
  final Customer supplier;
  final Customer? deliveredBy;
  final ItemProduct product;
  final double unitPrice;
  final int quantity;
  final DeliveryStatus status;
  final DateTime? deliveryDate;

  OrderDeliveryModelItem({
    required this.supplier,
     this.deliveredBy,
    required this.product,
    required this.unitPrice,
    required this.quantity,
    required this.status,
     this.deliveryDate,
  });

  factory OrderDeliveryModelItem.fromJson(Map<String, dynamic> json) =>
      OrderDeliveryModelItem(
        supplier: Customer.fromJson(json["supplier"]),
        deliveredBy: json["deliveredBy"] == null ? null : Customer.fromJson(json["deliveredBy"]),
        product: ItemProduct.fromJson(json["product"]),
        unitPrice: json["unitPrice"],
        quantity: json["quantity"],
        status:
            DeliveryStatus.fromString(json["status"]) ?? DeliveryStatus.pending,
        deliveryDate: json["deliveryDate"] == null ? null : DateTime.parse(json["deliveryDate"]),
      );

  Map<String, dynamic> toJson() => {
        "supplier": supplier.toJson(),
        "deliveredBy": deliveredBy?.toJson(),
        "product": product.toJson(),
        "unitPrice": unitPrice,
        "quantity": quantity,
        "status": status,
        "deliveryDate": deliveryDate?.toIso8601String(),
      };
}

class ItemProduct {
  final int id;
  final String numberIdentification;
  final double price;
  final ProductProduct product;

  ItemProduct({
    required this.id,
    required this.numberIdentification,
    required this.price,
    required this.product,
  });

  factory ItemProduct.fromJson(Map<String, dynamic> json) => ItemProduct(
        id: json["id"],
        numberIdentification: json["number_identification"],
        price: json["price"],
        product: ProductProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number_identification": numberIdentification,
        "price": price,
        "product": product.toJson(),
      };
}

class ProductProduct {
  final int id;
  final String name;
  final String? image;

  ProductProduct({
    required this.id,
    required this.name,
    this.image,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}