import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/models/location_model.dart';
import '../repositories/configuration.repository.dart';

class GetDepartementByRegionUsecase implements UseCase<List<DepartementModel>, int> {
  final ConfigurationRepository repository;

  GetDepartementByRegionUsecase({required this.repository});

  @override
  Future<Either<Failure, List<DepartementModel>>> call(int params) async {
    return repository.getDepartementByRegion(params);
  }
}
