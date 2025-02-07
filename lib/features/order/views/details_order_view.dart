import 'package:eagri_pro/common/components/button_custom.dart';
import 'package:eagri_pro/common/components/custom_text_field.dart';
import 'package:eagri_pro/common/components/tag_custom.dart';
import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/features/order/data/models/delivery_model.dart';
import 'package:eagri_pro/features/order/data/models/order_model.dart';
import 'package:eagri_pro/features/order/views/order_mixin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../common/components/snack_bar_custom.dart';
import '../../../core/utils/enum.dart';
import '../cubit/order_cubit.dart';
import '../data/models/order_delivery_model.dart';

class DetailsOrderView extends StatefulWidget {
  final String id;
  final OrderModel? order;
  final String? invoiceNumber;
  const DetailsOrderView(
      {super.key, required this.id, this.order, this.invoiceNumber});

  @override
  State<DetailsOrderView> createState() => _DetailsOrderViewState();
}

class _DetailsOrderViewState extends State<DetailsOrderView>
    with OrderDetailsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Détails de la commande',
            style: TextStyle(color: Colors.white),
          ),
        ),
        bottomSheet: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state.selectedOrderDelivery != null &&
                state.selectedOrderDelivery?.delivery.status !=
                    DeliveryStatus.delivered) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(26),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: ButtonCustom(
                  label: "Valider la livraison",
                  isLoading: loadingValidatedDelivery,
                  onPressed: () async {
                    final isConfirmed =
                        await ShowConfirmDeliveryValidate(context);
                    if (isConfirmed == null || !isConfirmed) {
                      return;
                    }
                    setState(() {
                      delivery = state.selectedOrderDelivery;
                    });
                    final itemValided = 
                        await validate(state.selectedOrderDelivery!);
                    if (itemValided) {
                      return SnackBarCustom.show(
                        context: context,
                        message: 'Livraison validée',
                        type: SnackBarType.success,
                      );

                      // context.pop();
                    } else {
                      return SnackBarCustom.show(
                        context: context,
                        message: context.read<OrderCubit>().state.message ??
                            "Code invalide ou la livraison a déjà été validée",
                        type: SnackBarType.error,
                      );
                    }
                  },
                  backgroundColor: ColorConstants.primaryColor,
                  textColor: Colors.white,
                ),
              );
            }
            return const SizedBox();
          },
        ),
        body: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
          if (state.orderStatus == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return state.orderStatus == Status.error ||
                  state.selectedOrderDelivery == null
              ? Center(
                  child: Text(
                  'FACTURE NON CONFORME',
                  style: Theme.of(context).textTheme.titleMedium,
                ))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withAlpha(26), // Corrected here
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "# ${state.selectedOrderDelivery?.delivery.invoiceNumber}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      DateFormat.yMMMMd('fr').format(state
                                          .selectedOrderDelivery!
                                          .delivery
                                          .creationDate),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Colors.grey[600],
                                          ),
                                    ),
                                  ],
                                ),
                                TagCustom(
                                    data: state.selectedOrderDelivery!.delivery
                                        .status.description,
                                    color: state.selectedOrderDelivery!.delivery
                                        .status.color),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 16),
                            _buildInfoSection(
                              context,
                              "Informations client",
                              [
                                _buildInfoRow(context, "Nom",
                                    state.selectedOrderDelivery!.customer.name),
                                _buildInfoRow(
                                    context,
                                    "Téléphone",
                                    state
                                        .selectedOrderDelivery!.customer.phone),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Articles commandés",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(height: 12),
                      if (state.selectedOrderDelivery!.items.isNotEmpty)
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.selectedOrderDelivery!.items.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item =
                                state.selectedOrderDelivery!.items[index];
                            return ItemDeliveryProduct(item: item);
                          },
                        )
                      else
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 48,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Aucun article dans cette commande",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.grey[600],
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 80),
                    ],
                  ),
                );
        }));
  }

  Future<bool?> ShowConfirmDeliveryValidate(BuildContext context) {
    return showDialog<bool?>(
        context: context,
        builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text('Confirmer la livraison',
                    style: Theme.of(context).textTheme.titleMedium),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldCustom(
                        label: "Code de confirmation",
                        controller: code,
                        hintText: "123456"),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text('Annuler'),
                    onPressed: () => context.pop(false),
                  ),
                  TextButton(
                      child: const Text('Confirmer'),
                      onPressed: () async {
                        context.pop(true);
                      })
                ]));
  }

  Widget _buildInfoSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

class ItemDeliveryProduct extends StatelessWidget {
  const ItemDeliveryProduct({
    super.key,
    required this.item,
  });

  final OrderDeliveryModelItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TagCustom(
                data: item.product.product.name,
                radius: 5,
                color: ColorConstants.primaryColor,
              ),
              const Spacer(),
              TagCustom(
                  data: item.status.description, color: item.status.color),
            ],
          ),
          const SizedBox(height: 10),
          if (item.product.composites != null &&
              item.product.composites!.isNotEmpty)
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = item.product.composites![index];
                  return ItemProduct(item: product);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: item.product.composites!.length)
        ],
      ),
    );
  }
}

class ItemProduct extends StatelessWidget {
  const ItemProduct({
    super.key,
    required this.item,
  });

  final ProductElement item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor.withAlpha(26),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.shopping_bag_outlined,
                color: ColorConstants.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name, // Simplified access
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ) ??
                      TextStyle(), // Fallback to default TextStyle
                ),
                const SizedBox(height: 4),
                Text(
                  "Quantité: ${item.quantity}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ) ??
                      TextStyle(),
                ),
              ],
            ),
          ),
          // TagCustom(
          //   data: item..description,
          //   color: item.status.color,
          // ),
        ],
      ),
    );
  }
}
