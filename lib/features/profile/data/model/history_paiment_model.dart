// To parse this JSON data, do
//
//     final historyResponseModel = historyResponseModelFromJson(jsonString);

import 'dart:convert';

import 'search_notation_rsponse_model.dart';

HistoryPaiementResponseModel historyResponseModelFromJson(String str) =>
    HistoryPaiementResponseModel.fromJson(json.decode(str));

String historyResponseModelToJson(HistoryPaiementResponseModel data) =>
    json.encode(data.toJson());

class HistoryPaiementResponseModel {
  int statusCode;
  String statusMessage;
  List<DataHistoryPaiementModel> data;

  HistoryPaiementResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory HistoryPaiementResponseModel.fromJson(Map<String, dynamic> json) =>
      HistoryPaiementResponseModel(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: List<DataHistoryPaiementModel>.from(json["data"]["items"]
            .map((x) => DataHistoryPaiementModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataHistoryPaiementModel {
  Other other;
  double totalPrice;
  List<ProductElementHistoryPaiementModel> products;

  DataHistoryPaiementModel({
    required this.other,
    required this.totalPrice,
    required this.products,
  });

  factory DataHistoryPaiementModel.fromJson(Map<String, dynamic> json) =>
      DataHistoryPaiementModel(
        other: Other.fromJson(json["other"]),
        totalPrice: json["totalPrice"],
        products: List<ProductElementHistoryPaiementModel>.from(json["products"]
            .map((x) => ProductElementHistoryPaiementModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "other": other.toJson(),
        "totalPrice": totalPrice,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Other {
  int id;
  dynamic username;
  String firstname;
  String? lastname;
  String phone;
  String? typeAccount;

  Other({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.typeAccount,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        id: json["id"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        typeAccount: json["typeAccount"] ?? '',
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

class ProductElementHistoryPaiementModel {
  int publicationId;
  ProductProduct product;
  int notation;
  Other user;
  int quantity;
  double unitPrice;
  String paymentMethod;
  double price;
  ItemSearchNotationModel? note;

  DateTime? buyerAt;

  ProductElementHistoryPaiementModel({
    required this.publicationId,
    required this.product,
    required this.notation,
    required this.user,
    required this.quantity,
    required this.unitPrice,
    required this.paymentMethod,
    required this.price,
    this.note,
    this.buyerAt,
  });

  factory ProductElementHistoryPaiementModel.fromJson(
          Map<String, dynamic> json) =>
      ProductElementHistoryPaiementModel(
        publicationId: json["publicationId"],
        product: ProductProduct.fromJson(json["product"]),
        notation: json["notation"],
        user: Other.fromJson(json["user"]),
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
        paymentMethod: json["paymentMethod"],
        price: json["price"],
        buyerAt:
            json["buyerAt"] != null ? DateTime.parse(json["buyerAt"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "publicationId": publicationId,
        "product": product.toJson(),
        "notation": notation,
        "user": user.toJson(),
        "quantity": quantity,
        "unitPrice": unitPrice,
        "price": price,
        "buyerAt": buyerAt!.toIso8601String(),
      };
}

class ProductProduct {
  int? id;
  String? name;
  int? code;
  String? numberIdentification;
  String? unit;

  String? productImage;

  ProductProduct(
      {this.id,
      this.name,
      this.code,
      this.numberIdentification,
      this.unit,
      this.productImage});

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        numberIdentification: json["numberIdentification"],
        unit: json["unit"],
        productImage: json["productImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "numberIdentification": numberIdentification,
        "unit": unit,
        "productImage": productImage
      };
}
// To parse this JSON data, do
//
//     final getProductBuyResponse = getProductBuyResponseFromJson(jsonString);

GetProductBuyResponse getProductBuyResponseFromJson(String str) =>
    GetProductBuyResponse.fromJson(json.decode(str));

String getProductBuyResponseToJson(GetProductBuyResponse data) =>
    json.encode(data.toJson());

class GetProductBuyResponse {
  int statusCode;
  String statusMessage;
  Data data;

  GetProductBuyResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory GetProductBuyResponse.fromJson(Map<String, dynamic> json) =>
      GetProductBuyResponse(
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
  List<CommandBuyModel> items;

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
        items: List<CommandBuyModel>.from(
            json["items"].map((x) => CommandBuyModel.fromJson(x))),
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

class CommandBuyModel {
  int id;
  String numberOrder;
  List<ProductBuyModel> shoppingCart;
  Buyer buyer;
  DateTime createdAt;
  DateTime orderAt;
  double totalPrice;
  String status;

  CommandBuyModel({
    required this.id,
    required this.numberOrder,
    required this.shoppingCart,
    required this.buyer,
    required this.createdAt,
    required this.orderAt,
    required this.totalPrice,
    required this.status,
  });

  factory CommandBuyModel.fromJson(Map<String, dynamic> json) =>
      CommandBuyModel(
        id: json["id"],
        numberOrder: json["numberOrder"],
        shoppingCart: List<ProductBuyModel>.from(
            json["shoppingCart"].map((x) => ProductBuyModel.fromJson(x))),
        buyer: Buyer.fromJson(json["buyer"]),
        createdAt: DateTime.parse(json["createdAt"]),
        orderAt: DateTime.parse(json["orderAt"]),
        totalPrice: json["totalPrice"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numberOrder": numberOrder,
        "shoppingCart": List<dynamic>.from(shoppingCart.map((x) => x.toJson())),
        "buyer": buyer.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "orderAt": orderAt.toIso8601String(),
        "totalPrice": totalPrice,
        "status": status,
      };
}

class Buyer {
  int id;
  dynamic username;
  String firstname;
  String lastname;
  String phone;
  String typeAccount;

  Buyer({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.typeAccount,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
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

class ProductBuyModel {
  int id;
  int publicationId;
  Buyer seller;
  Organism organism;
  CategoryProduct categoryProduct;
  Product product;
  List<PaymentMethod> paymentMethod;
  int quantity;
  double unitPrice;
  double price;
  double percentage;
  String status;

  ProductBuyModel({
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
    required this.status,
    required this.percentage,
  });

  factory ProductBuyModel.fromJson(Map<String, dynamic> json) =>
      ProductBuyModel(
        id: json["id"],
        publicationId: json["publicationId"],
        seller: Buyer.fromJson(json["seller"]),
        organism: Organism.fromJson(json["organism"]),
        categoryProduct: CategoryProduct.fromJson(json["categoryProduct"]),
        product: Product.fromJson(json["product"]),
        paymentMethod: List<PaymentMethod>.from(
            json["paymentMethod"].map((x) => PaymentMethod.fromJson(x))),
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
        percentage: json["percentage"],
        price: json["price"],
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

  Product({
    required this.id,
    required this.name,
    required this.code,
    required this.numberIdentification,
    required this.unit,
    required this.productImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        numberIdentification: json["numberIdentification"],
        unit: json["unit"],
        productImage: json["productImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "numberIdentification": numberIdentification,
        "unit": unit,
        "productImage": productImage,
      };
}
