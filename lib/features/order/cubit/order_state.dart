part of 'order_cubit.dart';

class OrderState extends Equatable {
  final List<OrderModel> orders;
  final Status ordersStatus;
  final Status orderStatus;
  final OrderModel? orderSelected;
  final String? message;
  const OrderState(
      {this.orders = const <OrderModel>[], this.ordersStatus = Status.initial, this.message, this.orderSelected, this.orderStatus = Status.initial});

  OrderState copyWith({
    List<OrderModel>? orders,
    Status? status,
    Status? orderStatus,
    String? message,
    OrderModel? orderSelected,
    
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      ordersStatus: status ?? this.ordersStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      message: message ?? this.message,
      orderSelected: orderSelected ?? this.orderSelected,
    );
  }

  @override
  List<Object> get props => [
        orders,
        ordersStatus,
        message ?? '',
        orderStatus,
        orderSelected ?? '',
      ];
}

final class OrderInitial extends OrderState {}
