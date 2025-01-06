import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/tag_custom.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/utils/router/routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../models/order_model.dart';

class LastOrderSection extends StatelessWidget {
  const LastOrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OrderModel> orders = [
      OrderModel(
        id: 1,
        name: "Kit de plantation",
        status: "En attente",
        description: "Commande #123456",
      ),
      OrderModel(
        id: 2,
        name: "Kit de plantation",
        status: "En attente",
        description: "Commande #123456",
      ),
      OrderModel(
        id: 3,
        name: "Kit de plantation",
        status: "En attente",
        description: "Commande #123456",
      ),
    ];
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
        ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final OrderModel order = orders[index];
            return ItemOrder(order: order);
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorConstants.primaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.name ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w600))
                      .tr(),
                  Text(order.description ?? "",
                          style: Theme.of(context).textTheme.bodyMedium)
                      .tr(),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              TagCustom(
                data: order.status ?? "",
                color: ColorConstants.blueColor,
                textColor: Colors.white,
              ),
              const Spacer(),
              Text("200 FCFA",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
            ],
          )
        ],
      ),
      // ListTile(
      //   onTap: () =>
      //       context.pushNamed(Routes.detailsOrders.path, extra: order),
      //   title: Text(order.name ?? "",
      //       style: Theme.of(context)
      //           .textTheme
      //           .titleMedium!
      //           .copyWith(fontWeight: FontWeight.w600)),
      //   subtitle: Text(order.description ?? "",
      //       style: Theme.of(context).textTheme.bodyMedium),
      //   trailing: TagCustom(
      //     data: order.status ?? "",
      //     backgroundColor: ColorConstants.blueColor,
      //     textColor: Colors.white,
      //   ),
      // ),
    );
  }
}
