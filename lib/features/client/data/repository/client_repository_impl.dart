import 'package:dartz/dartz.dart';
import 'package:eagri_pro/core/error/failure.dart';
import 'package:eagri_pro/features/client/data/models/client_model.dart';
import 'package:eagri_pro/features/client/domain/repositories/client_repository.dart';

import '../../../../core/http/network_info.dart';
import '../datasources/client_remote_data_source.dart';
import '../models/params/paginate_queries.dart';
import '../models/params/search_client_params.dart';

class ClientRepositoryImpl implements ClientRepository{
  final ClientRemoteDataSource clientRemoteDataSource;
  final NetworkInfo networkInfo;
  ClientRepositoryImpl({ required this.clientRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<ClientModel>>> searchClients(
      SearchCriteriaListParams params, {PaginateQueries? paginateQueries})async {
    if (await networkInfo.isConnected) {
      try {
        final response = await clientRemoteDataSource.searchClients(params, paginateQueries: paginateQueries);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }
}