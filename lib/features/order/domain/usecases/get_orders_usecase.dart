import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/order/data/models/get_orders_params.dart';
import 'package:eagri_pro/features/order/domain/repositories/order_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/models/order_model.dart';

class GetOrdersUsecase implements UseCase<List<OrderModel>, GetOrdersParams> {
  final OrderRepository orderRepository;

  GetOrdersUsecase({required this.orderRepository});

  @override
  Future<Either<Failure, List<OrderModel>>> call(GetOrdersParams params) async {
    return orderRepository.getOrders(params);
  }
}
