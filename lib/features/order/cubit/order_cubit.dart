import 'package:eagri_pro/features/order/domain/usecases/get_order_delivery_by_qr_usecase.dart';
import 'package:eagri_pro/features/order/domain/usecases/validate_delivery_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eagri_pro/core/utils/enum.dart';
import 'package:eagri_pro/features/order/data/models/get_orders_params.dart';
import 'package:eagri_pro/features/order/domain/usecases/get_delivery_by_id_usecase.dart';
import 'package:eagri_pro/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:equatable/equatable.dart';
import '../data/models/delivery_model.dart';
import '../data/models/order_delivery_model.dart';
import '../data/models/order_model.dart';
import '../data/models/params/get_order_delivery_by_qr_params.dart';
import '../data/models/validate_delivery_params.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final GetOrdersUsecase getOrdersUsecase;
  final GetDeliveryByIdUsecase getDeliveryByIdUsecase;
  final ValidateDeliveryUsecase validateDeliveryUsecase;
  final GetOrderDeliveryByQrUsecase getOrderDeliveryByQrUsecase;
  OrderCubit(
      {required this.getOrdersUsecase,
      required this.getDeliveryByIdUsecase,
      required this.getOrderDeliveryByQrUsecase,
      required this.validateDeliveryUsecase})
      : super(OrderInitial());

  // get orders

  void getOrders(int supplierId) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response =
          await getOrdersUsecase(GetOrdersParams(supplierId: supplierId));
      response.fold((l) {
        emit(state.copyWith(status: Status.error, message: l.errorMessage));
      }, (r) {
        emit(state.copyWith(status: Status.success, orders: r));
      });
    } catch (e) {
      emit(state.copyWith(status: Status.error, message: e.toString()));
    }
  }

  Future<List<DeliveryModel>?> getDeliveryById(
      GetDeliveryByIdUsecaseParams params) async {
    try {
      final response = await getDeliveryByIdUsecase.call(params);
      return response.fold((l) {
        return null;
      }, (r) => r);
    } catch (e) {
      return null;
    }
  }

  Future<bool> validateDelivery(ValidateDeliveryParams params) async {
    try {
      emit(state.copyWith(orderStatus: Status.loading));
      final response = await validateDeliveryUsecase.call(params);

      return response.fold((l) {
        emit(
            state.copyWith(orderStatus: Status.error, message: l.errorMessage));
        return false;
      }, (r) {
        emit(state.copyWith(orderStatus: Status.success));
        return r;
      });
    } catch (e) {
      emit(state.copyWith(orderStatus: Status.error, message: e.toString()));
      return false;
    }
  }

  Future<OrderDeliveryModel?> getOrderDeliveryByQrCode(
      GetOrderDeliveryByQrParams params) async {
    try {
      emit(state.copyWith(
          orderStatus: Status.loading, selectedOrderDelivery: null));
      final response = await getOrderDeliveryByQrUsecase.call(params);
      return response.fold((l) {
        emit(state.copyWith(
            orderStatus: Status.error,
            message: l.errorMessage,
            selectedOrderDelivery: null));
        return null;
      }, (r) {
        emit(state.copyWith(
            orderStatus: Status.success, selectedOrderDelivery: r));
        return r;
      });
    } catch (e) {
      emit(state.copyWith(
          orderStatus: Status.error,
          message: e.toString(),
          selectedOrderDelivery: null));
      return null;
    }
  }

  // setOrderSelected
  Future<void> setOrderSelected(OrderModel order) async {
    emit(state.copyWith(orderSelected: order));
  }
}
