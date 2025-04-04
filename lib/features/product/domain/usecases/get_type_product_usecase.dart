import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/product/data/models/type_product_model.dart';
import 'package:eagri_pro/features/product/domain/repositories/product_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';

class GetTypeProductUsecase implements UseCase<List<TypeProductModel>, NoParams> {
  final ProductRepository productRepository;

  GetTypeProductUsecase({required this.productRepository});

  @override
  Future<Either<Failure, List<TypeProductModel>>> call(NoParams params) async {
    return productRepository.getTypeProduct();
  }
}
