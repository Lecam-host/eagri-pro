// To parse this JSON data, do
//
//     final resultProductSearchModel = resultProductSearchModelFromJson(jsonString);

import 'dart:convert';

ResultProductSearchModel resultProductSearchModelFromJson(String str) =>
    ResultProductSearchModel.fromJson(json.decode(str));

String resultProductSearchModelToJson(ResultProductSearchModel data) =>
    json.encode(data.toJson());

class ResultProductSearchModel {
  final int? id;
  final int? code;
  final String? name;
  final String? image;
  final double? priceMin;
  final int? validity;
  final String? description;
  final int? archiveId;
  final dynamic culture;
  final dynamic formData;
  final int? parentId;
  final dynamic children;
  final List<UnitOfMeasure>? unitOfMeasures;
  final DateTime? createdAt;

  ResultProductSearchModel({
    this.id,
    this.code,
    this.name,
    this.image,
    this.priceMin,
    this.validity,
    this.description,
    this.archiveId,
    this.culture,
    this.formData,
    this.parentId,
    this.children,
    this.unitOfMeasures,
    this.createdAt,
  });

  factory ResultProductSearchModel.fromJson(Map<String, dynamic> json) =>
      ResultProductSearchModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        image: json["image"],
        priceMin: json["priceMin"],
        validity: json["validity"],
        description: json["description"],
        archiveId: json["archiveId"],
        culture: json["culture"],
        formData: json["formData"],
        parentId: json["parentId"],
        children: json["children"],
        unitOfMeasures: json["unitOfMeasures"] == null
            ? []
            : List<UnitOfMeasure>.from(
                json["unitOfMeasures"]!.map((x) => UnitOfMeasure.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "image": image,
        "priceMin": priceMin,
        "validity": validity,
        "description": description,
        "archiveId": archiveId,
        "culture": culture,
        "formData": formData,
        "parentId": parentId,
        "children": children,
        "unitOfMeasures": unitOfMeasures == null
            ? []
            : List<dynamic>.from(unitOfMeasures!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
      };
}

class UnitOfMeasure {
  final int? id;
  final String? name;
  final String? unit;

  UnitOfMeasure({
    this.id,
    this.name,
    this.unit,
  });

  factory UnitOfMeasure.fromJson(Map<String, dynamic> json) => UnitOfMeasure(
        id: json["id"],
        name: json["name"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "unit": unit,
      };
}
