import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/order/data/models/validate_delivery_params.dart';
import 'package:eagri_pro/features/order/domain/repositories/order_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';

class ValidateDeliveryUsecase implements UseCase<bool, ValidateDeliveryParams> {
  final OrderRepository orderRepository;

  ValidateDeliveryUsecase({required this.orderRepository});

  @override
  Future<Either<Failure, bool>> call(
      ValidateDeliveryParams params) async {
    return orderRepository.validateDelivery(params);
  }
}
