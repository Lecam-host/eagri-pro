import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/client/data/models/client_model.dart';
import 'package:eagri_pro/features/client/data/models/params/search_client_params.dart';
import 'package:eagri_pro/features/client/domain/repositories/client_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';

class SearchClientsUsecase implements UseCase<List<ClientModel>, SearchCriteriaListParams> {
  final ClientRepository clientRepository;

  SearchClientsUsecase({required this.clientRepository});

  @override
  Future<Either<Failure, List<ClientModel>>> call(
      SearchCriteriaListParams params) async {
    return clientRepository.searchClients(params);
  }
}
