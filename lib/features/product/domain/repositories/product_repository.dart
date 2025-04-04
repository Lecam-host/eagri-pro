import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/product/data/models/type_product_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../packages/models/formulaire_model.dart';
import '../../data/models/params/search_product_article_params.dart';
import '../../data/models/result_product_search_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<TypeProductModel>>> getTypeProduct();
  Future<Either<Failure, List<DataFormulaireModel>>> getFormByProductById(
      int id);
  Future<Either<Failure, List<ResultProductSearchModel>>> search(
      SearchProductArticleParams params);
}
