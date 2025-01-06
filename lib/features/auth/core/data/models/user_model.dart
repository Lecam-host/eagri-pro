// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final User user;
  final DepartementUserModel region;
  final DepartementUserModel departement;
  final DepartementUserModel sousprefecture;
  final DepartementUserModel localite;

  UserModel({
    required this.user,
    required this.region,
    required this.departement,
    required this.sousprefecture,
    required this.localite,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json["user"]),
        region: DepartementUserModel.fromJson(json["region"]),
        departement: DepartementUserModel.fromJson(json["departement"]),
        sousprefecture: DepartementUserModel.fromJson(json["sousprefecture"]),
        localite: DepartementUserModel.fromJson(json["localite"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "region": region.toJson(),
        "departement": departement.toJson(),
        "sousprefecture": sousprefecture.toJson(),
        "localite": localite.toJson(),
      };
}

class DepartementUserModel {
  final int? id;
  final String name;

  DepartementUserModel({
    this.id,
    required this.name,
  });

  factory DepartementUserModel.fromJson(Map<String, dynamic> json) =>
      DepartementUserModel(
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
  String? typeUser;
  final String phone;
  final String avatar;
  final String address;
  final DateTime birthDate;
  final AccountUserModel account;
  final Organism organism;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.title,
    this.typeUser,
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
        account: AccountUserModel.fromJson(json["account"]),
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

class AccountUserModel {
  final DateTime createdAt;
  final bool deleted;
  final dynamic deletedAt;
  final dynamic updatedAt;
  final int id;
  final String username;
  final String phone;
  final dynamic name;
  final String typeAccount;
  final bool isEnabled;
  final List<dynamic> groups;
  final List<dynamic> registrationIds;
  final dynamic hasLoggedInOnce;
  final int itsHerFirstConnection;
  final dynamic firstLoginDate;
  final dynamic subscriptionEndDate;
  final dynamic subscriptionType;
  final bool enabled;
  final bool subscriptionValid;
  final bool freeTrialValid;
  final dynamic remainingDays;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;

  AccountUserModel({
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
    required this.registrationIds,
    required this.hasLoggedInOnce,
    required this.itsHerFirstConnection,
    required this.firstLoginDate,
    required this.subscriptionEndDate,
    required this.subscriptionType,
    required this.enabled,
    required this.subscriptionValid,
    required this.freeTrialValid,
    required this.remainingDays,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
  });

  factory AccountUserModel.fromJson(Map<String, dynamic> json) =>
      AccountUserModel(
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
        registrationIds:
            List<dynamic>.from(json["registrationIds"].map((x) => x)),
        hasLoggedInOnce: json["hasLoggedInOnce"],
        itsHerFirstConnection: json["itsHerFirstConnection"],
        firstLoginDate: json["firstLoginDate"],
        subscriptionEndDate: json["subscriptionEndDate"],
        subscriptionType: json["subscriptionType"],
        enabled: json["enabled"],
        subscriptionValid: json["subscriptionValid"],
        freeTrialValid: json["freeTrialValid"],
        remainingDays: json["remainingDays"],
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
        "registrationIds": List<dynamic>.from(registrationIds.map((x) => x)),
        "hasLoggedInOnce": hasLoggedInOnce,
        "itsHerFirstConnection": itsHerFirstConnection,
        "firstLoginDate": firstLoginDate,
        "subscriptionEndDate": subscriptionEndDate,
        "subscriptionType": subscriptionType,
        "enabled": enabled,
        "subscriptionValid": subscriptionValid,
        "freeTrialValid": freeTrialValid,
        "remainingDays": remainingDays,
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
  final int? paysId;
  final int? regionId;
  final int? departementId;
  final int? sousprefectureId;
  final int? localiteId;
  final String name;
  final String? sigle;
  final String? domaineActivite;
  final String email;
  final String username;
  final String phone;
  final String logoPath;
  final String address;
  final String typeOrganism;
  final dynamic typeBoutique;
  final dynamic parentId;
  final List<int> allParentIds;
  final int topParentId;

  Organism({
    required this.createdAt,
    required this.deleted,
    this.deletedAt,
    required this.updatedAt,
    required this.id,
    this.paysId,
    this.regionId,
    this.departementId,
    this.sousprefectureId,
    this.localiteId,
    required this.name,
    this.sigle,
    this.domaineActivite,
    required this.email,
    required this.username,
    required this.phone,
    required this.logoPath,
    required this.address,
    required this.typeOrganism,
    this.typeBoutique,
    required this.parentId,
    required this.allParentIds,
    required this.topParentId,
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
        allParentIds: List<int>.from(json["allParentIds"].map((x) => x)),
        topParentId: json["topParentId"],
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
        "allParentIds": List<dynamic>.from(allParentIds.map((x) => x)),
        "topParentId": topParentId,
      };
}
