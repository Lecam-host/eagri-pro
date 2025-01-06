import 'package:eagri_pro/features/order/models/order_model.dart';
import 'package:eagri_pro/features/order/views/last_order_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../generated/locale_keys.g.dart';

final OrderModel order = OrderModel(
  id: 5,
  name: "Kit de plantation",
  status: "En attente",
  description: "Commande #123456",
);
class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(LocaleKeys.my_orders,
                  style: Theme.of(context).textTheme.titleLarge)
              .tr()),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                // hintText: LocaleKeys.search.tr(),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: "Rechercher",
                suffixIcon: const Icon(Icons.qr_code_scanner_sharp),
                hintStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.grey),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(7),
                //   borderSide: const BorderSide(
                //       color: Color.fromARGB(202, 158, 158, 158), width: 1),
                // ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(62, 158, 158, 158), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(62, 158, 158, 158), width: 1),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: 30,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return ItemOrder(order: order);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
