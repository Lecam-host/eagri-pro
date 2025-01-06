import 'package:eagri_pro/common/components/tag_custom.dart';
import 'package:eagri_pro/features/order/models/order_model.dart';
import 'package:flutter/material.dart';

class DetailsOrderView extends StatelessWidget {
  final OrderModel order;
  const DetailsOrderView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${order.name}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            TagCustom(
                data: order.status ?? '',
                color: Colors.green,
                textColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
