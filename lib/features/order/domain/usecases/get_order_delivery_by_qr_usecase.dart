import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/order/data/models/order_delivery_model.dart';
import 'package:eagri_pro/features/order/domain/repositories/order_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/models/params/get_order_delivery_by_qr_params.dart';

class GetOrderDeliveryByQrUsecase
    implements UseCase<OrderDeliveryModel, GetOrderDeliveryByQrParams> {
  final OrderRepository orderRepository;

  GetOrderDeliveryByQrUsecase({required this.orderRepository});

  @override
  Future<Either<Failure, OrderDeliveryModel>> call(
      GetOrderDeliveryByQrParams params) async {
    return orderRepository.getDeliveryByQrCode(params);
  }
}
