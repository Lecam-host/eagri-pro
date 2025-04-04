import 'dart:io';

import 'package:eagri_pro/common/helpers/image_upload_controller.dart';
import 'package:eagri_pro/common/widgets/app_bar_custom.dart';
import 'package:eagri_pro/common/widgets/images_upload_wrap.dart';
import 'package:eagri_pro/common/widgets/multi_selecte_custom.dart';
import 'package:eagri_pro/features/configuration/presentation/select_location/select_location_widget.dart';
import 'package:eagri_pro/features/product/data/models/result_product_search_model.dart';
import 'package:eagri_pro/packages/widgets/dropdown_custom.dart';
import 'package:eagri_pro/packages/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../common/components/tag_custom.dart';
import '../../../../common/widgets/card_image_upload.dart';
import '../../../../packages/models/formulaire_model.dart';
import '../../../payment/presentation/controller/payment_controller.dart';
import '../cubit/product_cubit.dart';

class PublishFormProductView extends StatefulWidget {
  final ResultProductSearchModel product;
  const PublishFormProductView({super.key, required this.product});

  @override
  State<PublishFormProductView> createState() => _PublishFormProductViewState();
}

class _PublishFormProductViewState extends State<PublishFormProductView> {
  final PaymentController paymentController = Get.put(PaymentController());
  final imageUploadController = ImageUploadController();

  final List<DataFormulaireModel> form = [];

  @override
  void initState() {
    paymentController.getListPaymentMethod(context);
    context
        .read<ProductCubit>()
        .getFormProductById(widget.product.id!)
        .then((value) => form.addAll(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          child: Column(
        children: [
          Text("Quel produit cherchez-vous ?",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.white)),
          TagCustom(data: widget.product.name!, color: Colors.white)
        ],
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ajouter une image du produit',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            ImageUploadWrap(controller: imageUploadController),
            FormWidget(form: form),
            DropdownCustom(
                label: "Unite de mesure",
                hintText: "Selectionner l'unité de mesure",
                items: widget.product.unitOfMeasures!
                    .map((e) => DropdownItem(value: e.unit!, name: e.name!))
                    .toList()),
            MultiSelectDropdownCustom(
                label: "Mode de paiement",
                hintText: "Selectionner le mode de paiement",
                items: paymentController.paymentOptions
                    .map((e) =>
                        DropdownItem(value: e.id.toString(), name: e.name))
                    .toList()),
            SelectLocationWidget(onChanged: (value) {}),
          ],
        ),
      ),
    );
  }
}
