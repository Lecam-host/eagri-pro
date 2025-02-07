import 'package:eagri_pro/common/components/snack_bar_custom.dart';
import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/features/auth/data/models/user_model.dart';
import 'package:eagri_pro/features/auth/domain/entities/auth_entity.dart';
import 'package:eagri_pro/features/order/cubit/order_cubit.dart';
import 'package:eagri_pro/features/order/data/models/delivery_model.dart';
import 'package:eagri_pro/features/order/data/models/order_delivery_model.dart';
import 'package:eagri_pro/features/order/data/models/order_model.dart';
import 'package:eagri_pro/features/order/views/details_order_view.dart';
import 'package:eagri_pro/features/order/views/order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/bloc/login/auth_bloc.dart';
import '../../auth/domain/entities/user_entity.dart';
import '../data/models/params/get_order_delivery_by_qr_params.dart';
import '../data/models/validate_delivery_params.dart';

mixin OrderMixin on State<OrderView> {
  DeliveryStatus selectedStatus = DeliveryStatus.undefined;
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthBloc>().state.user;
    if (user != null) {
      getOrders();
    }
  }

  getOrders() async {
    context.read<OrderCubit>().getOrders(
        context.read<AuthBloc>().state.user!.organismAccountId!,
        status:
            selectedStatus == DeliveryStatus.undefined ? null : selectedStatus);
  }
}

mixin OrderDetailsMixin on State<DetailsOrderView> {
  OrderDeliveryModel? delivery;
  OrderModel? orderSelected;
  bool loadingValidatedDelivery = false;
  bool itemValided = false;

  final TextEditingController code = TextEditingController();
  late UserEntity? user;
  bool loading = true;
  final itemSelected = ValueNotifier<int>(0);

  late AuthEntity? auth;

  @override
  void initState() {
    super.initState();
    auth = context.read<AuthBloc>().state.user!;
    user = context.read<AuthBloc>().state.account;
    orderSelected = context.read<OrderCubit>().state.orderSelected;
    if (auth != null) {
      context.read<OrderCubit>().getOrderDeliveryByQrCode(
          GetOrderDeliveryByQrParams(
              qrCode: widget.id,
              supplierId: auth!.organismAccountId!,
              invoiceNumber: widget.invoiceNumber));
    }
  }

  Future<bool> validate(OrderDeliveryModel delivery) async {
    itemValided = await context.read<OrderCubit>().validateDelivery(
        ValidateDeliveryParams(
            deliveryId: delivery.delivery.id,
            agentId: user!.user.account.id,
            supplierId: auth!.organismAccountId!,
            pinCode: code.text));
    if (itemValided) {
      context.read<OrderCubit>().getOrderDeliveryByQrCode(
          GetOrderDeliveryByQrParams(
              qrCode: widget.id, supplierId: auth!.organismAccountId!));
    }
    return itemValided;
  }
}
