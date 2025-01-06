import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final int? id;
  final dynamic actions;
  final dynamic parentId;
  final int? organismTopParentId;
  final int? accountId;
  final int? organismId;
  final int? itsHerFirstConnection;
  final String? typeAccount;
  final String? accessToken;
  final String? refreshToken;
  final String? subscriptionMessage;

  const AuthEntity({
    this.id,
    this.actions,
    this.parentId,
    this.organismTopParentId,
    this.accountId,
    this.organismId,
    this.itsHerFirstConnection,
    this.typeAccount,
    this.accessToken,
    this.refreshToken,
    this.subscriptionMessage,
  });
   factory AuthEntity.fromJson(Map<String, dynamic> json) => AuthEntity(
        id: json["id"],
        actions: json["actions"],
        parentId: json["parent_id"],
        organismTopParentId: json["organism_top_parent_id"],
        accountId: json["account_id"],
        organismId: json["organism_id"],
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
        "organism_id": organismId,
        "its_her_first_connection": itsHerFirstConnection,
        "type_account": typeAccount,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "subscription_message": subscriptionMessage,
      };

  @override
  List<Object?> get props => [
        id,
        actions,
        parentId,
        organismTopParentId,
        accountId,
        organismId,
        itsHerFirstConnection,
        typeAccount,
        accessToken,
        refreshToken,
        subscriptionMessage
      ];
}
