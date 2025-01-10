// To parse this JSON data, do
//
//     final getProductBuyResponse = getProductBuyResponseFromJson(jsonString);

import 'dart:convert';

import 'search_notation_rsponse_model.dart';

GetMyOpinionProductBuyResponse getProductBuyResponseFromJson(String str) =>
    GetMyOpinionProductBuyResponse.fromJson(json.decode(str));

String getProductBuyResponseToJson(GetMyOpinionProductBuyResponse data) =>
    json.encode(data.toJson());

class GetMyOpinionProductBuyResponse {
  int statusCode;
  String statusMessage;
  DataMyOpinionProductBuyModel data;

  GetMyOpinionProductBuyResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory GetMyOpinionProductBuyResponse.fromJson(Map<String, dynamic> json) =>
      GetMyOpinionProductBuyResponse(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: DataMyOpinionProductBuyModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data.toJson(),
      };
}

class DataMyOpinionProductBuyModel {
  int total;
  int totalOfPages;
  int perPage;
  List<String> sorts;
  String order;
  int currentPage;
  int nextPage;
  int previousPage;
  dynamic filters;
  List<ItemMyOpinionProductBuyModel> items;

  DataMyOpinionProductBuyModel({
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

  factory DataMyOpinionProductBuyModel.fromJson(Map<String, dynamic> json) =>
      DataMyOpinionProductBuyModel(
        total: json["total"],
        totalOfPages: json["total_of_pages"],
        perPage: json["per_page"],
        sorts: List<String>.from(json["sorts"].map((x) => x)),
        order: json["order"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        previousPage: json["previous_page"],
        filters: json["filters"],
        items: List<ItemMyOpinionProductBuyModel>.from(
            json["items"].map((x) => ItemMyOpinionProductBuyModel.fromJson(x))),
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

class ItemMyOpinionProductBuyModel {
  int id;
  int publicationId;
  Seller seller;
  Organism organism;
  CategoryProduct categoryProduct;
  Product product;
  List<PaymentMethod> paymentMethod;
  int quantity;
  double unitPrice;
  double price;
  double percentage;
  String status;
  ItemSearchNotationModel? note;

  ItemMyOpinionProductBuyModel({
    required this.id,
    required this.publicationId,
    required this.seller,
    required this.organism,
    required this.categoryProduct,
    required this.product,
    required this.paymentMethod,
    required this.quantity,
    required this.unitPrice,
    required this.price,
    required this.percentage,
    required this.status,
    this.note,
  });

  factory ItemMyOpinionProductBuyModel.fromJson(Map<String, dynamic> json) =>
      ItemMyOpinionProductBuyModel(
        id: json["id"],
        publicationId: json["publicationId"],
        seller: Seller.fromJson(json["seller"]),
        organism: Organism.fromJson(json["organism"]),
        categoryProduct: CategoryProduct.fromJson(json["categoryProduct"]),
        product: Product.fromJson(json["product"]),
        paymentMethod: List<PaymentMethod>.from(
            json["paymentMethod"].map((x) => PaymentMethod.fromJson(x))),
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
        price: json["price"],
        percentage: json["percentage"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "publicationId": publicationId,
        "seller": seller.toJson(),
        "organism": organism.toJson(),
        "categoryProduct": categoryProduct.toJson(),
        "product": product.toJson(),
        "paymentMethod":
            List<dynamic>.from(paymentMethod.map((x) => x.toJson())),
        "quantity": quantity,
        "unitPrice": unitPrice,
        "price": price,
        "percentage": percentage,
        "status": status,
      };
}

class CategoryProduct {
  dynamic id;
  dynamic name;
  dynamic code;
  dynamic numberIdentification;

  CategoryProduct({
    required this.id,
    required this.name,
    required this.code,
    required this.numberIdentification,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      CategoryProduct(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        numberIdentification: json["numberIdentification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "numberIdentification": numberIdentification,
      };
}

class Organism {
  dynamic id;
  dynamic username;
  dynamic name;
  dynamic phone;
  dynamic email;

  Organism({
    required this.id,
    required this.username,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory Organism.fromJson(Map<String, dynamic> json) => Organism(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "phone": phone,
        "email": email,
      };
}

class PaymentMethod {
  int id;
  String code;
  String nom;

  PaymentMethod({
    required this.id,
    required this.code,
    required this.nom,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        code: json["code"],
        nom: json["nom"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "nom": nom,
      };
}

class Product {
  int id;
  String name;
  int code;
  String numberIdentification;
  String unit;
  String productImage;
  DateTime createdAt;
  Location location;

  Product({
    required this.id,
    required this.name,
    required this.code,
    required this.numberIdentification,
    required this.unit,
    required this.productImage,
    required this.createdAt,
    required this.location,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        numberIdentification: json["numberIdentification"],
        unit: json["unit"],
        productImage: json["productImage"],
        createdAt: DateTime.parse(json["createdAt"]),
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "numberIdentification": numberIdentification,
        "unit": unit,
        "productImage": productImage,
        "createdAt": createdAt.toIso8601String(),
        "location": location.toJson(),
      };
}

class Location {
  Department locality;
  Department region;
  Department department;
  Department subprefecture;

  Location({
    required this.locality,
    required this.region,
    required this.department,
    required this.subprefecture,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        locality: Department.fromJson(json["locality"]),
        region: Department.fromJson(json["region"]),
        department: Department.fromJson(json["department"]),
        subprefecture: Department.fromJson(json["subprefecture"]),
      );

  Map<String, dynamic> toJson() => {
        "locality": locality.toJson(),
        "region": region.toJson(),
        "department": department.toJson(),
        "subprefecture": subprefecture.toJson(),
      };
}

class Department {
  int? id;
  String? name;

  Department({
    required this.id,
    required this.name,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Seller {
  int id;
  dynamic username;
  String firstname;
  String lastname;
  String phone;
  String typeAccount;

  Seller({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.typeAccount,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        typeAccount: json["typeAccount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "typeAccount": typeAccount,
      };
}
