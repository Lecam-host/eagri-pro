import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/order/domain/repositories/order_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/models/delivery_model.dart';

class GetDeliveryByIdUsecase
    implements UseCase<List<DeliveryModel>, GetDeliveryByIdUsecaseParams> {
  final OrderRepository orderRepository;

  GetDeliveryByIdUsecase({required this.orderRepository});

  @override
  Future<Either<Failure, List<DeliveryModel>>> call(
      GetDeliveryByIdUsecaseParams params) async {
    return orderRepository.getDeliveryById(params);
  }
}

class GetDeliveryByIdUsecaseParams {
  final String code;
  final int supplier;

  GetDeliveryByIdUsecaseParams({required this.code, required this.supplier});

  toMap() => {'code': id, 'supplier': supplier};
}
