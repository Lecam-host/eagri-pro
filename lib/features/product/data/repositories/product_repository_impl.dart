import 'package:dartz/dartz.dart';
import 'package:eagri_pro/core/error/failure.dart';
import 'package:eagri_pro/features/product/data/models/params/publish_product_model.dart';
import 'package:eagri_pro/features/product/data/models/params/search_product_article_params.dart';
import 'package:eagri_pro/features/product/data/models/result_product_search_model.dart';
import 'package:eagri_pro/features/product/data/models/type_product_model.dart';
import 'package:eagri_pro/features/product/domain/repositories/product_repository.dart';
import 'package:eagri_pro/packages/models/formulaire_model.dart';

import '../../../../core/http/network_info.dart';
import '../datasource/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final NetworkInfo networkInfo;
  ProductRepositoryImpl(
      {required this.productRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<TypeProductModel>>> getTypeProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await productRemoteDataSource.getProducts();
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<DataFormulaireModel>>> getFormByProductById(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await productRemoteDataSource.getFormByProductById(id);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<ResultProductSearchModel>>> search(
      SearchProductArticleParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await productRemoteDataSource.search(params);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> publishProduct(PublishProductModel data) async{
    if (await networkInfo.isConnected) {
      try {
        final response = await productRemoteDataSource.publishProduct(data);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }
}
