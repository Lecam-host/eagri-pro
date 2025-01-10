// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:eagri_pro/features/auth/domain/entities/user_entity.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends UserEntity {
  const UserModel({
    required super.user,
    required super.region,
    required super.departement,
    required super.sousprefecture,
    required super.localite,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json["user"]),
        region: Location.fromJson(json["region"]),
        departement: Location.fromJson(json["departement"]),
        sousprefecture: Location.fromJson(json["sousprefecture"]),
        localite: Location.fromJson(json["localite"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "region": region.toJson(),
        "departement": departement.toJson(),
        "sousprefecture": sousprefecture.toJson(),
        "localite": localite.toJson(),
      };
}

class Location {
  final int? id;
  final String name;

  Location({
    required this.id,
    required this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  final String title;
  final String typeUser;
  final String phone;
  final String avatar;
  final String address;
  final DateTime birthDate;
  final Account account;
  final Organism organism;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.title,
    required this.typeUser,
    required this.phone,
    required this.avatar,
    required this.address,
    required this.birthDate,
    required this.account,
    required this.organism,
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
        birthDate: DateTime.parse(json["birthDate"]),
        account: Account.fromJson(json["account"]),
        organism: Organism.fromJson(json["organism"]),
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
        "birthDate": birthDate.toIso8601String(),
        "account": account.toJson(),
        "organism": organism.toJson(),
      };
}

class Account {
  final DateTime createdAt;
  final bool deleted;
  final dynamic deletedAt;
  final dynamic updatedAt;
  final int id;
  final String username;
  final String phone;
  final String name;
  final String typeAccount;
  final bool isEnabled;
  final List<dynamic> groups;
  final bool hasLoggedInOnce;
  final int itsHerFirstConnection;
  final DateTime firstLoginDate;
  final DateTime subscriptionEndDate;
  final String subscriptionType;
  final bool enabled;
  final int remainingDays;
  final bool freeTrialValid;
  final bool subscriptionValid;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;

  Account({
    required this.createdAt,
    required this.deleted,
    required this.deletedAt,
    required this.updatedAt,
    required this.id,
    required this.username,
    required this.phone,
    required this.name,
    required this.typeAccount,
    required this.isEnabled,
    required this.groups,
    required this.hasLoggedInOnce,
    required this.itsHerFirstConnection,
    required this.firstLoginDate,
    required this.subscriptionEndDate,
    required this.subscriptionType,
    required this.enabled,
    required this.remainingDays,
    required this.freeTrialValid,
    required this.subscriptionValid,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        createdAt: DateTime.parse(json["createdAt"]),
        deleted: json["deleted"],
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        username: json["username"],
        phone: json["phone"],
        name: json["name"],
        typeAccount: json["typeAccount"],
        isEnabled: json["isEnabled"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        hasLoggedInOnce: json["hasLoggedInOnce"],
        itsHerFirstConnection: json["itsHerFirstConnection"],
        firstLoginDate: DateTime.parse(json["firstLoginDate"]),
        subscriptionEndDate: DateTime.parse(json["subscriptionEndDate"]),
        subscriptionType: json["subscriptionType"],
        enabled: json["enabled"],
        remainingDays: json["remainingDays"],
        freeTrialValid: json["freeTrialValid"],
        subscriptionValid: json["subscriptionValid"],
        accountNonExpired: json["accountNonExpired"],
        accountNonLocked: json["accountNonLocked"],
        credentialsNonExpired: json["credentialsNonExpired"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "deleted": deleted,
        "deletedAt": deletedAt,
        "updatedAt": updatedAt,
        "id": id,
        "username": username,
        "phone": phone,
        "name": name,
        "typeAccount": typeAccount,
        "isEnabled": isEnabled,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "hasLoggedInOnce": hasLoggedInOnce,
        "itsHerFirstConnection": itsHerFirstConnection,
        "firstLoginDate": firstLoginDate.toIso8601String(),
        "subscriptionEndDate": subscriptionEndDate.toIso8601String(),
        "subscriptionType": subscriptionType,
        "enabled": enabled,
        "remainingDays": remainingDays,
        "freeTrialValid": freeTrialValid,
        "subscriptionValid": subscriptionValid,
        "accountNonExpired": accountNonExpired,
        "accountNonLocked": accountNonLocked,
        "credentialsNonExpired": credentialsNonExpired,
      };
}

class Organism {
  final DateTime createdAt;
  final bool deleted;
  final dynamic deletedAt;
  final dynamic updatedAt;
  final int id;
  final int paysId;
  final dynamic regionId;
  final dynamic departementId;
  final dynamic sousprefectureId;
  final dynamic localiteId;
  final String name;
  final String sigle;
  final String domaineActivite;
  final String email;
  final String username;
  final String phone;
  final String logoPath;
  final String address;
  final String typeOrganism;
  final dynamic typeBoutique;
  final dynamic parentId;
  final int topParentId;
  final List<int> allParentIds;

  Organism({
    required this.createdAt,
    required this.deleted,
    required this.deletedAt,
    required this.updatedAt,
    required this.id,
    required this.paysId,
    required this.regionId,
    required this.departementId,
    required this.sousprefectureId,
    required this.localiteId,
    required this.name,
    required this.sigle,
    required this.domaineActivite,
    required this.email,
    required this.username,
    required this.phone,
    required this.logoPath,
    required this.address,
    required this.typeOrganism,
    required this.typeBoutique,
    required this.parentId,
    required this.topParentId,
    required this.allParentIds,
  });

  factory Organism.fromJson(Map<String, dynamic> json) => Organism(
        createdAt: DateTime.parse(json["createdAt"]),
        deleted: json["deleted"],
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"],
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
        typeOrganism: json["typeOrganism"],
        typeBoutique: json["typeBoutique"],
        parentId: json["parentId"],
        topParentId: json["topParentId"],
        allParentIds: List<int>.from(json["allParentIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "deleted": deleted,
        "deletedAt": deletedAt,
        "updatedAt": updatedAt,
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
        "typeOrganism": typeOrganism,
        "typeBoutique": typeBoutique,
        "parentId": parentId,
        "topParentId": topParentId,
        "allParentIds": List<dynamic>.from(allParentIds.map((x) => x)),
      };
}
