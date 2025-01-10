import 'dart:convert';
import 'package:eagri_pro/core/storage/hive_helper.dart';
import 'package:eagri_pro/features/order/data/models/delivery_model.dart';
import 'package:eagri_pro/features/order/data/models/get_orders_params.dart';
import 'package:eagri_pro/features/order/data/models/order_model.dart';
import 'package:hive/hive.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderModel>> getOrders(GetOrdersParams params);
  Future<void> cacheOrders(List<OrderModel> orders);
  Future<DeliveryModel> getDeliveryById(String id);
  Future<void> cacheDelivery(String id, DeliveryModel delivery);
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final HiveHelper hiveHelper;
  static const String ordersBoxName = 'orders_box';
  static const String deliveriesBoxName = 'deliveries_box';
  static const String ordersKey = 'all_orders';

  OrderLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<List<OrderModel>> getOrders(GetOrdersParams params) async {
    try {
      final box = await hiveHelper.openBox(ordersBoxName);
      final jsonString = hiveHelper.getData(box, ordersKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = json.decode(jsonString);
      final orders = jsonList.map((json) => OrderModel.fromJson(json)).toList();
      await hiveHelper.closeBox(box);
      return orders;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> cacheOrders(List<OrderModel> orders) async {
    final box = await hiveHelper.openBox(ordersBoxName);
    final String jsonString = json.encode(
      orders.map((order) => order.toJson()).toList(),
    );
    await hiveHelper.putData(box, ordersKey, jsonString);
    await hiveHelper.closeBox(box);
  }

  @override
  Future<DeliveryModel> getDeliveryById(String id) async {
    try {
      final box = await hiveHelper.openBox(deliveriesBoxName);
      final jsonString = hiveHelper.getData(box, id);
      if (jsonString == null) {
        await hiveHelper.closeBox(box);
        throw Exception('No cached delivery found');
      }

      final delivery = DeliveryModel.fromJson(json.decode(jsonString));
      await hiveHelper.closeBox(box);
      return delivery;
    } catch (e) {
      throw Exception('Failed to get cached delivery: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheDelivery(String id, DeliveryModel delivery) async {
    final box = await hiveHelper.openBox(deliveriesBoxName);
    final String jsonString = json.encode(delivery.toJson());
    await hiveHelper.putData(box, id, jsonString);
    await hiveHelper.closeBox(box);
  }
}
