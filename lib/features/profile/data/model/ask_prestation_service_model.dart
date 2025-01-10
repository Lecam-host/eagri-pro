// To parse this JSON data, do
//
//     final getPrestationServiceAskResponse = getPrestationServiceAskResponseFromJson(jsonString);

import 'dart:convert';

GetPrestationServiceAskResponse getPrestationServiceAskResponseFromJson(
        String str) =>
    GetPrestationServiceAskResponse.fromJson(json.decode(str));

String getPrestationServiceAskResponseToJson(
        GetPrestationServiceAskResponse data) =>
    json.encode(data.toJson());

class GetPrestationServiceAskResponse {
  int statusCode;
  String statusMessage;
  List<PrestationServiceAskModel> data;

  GetPrestationServiceAskResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory GetPrestationServiceAskResponse.fromJson(Map<String, dynamic> json) =>
      GetPrestationServiceAskResponse(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: List<PrestationServiceAskModel>.from(
            json["data"].map((x) => PrestationServiceAskModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PrestationServiceAskModel {
  int id;
  Service service;
  Inquirer inquirer;
  Inquirer receiver;
  int quantity;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  PrestationServiceAskModel({
    required this.id,
    required this.service,
    required this.inquirer,
    required this.receiver,
    required this.quantity,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory PrestationServiceAskModel.fromJson(Map<String, dynamic> json) =>
      PrestationServiceAskModel(
        id: json["id"],
        service: Service.fromJson(json["service"]),
        inquirer: Inquirer.fromJson(json["inquirer"]),
        receiver: Inquirer.fromJson(json["receiver"]),
        quantity: json["quantity"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service": service.toJson(),
        "inquirer": inquirer.toJson(),
        "receiver": receiver.toJson(),
        "quantity": quantity,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class Inquirer {
  String firstName;
  String lastName;
  String address;
  String phone;
  int id;
  String username;

  Inquirer({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phone,
    required this.id,
    required this.username,
  });

  factory Inquirer.fromJson(Map<String, dynamic> json) => Inquirer(
        firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"],
        phone: json["phone"],
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "phone": phone,
        "id": id,
        "username": username,
      };
}

class Service {
  Publication publication;
  Department region;
  Department department;
  Department subprefecture;
  Department locality;
  Product product;
  UserInfo userInfo;

  Service({
    required this.publication,
    required this.region,
    required this.department,
    required this.subprefecture,
    required this.locality,
    required this.product,
    required this.userInfo,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        publication: Publication.fromJson(json["publication"]),
        region: Department.fromJson(json["region"]),
        department: Department.fromJson(json["department"]),
        subprefecture: Department.fromJson(json["subprefecture"]),
        locality: Department.fromJson(json["locality"]),
        product: Product.fromJson(json["product"]),
        userInfo: UserInfo.fromJson(json["userInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "publication": publication.toJson(),
        "region": region.toJson(),
        "department": department.toJson(),
        "subprefecture": subprefecture.toJson(),
        "locality": locality.toJson(),
        "product": product.toJson(),
        "userInfo": userInfo.toJson(),
      };
}

class Department {
  int id;
  String name;

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

class Publication {
  int id;
  int organismId;
  dynamic subOrganismId;
  int userId;
  String numberIdentification;
  List<PaymentElement> payments;
  List<Image> images;
  double price;
  dynamic quantity;
  double note;
  dynamic longitude;
  dynamic latitude;
  List<Content> content;
  String description;
  int code;
  String? unitOfMeasure;
  dynamic typeOfSale;
  dynamic vehicleNumber;
  String availability;
  String typePublication;
  dynamic typeBoutique;
  dynamic availabilityDate;
  String statusPublication;
  DateTime expirationDate;
  String visibility;
  String typeCatalog;
  DateTime createdAt;

  Publication({
    required this.id,
    required this.organismId,
    required this.subOrganismId,
    required this.userId,
    required this.numberIdentification,
    required this.payments,
    required this.images,
    required this.price,
    required this.quantity,
    required this.note,
    required this.longitude,
    required this.latitude,
    required this.content,
    required this.description,
    required this.code,
    this.unitOfMeasure,
    required this.typeOfSale,
    required this.vehicleNumber,
    required this.availability,
    required this.typePublication,
    required this.typeBoutique,
    required this.availabilityDate,
    required this.statusPublication,
    required this.expirationDate,
    required this.visibility,
    required this.typeCatalog,
    required this.createdAt,
  });

  factory Publication.fromJson(Map<String, dynamic> json) => Publication(
        id: json["id"],
        organismId: json["organismId"],
        subOrganismId: json["subOrganismId"],
        userId: json["userId"],
        numberIdentification: json["number_identification"],
        payments: List<PaymentElement>.from(
            json["payments"].map((x) => PaymentElement.fromJson(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        price: json["price"],
        quantity: json["quantity"],
        note: json["note"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        description: json["description"],
        code: json["code"],
        unitOfMeasure: json["unitOfMeasure"],
        typeOfSale: json["typeOfSale"],
        vehicleNumber: json["vehicleNumber"],
        availability: json["availability"],
        typePublication: json["typePublication"],
        typeBoutique: json["typeBoutique"],
        availabilityDate: json["availabilityDate"],
        statusPublication: json["statusPublication"],
        expirationDate: DateTime.parse(json["expirationDate"]),
        visibility: json["visibility"],
        typeCatalog: json["typeCatalog"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "organismId": organismId,
        "subOrganismId": subOrganismId,
        "userId": userId,
        "number_identification": numberIdentification,
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "price": price,
        "quantity": quantity,
        "note": note,
        "longitude": longitude,
        "latitude": latitude,
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "description": description,
        "code": code,
        "unitOfMeasure": unitOfMeasure,
        "typeOfSale": typeOfSale,
        "vehicleNumber": vehicleNumber,
        "availability": availability,
        "typePublication": typePublication,
        "typeBoutique": typeBoutique,
        "availabilityDate": availabilityDate,
        "statusPublication": statusPublication,
        "expirationDate":
            "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
        "visibility": visibility,
        "typeCatalog": typeCatalog,
        "createdAt": createdAt.toIso8601String(),
      };
}

class Content {
  String name;
  String value;
  String? subLabel;

  Content({
    required this.name,
    required this.value,
    this.subLabel,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        name: json["name"],
        value: json["value"],
        subLabel: json["subLabel"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "subLabel": subLabel,
      };
}

class Image {
  DateTime createdAt;
  bool deleted;
  dynamic deletedAt;
  dynamic updatedAt;
  int id;
  String link;

  Image({
    required this.createdAt,
    required this.deleted,
    required this.deletedAt,
    required this.updatedAt,
    required this.id,
    required this.link,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        createdAt: DateTime.parse(json["createdAt"]),
        deleted: json["deleted"],
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "deleted": deleted,
        "deletedAt": deletedAt,
        "updatedAt": updatedAt,
        "id": id,
        "link": link,
      };
}

class PaymentElement {
  DateTime createdAt;
  bool deleted;
  dynamic deletedAt;
  dynamic updatedAt;
  int id;
  int paymentId;
  dynamic band;
  dynamic period;
  PaymentPayment payment;

  PaymentElement({
    required this.createdAt,
    required this.deleted,
    required this.deletedAt,
    required this.updatedAt,
    required this.id,
    required this.paymentId,
    required this.band,
    required this.period,
    required this.payment,
  });

  factory PaymentElement.fromJson(Map<String, dynamic> json) => PaymentElement(
        createdAt: DateTime.parse(json["createdAt"]),
        deleted: json["deleted"],
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        paymentId: json["paymentId"],
        band: json["band"],
        period: json["period"],
        payment: PaymentPayment.fromJson(json["payment"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "deleted": deleted,
        "deletedAt": deletedAt,
        "updatedAt": updatedAt,
        "id": id,
        "paymentId": paymentId,
        "band": band,
        "period": period,
        "payment": payment.toJson(),
      };
}

class PaymentPayment {
  int id;
  String name;
  String code;

  PaymentPayment({
    required this.id,
    required this.name,
    required this.code,
  });

  factory PaymentPayment.fromJson(Map<String, dynamic> json) => PaymentPayment(
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

class UserInfo {
  User user;
  dynamic organism;

  UserInfo({
    required this.user,
    required this.organism,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        user: User.fromJson(json["user"]),
        organism: json["organism"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "organism": organism,
      };
}

class User {
  String firstName;
  String lastName;
  String phone;
  Organism organism;

  User({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.organism,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        organism: Organism.fromJson(json["organism"]),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "organism": organism.toJson(),
      };
}

class Organism {
  String name;
  String email;
  String username;
  String phone;

  Organism({
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
  });

  factory Organism.fromJson(Map<String, dynamic> json) => Organism(
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "username": username,
        "phone": phone,
      };
}
