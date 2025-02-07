import 'package:eagri_pro/core/utils/enum.dart';
import 'package:eagri_pro/core/utils/router/routes.dart';
import 'package:eagri_pro/features/order/cubit/order_cubit.dart';
import 'package:eagri_pro/features/order/views/last_order_section.dart';
import 'package:eagri_pro/features/order/views/order_mixin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../core/constants/color_constants.dart';
import '../data/models/delivery_model.dart';

const filterStatus = [
  DeliveryStatus.undefined,
  DeliveryStatus.pending,
  DeliveryStatus.delivered,
  DeliveryStatus.cancelled,
];

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> with OrderMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          LocaleKeys.my_orders.tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: .1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => context.read<OrderCubit>().searchOrderState(value),
                  decoration: InputDecoration(
                    hintText: "Rechercher une commande",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            ColorConstants.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GestureDetector(
                        onTap: () => context.pushNamed(Routes.scanQrCode.name),
                        child: Icon(
                          Icons.qr_code_scanner_sharp,
                          color: ColorConstants.primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey[400],
                        ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color:
                            ColorConstants.primaryColor.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 35,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data = filterStatus[index];
                        return _buildFilterChip(
                          data.description,
                          selectedStatus == data,
                          () {
                            setState(() {
                              selectedStatus = data;
                              getOrders();
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 8);
                      },
                      itemCount: filterStatus.length),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state.ordersStatus == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.ordersFiltered.isEmpty) {
                  return Center(
                    child: Text(
                      "AUCUNE FACTURE (${selectedStatus.description})",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.ordersFiltered.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = state.ordersFiltered[index];
                    return InkWell(
                        onTap: () {
                          context.read<OrderCubit>().setOrderSelected(order);
                          context.pushNamed(Routes.scanQrCode.name,
                              extra: {'invoiceNumber': order.invoiceNumber});
                        },
                        child: ItemOrder(order: order));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorConstants.primaryColor
              : ColorConstants.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : ColorConstants.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
