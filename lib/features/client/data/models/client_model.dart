// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'dart:convert';

ClientModel clientModelFromJson(String str) =>
    ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
  final User? user;
  final Departement? region;
  final Departement? departement;
  final Departement? sousprefecture;
  final Departement? localite;

  ClientModel({
    this.user,
    this.region,
    this.departement,
    this.sousprefecture,
    this.localite,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        region: json["region"] == null
            ? null
            : Departement.fromJson(json["region"]),
        departement: json["departement"] == null
            ? null
            : Departement.fromJson(json["departement"]),
        sousprefecture: json["sousprefecture"] == null
            ? null
            : Departement.fromJson(json["sousprefecture"]),
        localite: json["localite"] == null
            ? null
            : Departement.fromJson(json["localite"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "region": region?.toJson(),
        "departement": departement?.toJson(),
        "sousprefecture": sousprefecture?.toJson(),
        "localite": localite?.toJson(),
      };
}

class Departement {
  final int? id;
  final String? name;

  Departement({
    this.id,
    this.name,
  });

  factory Departement.fromJson(Map<String, dynamic> json) => Departement(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class User {
  final int? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? title;
  final String? typeUser;
  final String? phone;
  final String? avatar;
  final String? address;
  final DateTime? birthDate;
  final Account? account;
  final Type? type;

  User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.gender,
    this.title,
    this.typeUser,
    this.phone,
    this.avatar,
    this.address,
    this.birthDate,
    this.account,
    this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        title: json["title"],
        typeUser: json["typeUser"],
        phone: json["phone"],
        avatar: json["avatar"],
        address: json["address"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "title": title,
        "typeUser": typeUser,
        "phone": phone,
        "avatar": avatar,
        "address": address,
        "birthDate": birthDate?.toIso8601String(),
        "account": account?.toJson(),
        "type": type?.toJson(),
      };
}

class Account {
  final DateTime? createdAt;
  final bool? deleted;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final int? id;
  final String? username;
  final String? phone;
  final String? name;
  final Type? accountType;
  final bool? isEnabled;
  final List<Type>? profiles;
  final Organism? organism;
  final bool? hasLoggedInOnce;
  final int? itsHerFirstConnection;
  final DateTime? firstLoginDate;
  final DateTime? subscriptionEndDate;
  final String? subscriptionType;
  final bool? enabled;
  final bool? accountNonExpired;
  final bool? accountNonLocked;
  final bool? credentialsNonExpired;
  final bool? subscriptionValid;
  final bool? freeTrialValid;
  final int? remainingDays;

  Account({
    this.createdAt,
    this.deleted,
    this.deletedAt,
    this.updatedAt,
    this.id,
    this.username,
    this.phone,
    this.name,
    this.accountType,
    this.isEnabled,
    this.profiles,
    this.organism,
    this.hasLoggedInOnce,
    this.itsHerFirstConnection,
    this.firstLoginDate,
    this.subscriptionEndDate,
    this.subscriptionType,
    this.enabled,
    this.accountNonExpired,
    this.accountNonLocked,
    this.credentialsNonExpired,
    this.subscriptionValid,
    this.freeTrialValid,
    this.remainingDays,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deleted: json["deleted"],
        deletedAt: json["deletedAt"] == null
            ? null
            : DateTime.parse(json["deletedAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        id: json["id"],
        username: json["username"],
        phone: json["phone"],
        name: json["name"],
        accountType: json["accountType"] == null
            ? null
            : Type.fromJson(json["accountType"]),
        isEnabled: json["isEnabled"],
        profiles: json["profiles"] == null
            ? []
            : List<Type>.from(json["profiles"]!.map((x) => Type.fromJson(x))),
        organism: json["organism"] == null
            ? null
            : Organism.fromJson(json["organism"]),
        hasLoggedInOnce: json["hasLoggedInOnce"],
        itsHerFirstConnection: json["itsHerFirstConnection"],
        firstLoginDate: json["firstLoginDate"] == null
            ? null
            : DateTime.parse(json["firstLoginDate"]),
        subscriptionEndDate: json["subscriptionEndDate"] == null
            ? null
            : DateTime.parse(json["subscriptionEndDate"]),
        subscriptionType: json["subscriptionType"],
        enabled: json["enabled"],
        accountNonExpired: json["accountNonExpired"],
        accountNonLocked: json["accountNonLocked"],
        credentialsNonExpired: json["credentialsNonExpired"],
        subscriptionValid: json["subscriptionValid"],
        freeTrialValid: json["freeTrialValid"],
        remainingDays: json["remainingDays"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "deleted": deleted,
        "deletedAt": deletedAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
        "username": username,
        "phone": phone,
        "name": name,
        "accountType": accountType?.toJson(),
        "isEnabled": isEnabled,
        "profiles": profiles == null
            ? []
            : List<dynamic>.from(profiles!.map((x) => x.toJson())),
        "organism": organism?.toJson(),
        "hasLoggedInOnce": hasLoggedInOnce,
        "itsHerFirstConnection": itsHerFirstConnection,
        "firstLoginDate": firstLoginDate?.toIso8601String(),
        "subscriptionEndDate": subscriptionEndDate?.toIso8601String(),
        "subscriptionType": subscriptionType,
        "enabled": enabled,
        "accountNonExpired": accountNonExpired,
        "accountNonLocked": accountNonLocked,
        "credentialsNonExpired": credentialsNonExpired,
        "subscriptionValid": subscriptionValid,
        "freeTrialValid": freeTrialValid,
        "remainingDays": remainingDays,
      };
}

class Type {
  final DateTime? createdAt;
  final bool? deleted;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final int? id;
  final String? name;
  final String? description;
  final String? referredType;
  final bool? isActive;
  final List<dynamic>? permissions;
  final String? slug;
  final Type? service;

  Type({
    this.createdAt,
    this.deleted,
    this.deletedAt,
    this.updatedAt,
    this.id,
    this.name,
    this.description,
    this.referredType,
    this.isActive,
    this.permissions,
    this.slug,
    this.service,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deleted: json["deleted"],
        deletedAt: json["deletedAt"] == null
            ? null
            : DateTime.parse(json["deletedAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        id: json["id"],
        name: json["name"],
        description: json["description"],
        referredType: json["referredType"],
        isActive: json["isActive"],
        permissions: json["permissions"] == null
            ? []
            : List<dynamic>.from(json["permissions"]!.map((x) => x)),
        slug: json["slug"],
        service:
            json["service"] == null ? null : Type.fromJson(json["service"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "deleted": deleted,
        "deletedAt": deletedAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
        "name": name,
        "description": description,
        "referredType": referredType,
        "isActive": isActive,
        "permissions": permissions == null
            ? []
            : List<dynamic>.from(permissions!.map((x) => x)),
        "slug": slug,
        "service": service?.toJson(),
      };
}

class Organism {
  final DateTime? createdAt;
  final bool? deleted;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final int? id;
  final int? paysId;
  final int? regionId;
  final int? departementId;
  final int? sousprefectureId;
  final int? localiteId;
  final String? name;
  final String? sigle;
  final String? domaineActivite;
  final String? email;
  final String? username;
  final String? phone;
  final String? logoPath;
  final String? address;
  final Type? type;
  final int? parentId;
  final int? topParentId;
  final List<int>? allParentIds;

  Organism({
    this.createdAt,
    this.deleted,
    this.deletedAt,
    this.updatedAt,
    this.id,
    this.paysId,
    this.regionId,
    this.departementId,
    this.sousprefectureId,
    this.localiteId,
    this.name,
    this.sigle,
    this.domaineActivite,
    this.email,
    this.username,
    this.phone,
    this.logoPath,
    this.address,
    this.type,
    this.parentId,
    this.topParentId,
    this.allParentIds,
  });

  factory Organism.fromJson(Map<String, dynamic> json) => Organism(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deleted: json["deleted"],
        deletedAt: json["deletedAt"] == null
            ? null
            : DateTime.parse(json["deletedAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        id: json["id"],
        paysId: json["paysId"],
        regionId: json["regionId"],
        departementId: json["departementId"],
        sousprefectureId: json["sousprefectureId"],
        localiteId: json["localiteId"],
        name: json["name"],
        sigle: json["sigle"],
        domaineActivite: json["domaineActivite"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        logoPath: json["logoPath"],
        address: json["address"],
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        parentId: json["parentId"],
        topParentId: json["topParentId"],
        allParentIds: json["allParentIds"] == null
            ? []
            : List<int>.from(json["allParentIds"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "deleted": deleted,
        "deletedAt": deletedAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
        "paysId": paysId,
        "regionId": regionId,
        "departementId": departementId,
        "sousprefectureId": sousprefectureId,
        "localiteId": localiteId,
        "name": name,
        "sigle": sigle,
        "domaineActivite": domaineActivite,
        "email": email,
        "username": username,
        "phone": phone,
        "logoPath": logoPath,
        "address": address,
        "type": type?.toJson(),
        "parentId": parentId,
        "topParentId": topParentId,
        "allParentIds": allParentIds == null
            ? []
            : List<dynamic>.from(allParentIds!.map((x) => x)),
      };
}
