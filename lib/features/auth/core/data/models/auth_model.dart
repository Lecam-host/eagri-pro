// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/auth_entity.dart';


AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel extends AuthEntity {
  const AuthModel({
    super.id,
    super.actions,
    super.parentId,
    super.organismTopParentId,
    super.accountId,
    super.organismId,
    super.itsHerFirstConnection,
    super.typeAccount,
    super.accessToken,
    super.refreshToken,
    super.subscriptionMessage,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["id"],
        actions: json["actions"],
        parentId: json["parent_id"],
        organismTopParentId: json["organism_top_parent_id"],
        accountId: json["account_id"],
        organismId: json["organism_id"] ?? 4,
        // json["organism_id"],
        itsHerFirstConnection: json["its_her_first_connection"],
        typeAccount: json["type_account"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        subscriptionMessage: json["subscription_message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "actions": actions,
        "parent_id": parentId,
        "organism_top_parent_id": organismTopParentId,
        "account_id": accountId,
        "organism_id": organismId ?? 4,
        "its_her_first_connection": itsHerFirstConnection,
        "type_account": typeAccount,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "subscription_message": subscriptionMessage,
      };
}
