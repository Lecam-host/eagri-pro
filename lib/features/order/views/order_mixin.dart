import 'package:eagri_pro/common/components/snack_bar_custom.dart';
import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/features/auth/data/models/user_model.dart';
import 'package:eagri_pro/features/auth/domain/entities/auth_entity.dart';
import 'package:eagri_pro/features/order/cubit/order_cubit.dart';
import 'package:eagri_pro/features/order/data/models/delivery_model.dart';
import 'package:eagri_pro/features/order/data/models/order_model.dart';
import 'package:eagri_pro/features/order/views/details_order_view.dart';
import 'package:eagri_pro/features/order/views/order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/bloc/login/auth_bloc.dart';
import '../../auth/domain/entities/user_entity.dart';
import '../data/models/validate_delivery_params.dart';
import '../domain/usecases/get_delivery_by_id_usecase.dart';

mixin OrderMixin on State<OrderView> {
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthBloc>().state.user;
    if (user != null) {
      context.read<OrderCubit>().getOrders(user.organismAccountId!);
    }
  }
}

// class ItemOrder extends StatelessWidget {
//   final OrderModel order;

//   const ItemOrder({Key? key, required this.order}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 0,
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: () {},
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Commande #${order.invoiceNumber}',
//                         style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                       _buildStatusChip(context, "En attente de livraison"),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       _buildInfoItem(
//                         context,
//                         Icons.calendar_today_outlined,
//                         order.createdAt,
//                       ),
//                       const SizedBox(width: 24),
//                       _buildInfoItem(
//                         context,
//                         Icons.location_on_outlined,
//                         "Adresse",
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusChip(BuildContext context, String status) {
//     Color statusColor;
//     String statusText;

//     switch (status.toLowerCase()) {
//       case 'en cours':
//         statusColor = Colors.orange;
//         statusText = 'En cours';
//         break;
//       case 'terminé':
//         statusColor = Colors.green;
//         statusText = 'Terminé';
//         break;
//       case 'annulé':
//         statusColor = Colors.red;
//         statusText = 'Annulé';
//         break;
//       default:
//         statusColor = Colors.grey;
//         statusText = status;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: statusColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         statusText,
//         style: TextStyle(
//           color: statusColor,
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoItem(BuildContext context, IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           size: 16,
//           color: Colors.grey[600],
//         ),
//         const SizedBox(width: 4),
//         Text(
//           text,
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 color: Colors.grey[600],
//               ),
//         ),
//       ],
//     );
//   }
// }

mixin OrderDetailsMixin on State<DetailsOrderView> {
  List<DeliveryModel>? delivery;
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
      getDelivery(GetDeliveryByIdUsecaseParams(
          code: widget.id, supplier: auth!.organismAccountId!));
    }
  }

  getDelivery(GetDeliveryByIdUsecaseParams params) async {
    delivery = await context.read<OrderCubit>().getDeliveryById(params);
    setState(() {
      loading = false;
    });
  }

  Future<bool>validate() async {
    setState(() {
      loading = true;
    });
    itemValided = await context.read<OrderCubit>().validateDelivery(ValidateDeliveryParams(
        itemId: delivery![0].id,
        agentId: user!.user.account.id,
        pinCode: code.text));
    setState(() {
      loading = false;
    });
    return itemValided;
  }
}
