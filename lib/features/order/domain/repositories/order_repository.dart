import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/order/data/models/order_model.dart';
import 'package:eagri_pro/features/order/data/models/get_orders_params.dart';
import 'package:eagri_pro/features/order/data/models/delivery_model.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/validate_delivery_params.dart';
import '../usecases/get_delivery_by_id_usecase.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> getOrders(GetOrdersParams params);
  Future<Either<Failure, List<DeliveryModel>>> getDeliveryById(
      GetDeliveryByIdUsecaseParams params);
  Future<Either<Failure, bool>> validateDelivery(
      ValidateDeliveryParams params);
}
