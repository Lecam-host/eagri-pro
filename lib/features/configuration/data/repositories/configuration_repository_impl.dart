import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/http/network_info.dart';
import '../../domain/repositories/configuration.repository.dart';
import '../datasources/configuration_remote_data_source.dart';
import '../models/location_model.dart';

class ConfigurationRepositoryImpl extends ConfigurationRepository {
  final ConfigurationRemoteDataSource configurationRemoteDatasource;
  ConfigurationRepositoryImpl(
      {required this.configurationRemoteDatasource, required this.networkInfo});
  final NetworkInfo networkInfo;
  @override
  Future<Either<Failure, List<LocationModel>>> getLocations() async {
    try {
      final response = await configurationRemoteDatasource.getLocations();
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<RegionModel>>> getListRegion() async {
    try {
      final response = await configurationRemoteDatasource.getListRegion();
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<DepartementModel>>> getDepartementByRegion(
      int idRegion) async {
    try {
      final response =
          await configurationRemoteDatasource.getDepartementByRegion(idRegion);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<SpModel>>> getSousprefectureByDepartement(
      int idDepartement) async {
    try {
      final response = await configurationRemoteDatasource
          .getSousprefectureByDepartement(idDepartement);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<LocaliteModel>>> getLocaliteBySousprefecture(
      int idSp) async {
    try {
      final response =
          await configurationRemoteDatasource.getLocaliteBySousprefecture(idSp);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
