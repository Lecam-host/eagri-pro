// To parse this JSON data, do
//
//     final getListDemandeCashResponse = getListDemandeCashResponseFromJson(jsonString);

import 'dart:convert';

GetListDemandeCashResponse getListDemandeCashResponseFromJson(String str) =>
    GetListDemandeCashResponse.fromJson(json.decode(str));

String getListDemandeCashResponseToJson(GetListDemandeCashResponse data) =>
    json.encode(data.toJson());

class GetListDemandeCashResponse {
  int statusCode;
  String statusMessage;
  Data data;

  GetListDemandeCashResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory GetListDemandeCashResponse.fromJson(Map<String, dynamic> json) =>
      GetListDemandeCashResponse(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data.toJson(),
      };
}

class Data {
  int total;
  int totalOfPages;
  int perPage;
  List<String> sorts;
  String order;
  int currentPage;
  int nextPage;
  int previousPage;
  dynamic filters;
  List<DeamandePaiementItemModel> items;

  Data({
    required this.total,
    required this.totalOfPages,
    required this.perPage,
    required this.sorts,
    required this.order,
    required this.currentPage,
    required this.nextPage,
    required this.previousPage,
    required this.filters,
    required this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        totalOfPages: json["total_of_pages"],
        perPage: json["per_page"],
        sorts: List<String>.from(json["sorts"].map((x) => x)),
        order: json["order"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        previousPage: json["previous_page"],
        filters: json["filters"],
        items: List<DeamandePaiementItemModel>.from(
            json["items"].map((x) => DeamandePaiementItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "total_of_pages": totalOfPages,
        "per_page": perPage,
        "sorts": List<dynamic>.from(sorts.map((x) => x)),
        "order": order,
        "current_page": currentPage,
        "next_page": nextPage,
        "previous_page": previousPage,
        "filters": filters,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class DeamandePaiementItemModel {
  int id;
  String paymentMethod;
  Buyer seller;
  Buyer buyer;
  Product product;
  int quantity;
  double amount;
  String status;
  dynamic cancelReason;
  dynamic confirmationCode;
  DateTime createdAt;
  dynamic updatedAt;

  DeamandePaiementItemModel({
    required this.id,
    required this.paymentMethod,
    required this.seller,
    required this.buyer,
    required this.product,
    required this.quantity,
    required this.amount,
    required this.status,
    required this.cancelReason,
    required this.confirmationCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeamandePaiementItemModel.fromJson(Map<String, dynamic> json) =>
      DeamandePaiementItemModel(
        id: json["id"],
        paymentMethod: json["paymentMethod"],
        seller: Buyer.fromJson(json["seller"]),
        buyer: Buyer.fromJson(json["buyer"]),
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        amount: json["amount"],
        status: json["status"],
        cancelReason: json["cancelReason"],
        confirmationCode: json["confirmationCode"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paymentMethod": paymentMethod,
        "seller": seller.toJson(),
        "buyer": buyer.toJson(),
        "product": product.toJson(),
        "quantity": quantity,
        "amount": amount,
        "status": status,
        "cancelReason": cancelReason,
        "confirmationCode": confirmationCode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt,
      };
}

class Buyer {
  int? id;
  int accountId;
  String fullName;
  String phone;

  Buyer({
    required this.id,
    required this.accountId,
    required this.fullName,
    required this.phone,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
        id: json["id"],
        accountId: json["accountId"],
        fullName: json["fullName"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountId": accountId,
        "fullName": fullName,
        "phone": phone,
      };
}

class Product {
  int id;
  String name;
  dynamic image;

  Product({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
