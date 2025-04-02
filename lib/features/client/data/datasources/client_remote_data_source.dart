import 'package:dio/dio.dart';
import 'package:eagri_pro/features/client/data/models/client_model.dart';
import 'package:eagri_pro/features/client/data/models/params/paginate_queries.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/http/http_helper.dart';
import '../models/params/search_client_params.dart';

abstract class ClientRemoteDataSource {
  Future<List<ClientModel>> searchClients(SearchCriteriaListParams params,
      {PaginateQueries? paginateQueries});
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final HttpHelper httpHelper;
  ClientRemoteDataSourceImpl({required this.httpHelper});
  @override
  Future<List<ClientModel>> searchClients(SearchCriteriaListParams params,
      {PaginateQueries? paginateQueries}) async {
    try {
      final response = await httpHelper.post(
          '${ConstantUrl.msSecurity}/users/search?',
          data: params.toJson(),
          queryParameters: paginateQueries?.toJson());
      return (response.data["data"]['items'] as List)
          .map((e) => ClientModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['statusMessage']);
    }
  }
}
