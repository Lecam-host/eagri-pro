import 'package:dio/dio.dart';

class PaymentPublishProduct {
  final String? paymentId;

  PaymentPublishProduct({
    this.paymentId,
  });

  factory PaymentPublishProduct.fromJson(Map<String, dynamic> json) {
    return PaymentPublishProduct(
      paymentId: json['paymentId'],
    );
  }

  Map<String, dynamic> toJson() => {
        '"paymentId"': paymentId,
      };
}

class LocationPublishProduct {
  final int? regionId;
  final int? departmentId;
  final int? subPrefectureId;
  final int? localityId;

  LocationPublishProduct({
    this.regionId,
    this.departmentId,
    this.subPrefectureId,
    this.localityId,
  });

  factory LocationPublishProduct.fromJson(Map<String, dynamic> json) {
    return LocationPublishProduct(
      regionId: json['regionId'],
      departmentId: json['departmentId'],
      subPrefectureId: json['subPrefectureId'],
      localityId: json['localityId'],
    );
  }

  Map<String, dynamic> toJson() => {
        '"regionId"': regionId,
        '"departmentId"': departmentId,
        '"subPrefectureId"': subPrefectureId,
        '"localityId"': localityId,
      };
}

class PublishProductModel {
  final int? userId;
  final int? agentId;
  final int? productId;
  final List<PaymentPublishProduct>? payments;
  final LocationPublishProduct? localisation;
  final List<String> files;
  final List<MapEntry<String, dynamic>> data;

  PublishProductModel({
    this.userId,
    this.agentId,
    this.productId,
    this.payments,
    this.localisation,
    required this.files,
    required this.data,
  });

  factory PublishProductModel.fromJson(Map<String, dynamic> json) {
    return PublishProductModel(
      userId: json['userId'],
      agentId: json['agentId'],
      productId: json['productId'],
      payments: json['payments'] != null
          ? (json['payments'] as List)
              .map((e) => PaymentPublishProduct.fromJson(e))
              .toList()
          : null,
      localisation: json['localisation'] != null
          ? LocationPublishProduct.fromJson(json['localisation'])
          : null,
      files: (json['files'] as List).cast<String>(),
      data: (json['data'] as List).cast<MapEntry<String, String>>(),
    );
  }

  toJson() {
    final fileMultipart = files.isNotEmpty
        ? files.map((e) => MultipartFile.fromFileSync(e)).toList()
        : null;
    return {
      "userId": userId,
      "agentId": agentId,
      "productId": productId,
      "payments": payments?.map((e) => e.toJson()).toList().toString(),
      "localisation": localisation?.toJson().toString(),
      "files": fileMultipart,
      "longitude": "11",
      "latitude": "11",
      "origin": "MOB",
      "subOrganismId": "4",
      "data": data
          .map((e) => {
                '"name"': '"${e.key}"',
                '"value"': '"${e.value}"',
              })
          .toList()
          .toString(),
    };
  }
}
