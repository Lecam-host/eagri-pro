import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/models/location_model.dart';

abstract class ConfigurationRepository {
  Future<Either<Failure, List<LocationModel>>> getLocations();
    Future<Either<Failure, List<RegionModel>>> getListRegion();
     Future<Either<Failure, List<DepartementModel>>> getDepartementByRegion(
      int idRegion);
  Future<Either<Failure, List<SpModel>>> getSousprefectureByDepartement(
      int idDepartement);
  Future<Either<Failure, List<LocaliteModel>>> getLocaliteBySousprefecture(
      int idSp);
}
