import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/models/location_model.dart';
import '../repositories/configuration.repository.dart';

class GetResgionsUsecase implements UseCase<List<RegionModel>, NoParams> {
  final ConfigurationRepository repository;

  GetResgionsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<RegionModel>>> call(NoParams params) async {
    return repository.getListRegion();
  }
}
