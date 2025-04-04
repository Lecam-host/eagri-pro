// To parse this JSON data, do
//
//     final getKitCompositeDeliveryPlaceResponse = getKitCompositeDeliveryPlaceResponseFromJson(jsonString);

import 'dart:convert';

GetKitCompositeDeliveryPlaceResponse
    getKitCompositeDeliveryPlaceResponseFromJson(String str) =>
        GetKitCompositeDeliveryPlaceResponse.fromJson(json.decode(str));

String getKitCompositeDeliveryPlaceResponseToJson(
        GetKitCompositeDeliveryPlaceResponse data) =>
    json.encode(data.toJson());

class GetKitCompositeDeliveryPlaceResponse {
  int statusCode;
  String statusMessage;
  DeliveryPlaceResponseData data;

  GetKitCompositeDeliveryPlaceResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory GetKitCompositeDeliveryPlaceResponse.fromJson(
          Map<String, dynamic> json) =>
      GetKitCompositeDeliveryPlaceResponse(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: DeliveryPlaceResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data.toJson(),
      };
}

class DeliveryPlaceResponseData {
  int total;
  int totalOfPages;
  int perPage;
  List<String> sorts;
  String order;
  int currentPage;
  int nextPage;
  int previousPage;
  Filters filters;
  List<DeliveryPlaceModel> items;

  DeliveryPlaceResponseData({
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

  factory DeliveryPlaceResponseData.fromJson(Map<String, dynamic> json) =>
      DeliveryPlaceResponseData(
        total: json["total"],
        totalOfPages: json["total_of_pages"],
        perPage: json["per_page"],
        sorts: List<String>.from(json["sorts"].map((x) => x)),
        order: json["order"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        previousPage: json["previous_page"],
        filters: Filters.fromJson(json["filters"]),
        items: List<DeliveryPlaceModel>.from(
            json["items"].map((x) => DeliveryPlaceModel.fromJson(x))),
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
        "filters": filters.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Filters {
  String supplierId;

  Filters({
    required this.supplierId,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        supplierId: json["supplierId"],
      );

  Map<String, dynamic> toJson() => {
        "supplierId": supplierId,
      };
}

class DeliveryPlaceModel {
  int id;
  String region;
  String? department;
  String? subprefecture;
  String? locality;
  String? exactDescription;

  DeliveryPlaceModel({
    required this.id,
    required this.region,
    required this.department,
    required this.subprefecture,
    required this.locality,
    required this.exactDescription,
  });

  factory DeliveryPlaceModel.fromJson(Map<String, dynamic> json) =>
      DeliveryPlaceModel(
        id: json["id"],
        region: json["region"],
        department: json["department"],
        subprefecture: json["subprefecture"],
        locality: json["locality"],
        exactDescription: json["exactDescription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "region": region,
        "department": department,
        "subprefecture": subprefecture,
        "locality": locality,
        "exactDescription": exactDescription,
      };
}
