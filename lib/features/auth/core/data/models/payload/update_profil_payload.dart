import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/function_utils.dart';

class UpdateProfilPayload {
  final int id;
  final int? parentId;
  final int regionId;
  final int? departementId;
  final int? sousprefectureId;
  final int? localiteId;
  final int organismId;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String gender;
  final String title;
  final String phone;
  final String typeAccount;
  final String address;
  final String? photo;
  UpdateProfilPayload({
    required this.id,
    this.parentId,
    required this.regionId,
    this.departementId,
    this.sousprefectureId,
    this.localiteId,
    required this.organismId,
    required this.firstName,
    required this.lastName,
     this.photo,
    required this.birthDate,
    required this.gender,
    required this.title,
    required this.phone,
    required this.typeAccount,
    required this.address,
  });

  toJson() async => removeNulls({
        "parentId": parentId,
        "regionId": regionId,
        "departementId": departementId,
        "sousprefectureId": sousprefectureId,
        "localiteId": localiteId,
        "organismId": organismId,
        "firstName": firstName,
        "lastName": lastName,
        "birthDate": DateTime.parse(DateFormat('yyyy-MM-dd').format(birthDate))
            .toString()
            .split(' ')[0],
        "gender": gender,
        "photo": photo != null ? await MultipartFile.fromFile(photo!,
            filename: photo?.split('/').last) : null,
        "title": title,
        "phone": phone,
        "typeAccount": typeAccount,
        "address": address,
      });
}
