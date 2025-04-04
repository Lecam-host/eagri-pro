import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/models/location_model.dart';
import '../repositories/configuration.repository.dart';

class GetLocaliteBySousprefectureUsecase implements UseCase<List<LocaliteModel>, int> {
  final ConfigurationRepository repository;

  GetLocaliteBySousprefectureUsecase({required this.repository});

  @override
  Future<Either<Failure, List<LocaliteModel>>> call(int params) async {
    return repository.getLocaliteBySousprefecture(params);
  }
}
