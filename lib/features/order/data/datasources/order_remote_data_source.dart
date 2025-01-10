import 'package:eagri_pro/features/order/data/models/get_orders_params.dart';
import 'package:eagri_pro/features/order/data/models/delivery_model.dart';
import '../../../../core/http/http_helper.dart';
import '../../domain/usecases/get_delivery_by_id_usecase.dart';
import '../models/order_model.dart';
import '../models/validate_delivery_params.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders(GetOrdersParams params);
  Future<List<DeliveryModel>> getDeliveryById(
      GetDeliveryByIdUsecaseParams params);
  Future<bool> validateDelivery(ValidateDeliveryParams params);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final HttpHelper httpHelper;

  OrderRemoteDataSourceImpl({required this.httpHelper});

  @override
  Future<List<OrderModel>> getOrders(GetOrdersParams params) async {
    try {
      final response = await httpHelper
          .get('/composite/delivery/supplier/${params.supplierId}');
      return (response.data["data"]['items'] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<DeliveryModel>> getDeliveryById(
      GetDeliveryByIdUsecaseParams params) async {
    try {
      final response = await httpHelper.post(
          '/composite/delivery/qr-code/verify',
          data: {'qrCode': params.code, 'supplierId': params.supplier});
      return (response.data["data"] as List)
          .map((e) => DeliveryModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> validateDelivery(ValidateDeliveryParams params) async {
    try {
      final response = await httpHelper.post('/delivery/validate',
          queryParameters: params.toJson());
      return response.data["data"];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}