import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/client/data/models/params/search_client_params.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/client_model.dart';
import '../../data/models/params/paginate_queries.dart';

abstract class ClientRepository {
  Future<Either<Failure, List<ClientModel>>> searchClients(SearchCriteriaListParams params, {PaginateQueries? paginateQueries});
}
