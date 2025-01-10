import 'package:dartz/dartz.dart';
import 'package:eagri_pro/core/error/failure.dart';
import 'package:eagri_pro/features/order/data/datasources/order_remote_data_source.dart';
import 'package:eagri_pro/features/order/data/models/order_delivery_model.dart';
import 'package:eagri_pro/features/order/data/models/order_model.dart';
import 'package:eagri_pro/features/order/data/models/get_orders_params.dart';
import 'package:eagri_pro/features/order/data/models/delivery_model.dart';
import 'package:eagri_pro/features/order/data/models/validate_delivery_params.dart';
import 'package:eagri_pro/features/order/domain/repositories/order_repository.dart';
import '../../../../core/http/network_info.dart';
import '../../domain/usecases/get_delivery_by_id_usecase.dart';
import '../models/params/get_order_delivery_by_qr_params.dart';

class OrderRepositoryImpl implements OrderRepository {
  final NetworkInfo networkInfo;
  OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, List<OrderModel>>> getOrders(
      GetOrdersParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getOrders(params);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<DeliveryModel>>> getDeliveryById(
      GetDeliveryByIdUsecaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getDeliveryById(params);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> validateDelivery(
      ValidateDeliveryParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.validateDelivery(params);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, OrderDeliveryModel>> getDeliveryByQrCode(
      GetOrderDeliveryByQrParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getDeliveryByQrCode(params);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }
}
