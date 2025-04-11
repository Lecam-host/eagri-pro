import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/product/data/models/type_product_model.dart';
import 'package:eagri_pro/features/product/domain/repositories/product_repository.dart';
import 'package:eagri_pro/packages/models/formulaire_model.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';

class GetFormProductByIdUsecase
    implements UseCase<List<DataFormulaireModel>, int> {
  final ProductRepository productRepository;

  GetFormProductByIdUsecase({required this.productRepository});

  @override
  Future<Either<Failure, List<DataFormulaireModel>>> call(int params) async {
    return productRepository.getFormByProductById(params);
  }
}
