import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> getProductById(int id);
}