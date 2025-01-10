import 'package:eagri_pro/common/components/tag_custom.dart';
import 'package:eagri_pro/features/auth/bloc/login/auth_bloc.dart';
import 'package:eagri_pro/features/order/cubit/order_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/utils/enum.dart';
import '../../../core/utils/router/routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../../auth/domain/entities/auth_entity.dart';
import '../data/models/order_model.dart';

class LastOrderSection extends StatefulWidget {
  const LastOrderSection({super.key});

  @override
  State<LastOrderSection> createState() => _LastOrderSectionState();
}

class _LastOrderSectionState extends State<LastOrderSection> {
  late AuthEntity? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = context.read<AuthBloc>().state.user;
    if (user != null) {
      context.read<OrderCubit>().getOrders(user!.organismAccountId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(LocaleKeys.last_orders,
                    style: Theme.of(context).textTheme.titleLarge)
                .tr(),
            const Spacer(),
            TextButton(
              onPressed: () => context.pushNamed(Routes.orders.path),
              child: const Text(LocaleKeys.see_all).tr(),
            ),
          ],
        ),
        BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state.ordersStatus == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return ItemOrder(order: state.orders[index]);
              },
            );
          },
        ),
      ],
    );
  }
}

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "# ${order.invoiceNumber}",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order.customer.name,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ),
                  TagCustom(
                      data: order.status.description,
                      color: order.status.color),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 12,
                  //     vertical: 6,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: ColorConstants.blueColor.withValues(alpha: 0.1),
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Container(
                  //         width: 6,
                  //         height: 6,
                  //         decoration: BoxDecoration(
                  //           color: ColorConstants.blueColor,
                  //           shape: BoxShape.circle,
                  //         ),
                  //       ),
                  //       const SizedBox(width: 6),
                  //       Text(
                  //         order.status.description,
                  //         style: TextStyle(
                  //           color: ColorConstants.blueColor,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoItem(
                    context,
                    Icons.calendar_today_outlined,
                    DateFormat.yMMMMd('fr').format(order.createdAt),
                  ),
                  const SizedBox(width: 24),
                  _buildInfoItem(
                    context,
                    Icons.shopping_cart_outlined,
                    "${'2'} produits",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
