import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/models/location_model.dart';
import '../repositories/configuration.repository.dart';

class GetSousprefectureByDepartementUsecase implements UseCase<List<SpModel>, int> {
  final ConfigurationRepository repository;

  GetSousprefectureByDepartementUsecase({required this.repository});

  @override
  Future<Either<Failure, List<SpModel>>> call(int params) async {
    return repository.getSousprefectureByDepartement(params);
  }
}
