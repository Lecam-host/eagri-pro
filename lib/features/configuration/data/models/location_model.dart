// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  int? statusCode;
  String? statusMessage;
  DataLocationModel? data;

  LocationModel({
    this.statusCode,
    this.statusMessage,
    required this.data,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] != null
            ? DataLocationModel.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data!.toJson(),
      };
}

class DataLocationModel {
  int id;
  int entityId;
  dynamic entity;
  int countryId;
  Country? country;
  List<Location> location;

  DataLocationModel({
    required this.id,
    required this.entityId,
    required this.entity,
    required this.countryId,
    required this.country,
    required this.location,
  });

  factory DataLocationModel.fromJson(Map<String, dynamic> json) =>
      DataLocationModel(
        id: json["id"],
        entityId: json["entityId"],
        entity: json["entity"],
        countryId: json["countryId"],
        country:
            json["country"] != null ? Country.fromJson(json["country"]) : null,
        location: List<Location>.from(
            json["location"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entityId": entityId,
        "entity": entity,
        "countryId": countryId,
        "country": country!.toJson(),
        "location": List<dynamic>.from(location.map((x) => x.toJson())),
      };
}

class Country {
  int id;
  String name;

  Country({
    required this.id,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Location {
  int regionId;
  Country region;
  List<AddDepartmentList> addDepartmentList;

  Location({
    required this.regionId,
    required this.region,
    required this.addDepartmentList,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        regionId: json["regionId"],
        region: Country.fromJson(json["region"]),
        addDepartmentList: json["addDepartmentList"] == null
            ? []
            : List<AddDepartmentList>.from(json["addDepartmentList"]
                .map((x) => AddDepartmentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "regionId": regionId,
        "region": region.toJson(),
        "addDepartmentList": addDepartmentList == null
            ? []
            : List<dynamic>.from(addDepartmentList!.map((x) => x.toJson())),
      };
}

class AddDepartmentList {
  int departmentId;
  Country? departement;
  List<AddSubPrefectureList>? addSubPrefectureList;

  AddDepartmentList({
    required this.departmentId,
    this.departement,
    this.addSubPrefectureList,
  });

  factory AddDepartmentList.fromJson(Map<String, dynamic> json) =>
      AddDepartmentList(
        departmentId: json["departmentId"],
        departement: json["departement"] != null
            ? Country.fromJson(json["departement"])
            : null,
        addSubPrefectureList: json["addSubPrefectureList"] != null
            ? List<AddSubPrefectureList>.from(json["addSubPrefectureList"]
                .map((x) => AddSubPrefectureList.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "departmentId": departmentId,
        "departement": departement?.toJson(),
        "addSubPrefectureList": addSubPrefectureList != null
            ? List<dynamic>.from(addSubPrefectureList!.map((x) => x.toJson()))
            : null,
      };
}

class AddSubPrefectureList {
  int subPrefectureId;
  Country? subPrefecture;
  List<AddLocalityList>? addLocalityList;

  AddSubPrefectureList({
    required this.subPrefectureId,
    this.subPrefecture,
    this.addLocalityList,
  });

  factory AddSubPrefectureList.fromJson(Map<String, dynamic> json) =>
      AddSubPrefectureList(
        subPrefectureId: json["subPrefectureId"],
        subPrefecture: json["subPrefecture"] != null
            ? Country.fromJson(json["subPrefecture"])
            : null,
        addLocalityList: json["addLocalityList"] != null
            ? List<AddLocalityList>.from(
                json["addLocalityList"].map((x) => AddLocalityList.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "subPrefectureId": subPrefectureId,
        "subPrefecture": subPrefecture?.toJson(),
        "addLocalityList": addLocalityList != null
            ? List<dynamic>.from(addLocalityList!.map((x) => x.toJson()))
            : null,
      };
}

class AddLocalityList {
  int localityId;
  Country locality;

  AddLocalityList({
    required this.localityId,
    required this.locality,
  });

  factory AddLocalityList.fromJson(Map<String, dynamic> json) =>
      AddLocalityList(
        localityId: json["localityId"],
        locality: Country.fromJson(json["locality"]),
      );

  Map<String, dynamic> toJson() => {
        "localityId": localityId,
        "locality": locality.toJson(),
      };
}


class RegionModel {
  int id;
  String name;

  RegionModel({
    required this.id,
    required this.name,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}


class DepartementModel {
  int id;
  String name;

  DepartementModel({
    required this.id,
    required this.name,
  });

  factory DepartementModel.fromJson(Map<String, dynamic> json) =>
      DepartementModel(
        id: json["departementId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "departementId": id,
        "name": name,
      };
}


class SpModel {
  int id;
  String name;

  SpModel({
    required this.id,
    required this.name,
  });

  factory SpModel.fromJson(Map<String, dynamic> json) => SpModel(
        id: json["sousPrefectureId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "sousPrefectureId": id,
        "name": name,
      };
}

class LocaliteModel {
  int id;
  String name;

  LocaliteModel({
    required this.id,
    required this.name,
  });

  factory LocaliteModel.fromJson(Map<String, dynamic> json) => LocaliteModel(
        id: json["localiteId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "LocaliteId": id,
        "localiteId": name,
      };
}
