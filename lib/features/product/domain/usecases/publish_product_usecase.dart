import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/product/domain/repositories/product_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/models/params/publish_product_model.dart';

class PublishProductUsecase
    implements UseCase<bool, PublishProductModel> {
  final ProductRepository productRepository;

  PublishProductUsecase({required this.productRepository});

  @override
  Future<Either<Failure, bool>> call(
      PublishProductModel params) async {
    return productRepository.publishProduct(params);
  }
}
