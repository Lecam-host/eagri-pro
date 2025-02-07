// To parse this JSON data, do
//
//     final deliveryModel = deliveryModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

DeliveryModel deliveryModelFromJson(String str) =>
    DeliveryModel.fromJson(json.decode(str));

String deliveryModelToJson(DeliveryModel data) => json.encode(data.toJson());

class DeliveryStatus {
  final String name;
  final String description;
  final Color color;

  // Constructeur privé
  const DeliveryStatus._(this.name, this.description, this.color);

  // Définition des différentes valeurs de statut avec leurs couleurs correspondantes
  static const DeliveryStatus pending = DeliveryStatus._(
    'PENDING',
    'En attente',
    Colors.blue, // Couleur associée
  );
  static const DeliveryStatus partiallyDelivered = DeliveryStatus._(
    'PARTIALLY_DELIVERED',
    'Partiellement livré',
    Colors.orange, // Couleur associée
  );
  static const DeliveryStatus delivered = DeliveryStatus._(
    'DELIVERED',
    'Livré',
    Colors.green, // Couleur associée
  );
  static const DeliveryStatus cancelled = DeliveryStatus._(
    'CANCELLED',
    'Annulé',
    Colors.red, // Couleur associée
  );
  // Status non défini
  static const DeliveryStatus undefined = DeliveryStatus._(
    'UNDEFINED',
    'Tout',
    Colors.grey, // Couleur associée
  );

  // Liste de toutes les valeurs
  static const List<DeliveryStatus> values = [
    pending,
    partiallyDelivered,
    delivered,
    cancelled,
  ];

  // Méthode pour convertir une chaîne de caractères en un statut
  static DeliveryStatus? fromString(String statusString) {
    return values.firstWhere(
      (status) => status.name.toLowerCase() == statusString.toLowerCase(),
      orElse: () => DeliveryStatus._(
          statusString, 'Statut de livraison non trouvé', Colors.grey),
    );
  }
}
// To parse this JSON data, do
//
//     final deliveryModel = deliveryModelFromJson(jsonString);

class DeliveryModel {
  final int id;
  final dynamic deliveredBy;
  final DeliveryModelProduct product;
  final double unitPrice;
  final int quantity;
  final DeliveryStatus? status;
  final dynamic deliveryDate;

  DeliveryModel({
    required this.id,
    required this.deliveredBy,
    required this.product,
    required this.unitPrice,
    required this.quantity,
    this.status,
    required this.deliveryDate,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
        id: json["id"],
        deliveredBy: json["deliveredBy"],
        product: DeliveryModelProduct.fromJson(json["product"]),
        unitPrice: json["unitPrice"],
        quantity: json["quantity"],
        status: DeliveryStatus.fromString(json["status"]),
        deliveryDate: json["deliveryDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deliveredBy": deliveredBy,
        "product": product.toJson(),
        "unitPrice": unitPrice,
        "quantity": quantity,
        "status": status,
        "deliveryDate": deliveryDate,
      };
}

class DeliveryModelProduct {
  final int id;
  final String numberIdentification;
  final double price;
  final ProductProduct product;

  DeliveryModelProduct({
    required this.id,
    required this.numberIdentification,
    required this.price,
    required this.product,
  });

  factory DeliveryModelProduct.fromJson(Map<String, dynamic> json) =>
      DeliveryModelProduct(
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
  final dynamic image;

  ProductProduct({
    required this.id,
    required this.name,
    required this.image,
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
