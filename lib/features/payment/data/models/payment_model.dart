// To parse this JSON data, do
//
//     final getListPaymentMethodResponse = getListPaymentMethodResponseFromJson(jsonString);

import 'dart:convert';

import '../../../../core/utils/enum.dart';

GetListPaymentMethodResponse getListPaymentMethodResponseFromJson(String str) =>
    GetListPaymentMethodResponse.fromJson(json.decode(str));

String getListPaymentMethodResponseToJson(GetListPaymentMethodResponse data) =>
    json.encode(data.toJson());

class GetListPaymentMethodResponse {
  int statusCode;
  String statusMessage;
  List<PaymentMethodModel> data;

  GetListPaymentMethodResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory GetListPaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      GetListPaymentMethodResponse(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: List<PaymentMethodModel>.from(
            json["data"].map((x) => PaymentMethodModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PaymentMethodModel {
  int? methodId;
  int? organismId;
  double? rate;
  PaymentOptionModel? paymentMethod;
  String? name;
  String? code;

  PaymentMethodModel({
    this.methodId,
    this.code,
    this.name,
    this.rate,
    this.organismId,
    this.paymentMethod,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        rate: json["rate"],
        code: json["code"],
        methodId: json["id"],
        organismId: json["organismId"],
        name: json["name"],
        paymentMethod: json["paymentMethod"] != null
            ? PaymentOptionModel.fromJson(json["paymentMethod"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "methodId": methodId,
        "organismId": organismId,
        "paymentMethod": paymentMethod!.toJson(),
      };
}

class PaymentOptionModel {
  int id;
  String name;
  String code;
  double? rate;
  String description;
  bool? isEnable;

  String? image;
  String? instructions;
  List<PaymentOptionModel>? paymentOptions;

  PaymentOptionModel({
    required this.id,
    required this.name,
    required this.code,
    this.image,
    this.isEnable,
    this.instructions,
    this.rate,
    required this.description,
    this.paymentOptions,
  });

  factory PaymentOptionModel.fromJson(Map<String, dynamic> json) =>
      PaymentOptionModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        isEnable: json["isEnable"],
        instructions: json["instructions"],
        code: json["code"],
        rate: json["rate"]?.toDouble(),
        description: json["description"],
        paymentOptions: json["paymentOptions"] == null
            ? []
            : List<PaymentOptionModel>.from(json["paymentOptions"]!
                .map((x) => PaymentOptionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "rate": rate,
        "description": description,
        "paymentOptions": paymentOptions == null
            ? []
            : List<dynamic>.from(paymentOptions!.map((x) => x.toJson())),
      };
}

// To parse this JSON data, do
//
//     final createPaymentResponse = createPaymentResponseFromJson(jsonString);

CreatePaymentResponse createPaymentResponseFromJson(String str) =>
    CreatePaymentResponse.fromJson(json.decode(str));

String createPaymentResponseToJson(CreatePaymentResponse data) =>
    json.encode(data.toJson());

class CreatePaymentResponse {
  int statusCode;
  String statusMessage;
  Data? data;

  CreatePaymentResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory CreatePaymentResponse.fromJson(Map<String, dynamic> json) =>
      CreatePaymentResponse(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data!.toJson(),
      };
}

class Data {
  DateTime? paymentDate;
  String? paymentTime;
  String? paymentCode;
  String? paymentMessage;
  String? paymentTransactionId;
  PaymentNotificationStatus? paymentStatus;
  String? paymentMethod;
  String? phoneNumber;
  String? comment;
  String? type;
  String? paymentOperatorId;
  String? metadata;
  dynamic image;
  dynamic payUrl;
  dynamic redirectionData;

  Data({
    this.paymentDate,
    this.paymentTime,
    this.paymentCode,
    this.paymentMessage,
    this.paymentTransactionId,
    this.paymentMethod,
    this.phoneNumber,
    this.comment,
    this.type,
    this.paymentOperatorId,
    this.metadata,
    this.image,
    this.payUrl,
    this.paymentStatus,
    this.redirectionData,
  });
  static PaymentStatus? _parsePaymentMessage(String? value) {
    if (value == null) return null;
    return PaymentStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PaymentStatus.OTHER,
    );
  }

  static PaymentNotificationStatus? _parsePaymentStatus(String? value) {
    if (value == null) return null;
    return PaymentNotificationStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PaymentNotificationStatus.OTHER,
    );
  }

  // Méthode pour convertir un enum en chaîne
  static String? _paymentMessageToString(PaymentStatus? value) {
    return value?.name;
  }

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        // paymentDate: json["paymentDate"] == null
        //     ? null
        //     : DateTime.parse(json["paymentDate"]),
        paymentTime: json["paymentTime"],
        paymentCode: json["paymentCode"],
        paymentMessage: json["paymentMessage"],
        paymentStatus: _parsePaymentStatus(json["paymentStatus"]),
        paymentTransactionId: json["paymentTransactionId"],
        paymentMethod: json["paymentMethod"],
        phoneNumber: json["phoneNumber"],
        comment: json["comment"],
        type: json["type"],
        paymentOperatorId: json["paymentOperatorId"],
        metadata: json["metadata"],
        image: json["image"],
        payUrl: json["payUrl"],
        redirectionData: json["redirectionData"],
      );

  Map<String, dynamic> toJson() => {
        "paymentDate":
            "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "paymentTime": paymentTime,
        "paymentCode": paymentCode,
        "paymentMessage": paymentMessage,
        //"paymentStatus": _parsePaymentStatus(paymentStatus),
        "paymentTransactionId": paymentTransactionId,
        "paymentMethod": paymentMethod,
        "phoneNumber": phoneNumber,
        "comment": comment,
        "type": type,
        "paymentOperatorId": paymentOperatorId,
        "metadata": metadata,
        "image": image,
        "payUrl": payUrl,
        "redirectionData": redirectionData,
      };
}

// To parse this JSON data, do
//
//     final verifyPaymentResponse = verifyPaymentResponseFromJson(jsonString);

VerifyPaymentResponse verifyPaymentResponseFromJson(String str) =>
    VerifyPaymentResponse.fromJson(json.decode(str));

String verifyPaymentResponseToJson(VerifyPaymentResponse data) =>
    json.encode(data.toJson());

class VerifyPaymentResponse {
  int statusCode;
  String statusMessage;
  VerifyPaymentData? data;

  VerifyPaymentResponse({
    required this.statusCode,
    required this.statusMessage,
    this.data,
  });

  factory VerifyPaymentResponse.fromJson(Map<String, dynamic> json) =>
      VerifyPaymentResponse(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: VerifyPaymentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data!.toJson(),
      };
}

class VerifyPaymentData {
  String message;
  String status;
  String? invoiceUrl;

  VerifyPaymentData({
    required this.message,
    required this.status,
    this.invoiceUrl,
  });

  factory VerifyPaymentData.fromJson(Map<String, dynamic> json) =>
      VerifyPaymentData(
        message: json["message"],
        status: json["status"],
        invoiceUrl: json["invoiceUrl"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "invoiceUrl": invoiceUrl,
      };
}

// To parse this JSON data, do
//
//     final confirmPaymentWithOtpResponse = confirmPaymentWithOtpResponseFromJson(jsonString);

ConfirmPaymentWithOtpResponse confirmPaymentWithOtpResponseFromJson(
        String str) =>
    ConfirmPaymentWithOtpResponse.fromJson(json.decode(str));

String confirmPaymentWithOtpResponseToJson(
        ConfirmPaymentWithOtpResponse data) =>
    json.encode(data.toJson());

class ConfirmPaymentWithOtpResponse {
  int statusCode;
  String statusMessage;
  ConfirmPaymentWithOtp data;

  ConfirmPaymentWithOtpResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory ConfirmPaymentWithOtpResponse.fromJson(Map<String, dynamic> json) =>
      ConfirmPaymentWithOtpResponse(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: ConfirmPaymentWithOtp.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data.toJson(),
      };
}

class ConfirmPaymentWithOtp {
  String message;
  String signature;

  ConfirmPaymentWithOtp({
    required this.message,
    required this.signature,
  });

  factory ConfirmPaymentWithOtp.fromJson(Map<String, dynamic> json) =>
      ConfirmPaymentWithOtp(
        message: json["message"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "signature": signature,
      };
}
// To parse this JSON data, do
//
//     final listOptionPaymentResponse = listOptionPaymentResponseFromJson(jsonString);

ListOptionPaymentResponse listOptionPaymentResponseFromJson(String str) =>
    ListOptionPaymentResponse.fromJson(json.decode(str));

String listOptionPaymentResponseToJson(ListOptionPaymentResponse data) =>
    json.encode(data.toJson());

class ListOptionPaymentResponse {
  int statusCode;
  String statusMessage;
  List<OptionPayementModel> data;

  ListOptionPaymentResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory ListOptionPaymentResponse.fromJson(Map<String, dynamic> json) =>
      ListOptionPaymentResponse(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: List<OptionPayementModel>.from(
            json["data"].map((x) => OptionPayementModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OptionPayementModel {
  DateTime createdAt;
  bool deleted;
  dynamic deletedAt;
  DateTime? updatedAt;
  int id;
  String name;
  String image;
  String code;
  String description;
  dynamic isEnable;

  OptionPayementModel({
    required this.createdAt,
    required this.deleted,
    required this.deletedAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.image,
    required this.code,
    required this.description,
    required this.isEnable,
  });

  factory OptionPayementModel.fromJson(Map<String, dynamic> json) =>
      OptionPayementModel(
        createdAt: DateTime.parse(json["createdAt"]),
        deleted: json["deleted"],
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        id: json["id"],
        name: json["name"],
        image: json["image"],
        code: json["code"],
        description: json["description"],
        isEnable: json["isEnable"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "deleted": deleted,
        "deletedAt": deletedAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
        "name": name,
        "image": image,
        "code": code,
        "description": description,
        "isEnable": isEnable,
      };
}
