import 'package:dio/dio.dart';
import '../../../../../core/http/http_helper.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/location_model.dart';

abstract class ConfigurationRemoteDataSource {
  Future<List<LocationModel>> getLocations();
  Future<List<RegionModel>> getListRegion();
  Future<List<DepartementModel>> getDepartementByRegion(int idRegion);
  Future<List<SpModel>> getSousprefectureByDepartement(int idDepartement);
  Future<List<LocaliteModel>> getLocaliteBySousprefecture(int idSp);
}

class ConfigurationRemoteDataSourceImpl
    implements ConfigurationRemoteDataSource {
  final HttpHelper httpHelper;

  ConfigurationRemoteDataSourceImpl({required this.httpHelper});

  @override
  Future<List<LocationModel>> getLocations() async {
    try {
      final response = await httpHelper.get('${ConstantUrl.msConfig}/location');
      if (response.statusCode == 200) {
        List<LocationModel> list = [];
        response.data['data'].forEach((element) {
          list.add(LocationModel.fromJson(element));
        });
        return list;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<RegionModel>> getListRegion() async {
    try {
      final response = await httpHelper.get('${ConstantUrl.msLocation}/region/get');
      if (response.statusCode == 200) {
        List<RegionModel> list = [];
        response.data['data'].forEach((element) {
          list.add(RegionModel.fromJson(element));
        });
        return list;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<DepartementModel>> getDepartementByRegion(int idRegion) async {
    try {
      final response = await httpHelper
          .get("${ConstantUrl.msLocation}/region/departement/$idRegion");
      if (response.statusCode == 200) {
        List<DepartementModel> list = [];
        response.data['data'].forEach((element) {
          list.add(DepartementModel.fromJson(element));
        });
        return list;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<LocaliteModel>> getLocaliteBySousprefecture(int idSp) async {
    try {
      final response = await httpHelper.get(
          "${ConstantUrl.msLocation}/region/departement/sp/localite/$idSp");
      if (response.statusCode == 200) {
        List<LocaliteModel> list = [];
        response.data['data'].forEach((element) {
          list.add(LocaliteModel.fromJson(element));
        });
        return list;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<SpModel>> getSousprefectureByDepartement(
      int idDepartement) async {
    try {
      final response = await httpHelper.get(
          "${ConstantUrl.msLocation}/region/departement/sp/$idDepartement");
      if (response.statusCode == 200) {
        List<SpModel> list = [];
        response.data['data'].forEach((element) {
          list.add(SpModel.fromJson(element));
        });
        return list;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
