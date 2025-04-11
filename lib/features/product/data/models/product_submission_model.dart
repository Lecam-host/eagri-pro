import 'dart:io';

import 'package:dio/dio.dart' as dio;

import 'payment_method_model.dart';

class ProductSubmission {
  final int productId;
  final int subOrganismId;
  final int userId;
  final String? phone;
  final String unitOfMeasure;
  final List<Map<String, String>> formData;
  final List<String?> imagePaths;
  final List<PaymentMethod> paymentMethods;
  final int regionId;
  final int? departmentId;
  final int? subPrefectureId;
  final int? localityId;

  ProductSubmission({
    required this.productId,
    required this.subOrganismId,
    required this.userId,
    required this.unitOfMeasure,
    required this.formData,
    required this.imagePaths,
    required this.paymentMethods,
    required this.regionId,
    this.phone,
    this.departmentId,
    this.subPrefectureId,
    this.localityId,
  });

  dio.FormData toFormData() {
    final formDataInstance = dio.FormData();

    final fields = <MapEntry<String, String>>[
      MapEntry("subOrganismId", subOrganismId.toString()),
      MapEntry("productId", productId.toString()),
      MapEntry("userId", userId.toString()),
      MapEntry("longitude", "11"),
      MapEntry("latitude", "11"),
      const MapEntry("origin", "MOB"),
      MapEntry(
          "payments",
          paymentMethods
              .map((e) => {'"paymentId"': e.code})
              .toList()
              .toString()),
      MapEntry(
          "localisation",
          {
            '"regionId"': regionId,
            '"departmentId"': departmentId,
            '"subPrefectureId"': subPrefectureId,
            '"localityId"': localityId,
          }.toString()),
      MapEntry("data", formData.toString())
    ];

    if (phone != null) {
      fields.add(MapEntry("phone", phone!));
    }

    formDataInstance.fields.addAll(fields);

    for (var path in imagePaths) {
      if (path != null) {
        final filename = path.split(Platform.pathSeparator).last;
        formDataInstance.files.add(MapEntry(
          "files",
          dio.MultipartFile.fromFileSync(path, filename: filename),
        ));
      }
    }

    return formDataInstance;
  }
}
