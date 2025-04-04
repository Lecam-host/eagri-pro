import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/models/location_model.dart';
import '../repositories/configuration.repository.dart';

class GetLocationsUsecase implements UseCase<List<LocationModel>, NoParams> {
  final ConfigurationRepository repository;

  GetLocationsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<LocationModel>>> call(NoParams params) async {
    return repository.getLocations();
  }
}