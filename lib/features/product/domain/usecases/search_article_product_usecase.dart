import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/models/params/search_product_article_params.dart';
import '../../data/models/result_product_search_model.dart';
import '../repositories/product_repository.dart';

class SearchArticleProductUsecase
    implements UseCase<List<ResultProductSearchModel>, SearchProductArticleParams> {
  final ProductRepository productRepository;

  SearchArticleProductUsecase({required this.productRepository});

  @override
  Future<Either<Failure, List<ResultProductSearchModel>>> call(
      SearchProductArticleParams params) async {
    return productRepository.search(params);
  }
}
