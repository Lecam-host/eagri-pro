// To parse this JSON data, do
//
//     final getSearchNotiationResponse = getSearchNotiationResponseFromJson(jsonString);

import 'dart:convert';

GetSearchNotationResponse getSearchNotiationResponseFromJson(String str) =>
    GetSearchNotationResponse.fromJson(json.decode(str));

String getSearchNotiationResponseToJson(GetSearchNotationResponse data) =>
    json.encode(data.toJson());

class GetSearchNotationResponse {
  int statusCode;
  String statusMessage;
  DataSearchNotationModel data;

  GetSearchNotationResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory GetSearchNotationResponse.fromJson(Map<String, dynamic> json) =>
      GetSearchNotationResponse(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: DataSearchNotationModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data.toJson(),
      };
}

class DataSearchNotationModel {
  int total;
  int totalOfPages;
  int perPage;
  dynamic sorts;
  dynamic order;
  int currentPage;
  int nextPage;
  int previousPage;
  dynamic filters;
  List<ItemSearchNotationModel> items;

  DataSearchNotationModel({
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

  factory DataSearchNotationModel.fromJson(Map<String, dynamic> json) =>
      DataSearchNotationModel(
        total: json["total"],
        totalOfPages: json["total_of_pages"],
        perPage: json["per_page"],
        sorts: json["sorts"],
        order: json["order"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        previousPage: json["previous_page"],
        filters: json["filters"],
        items: List<ItemSearchNotationModel>.from(
            json["items"].map((x) => ItemSearchNotationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "total_of_pages": totalOfPages,
        "per_page": perPage,
        "sorts": sorts,
        "order": order,
        "current_page": currentPage,
        "next_page": nextPage,
        "previous_page": previousPage,
        "filters": filters,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class ItemSearchNotationModel {
  DateTime createdAt;
  int id;
  int userId;
  int organismId;
  int subOrganismId;
  int ratingBy;
  RatingDetails ratingDetails;
  int resource;
  double rating;
  String? comment;
  int code;

  ItemSearchNotationModel({
    required this.createdAt,
    required this.id,
    required this.userId,
    required this.organismId,
    required this.subOrganismId,
    required this.ratingBy,
    required this.ratingDetails,
    required this.resource,
    required this.rating,
    this.comment,
    required this.code,
  });

  factory ItemSearchNotationModel.fromJson(Map<String, dynamic> json) =>
      ItemSearchNotationModel(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        userId: json["userId"],
        organismId: json["organismId"],
        subOrganismId: json["subOrganismId"],
        ratingBy: json["ratingBy"],
        ratingDetails: RatingDetails.fromJson(json["ratingDetails"]),
        resource: json["resource"],
        rating: json["rating"],
        comment: json["comment"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "userId": userId,
        "organismId": organismId,
        "subOrganismId": subOrganismId,
        "ratingBy": ratingBy,
        "ratingDetails": ratingDetails.toJson(),
        "resource": resource,
        "rating": rating,
        "comment": comment,
        "code": code,
      };
}

class RatingDetails {
  User user;
  dynamic organism;

  RatingDetails({
    required this.user,
    required this.organism,
  });

  factory RatingDetails.fromJson(Map<String, dynamic> json) => RatingDetails(
        user: User.fromJson(json["user"]),
        organism: json["organism"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "organism": organism,
      };
}

class User {
  int id;
  String firstName;
  String lastName;
  String phone;
  String avatar;
  Organism organism;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.avatar,
    required this.organism,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        avatar: json["avatar"],
        organism: Organism.fromJson(json["organism"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "avatar": avatar,
        "organism": organism.toJson(),
      };
}

class Organism {
  int id;
  String name;
  String email;
  String username;
  String phone;
  String logoPath;

  Organism({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.logoPath,
  });

  factory Organism.fromJson(Map<String, dynamic> json) => Organism(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        logoPath: json["logoPath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "phone": phone,
        "logoPath": logoPath,
      };
}
