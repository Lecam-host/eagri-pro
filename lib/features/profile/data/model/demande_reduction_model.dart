import 'dart:convert';

GetListDemandeReductionResponse getListDemandeReductionResponseFromJson(
        String str) =>
    GetListDemandeReductionResponse.fromJson(json.decode(str));

String getListDemandeReductionResponseToJson(
        GetListDemandeReductionResponse data) =>
    json.encode(data.toJson());

class GetListDemandeReductionResponse {
  int statusCode;
  String statusMessage;
  Data data;

  GetListDemandeReductionResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory GetListDemandeReductionResponse.fromJson(Map<String, dynamic> json) =>
      GetListDemandeReductionResponse(
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
  List<DemandeReductionItem> items;

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
        items: List<DemandeReductionItem>.from(
            json["items"].map((x) => DemandeReductionItem.fromJson(x))),
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

class DemandeReductionItem {
  int id;
  int shoppingCartId;
  int publicationId;
  Buyer buyer;
  Buyer seller;
  Product product;
  int quantity;
  double newPrice;
  double sellerPrice;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  DemandeReductionItem({
    required this.id,
    required this.shoppingCartId,
    required this.publicationId,
    required this.buyer,
    required this.seller,
    required this.product,
    required this.quantity,
    required this.newPrice,
    required this.sellerPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DemandeReductionItem.fromJson(Map<String, dynamic> json) =>
      DemandeReductionItem(
        id: json["id"],
        shoppingCartId: json["shoppingCartId"],
        publicationId: json["publicationId"],
        buyer: Buyer.fromJson(json["buyer"]),
        seller: Buyer.fromJson(json["seller"]),
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        newPrice: json["newPrice"],
        sellerPrice: json["sellerPrice"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shoppingCartId": shoppingCartId,
        "publicationId": publicationId,
        "buyer": buyer.toJson(),
        "seller": seller.toJson(),
        "product": product.toJson(),
        "quantity": quantity,
        "newPrice": newPrice,
        "sellerPrice": sellerPrice,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
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

class Product {
  int id;
  String name;
  int code;
  String numberIdentification;
  String unit;
  double unitPrice;
  String productImage;
  dynamic createdAt;
  dynamic location;
  dynamic typeOfSale;

  Product({
    required this.id,
    required this.name,
    required this.code,
    required this.numberIdentification,
    required this.unit,
    required this.unitPrice,
    required this.productImage,
    required this.createdAt,
    required this.location,
    required this.typeOfSale,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        numberIdentification: json["numberIdentification"],
        unit: json["unit"],
        unitPrice: json["unitPrice"],
        productImage: json["productImage"],
        createdAt: json["createdAt"],
        location: json["location"],
        typeOfSale: json["typeOfSale"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "numberIdentification": numberIdentification,
        "unit": unit,
        "unitPrice": unitPrice,
        "productImage": productImage,
        "createdAt": createdAt,
        "location": location,
        "typeOfSale": typeOfSale,
      };
}
