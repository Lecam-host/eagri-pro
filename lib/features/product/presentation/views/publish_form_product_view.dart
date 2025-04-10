import 'dart:developer';
import 'dart:io';

import 'package:eagri_pro/common/components/button_custom.dart';
import 'package:eagri_pro/common/components/snack_bar_custom.dart';
import 'package:eagri_pro/common/helpers/image_upload_controller.dart';
import 'package:eagri_pro/common/widgets/app_bar_custom.dart';
import 'package:eagri_pro/common/widgets/images_upload_wrap.dart';
import 'package:eagri_pro/common/widgets/multi_selecte_custom.dart';
import 'package:eagri_pro/features/auth/bloc/login/auth_bloc.dart';
import 'package:eagri_pro/features/configuration/presentation/select_location/select_location_widget.dart';
import 'package:eagri_pro/features/product/data/models/params/publish_product_model.dart';
import 'package:eagri_pro/features/product/data/models/result_product_search_model.dart';
import 'package:eagri_pro/packages/widgets/dropdown_custom.dart';
import 'package:eagri_pro/packages/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../common/components/tag_custom.dart';
import '../../../../common/widgets/card_image_upload.dart';
import '../../../../common/widgets/message_banner.dart';
import '../../../../core/utils/enum.dart';
import '../../../../packages/models/formulaire_model.dart';
import '../../../client/presentation/cubit/client_cubit.dart';
import '../../../payment/presentation/controller/payment_controller.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class PublishFormProductView extends StatefulWidget {
  final ResultProductSearchModel product;
  const PublishFormProductView({super.key, required this.product});

  @override
  State<PublishFormProductView> createState() => _PublishFormProductViewState();
}

class _PublishFormProductViewState extends State<PublishFormProductView> {
  final PaymentController paymentController = Get.put(PaymentController());
  final imageUploadController = ImageUploadController();
  final formKey = GlobalKey<FormBuilderState>();

  int? clientId;

  final List<DataFormulaireModel> form = [];
  SelectLocationResultat? location;
  List<String> paymentMethodIds = [];
  String? unitOfMeasures;

  @override
  void initState() {
    paymentController.getListPaymentMethod(context);
    clientId =
        context.read<ClientCubit>().state.clientSelected?.user?.account?.id;
    context
        .read<ProductCubit>()
        .getFormProductById(widget.product.id!)
        .then((value) => setState(() {
              form.addAll(value);
            }));
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
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            SnackBarCustom.show(
                type: SnackBarType.error,
                context: context,
                message: state.errorMessage ?? '');
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
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
                FormBuilder(key: formKey, child: FormWidget(form: form)),
                DropdownCustom(
                    label: "Unite de mesure",
                    hintText: "Selectionner l'unité de mesure",
                    onChanged: (value) {
                      setState(() {
                        unitOfMeasures = value;
                      });
                    },
                    items: widget.product.unitOfMeasures!
                        .map((e) => DropdownItem(value: e.unit!, name: e.name!))
                        .toList()),
                MultiSelectDropdownCustom(
                    label: "Mode de paiement",
                    hintText: "Selectionner le mode de paiement",
                    onChanged: (value) {
                      setState(() {
                        paymentMethodIds = value;
                      });
                    },
                    items: paymentController.paymentOptions
                        .map((e) =>
                            DropdownItem(value: e.id.toString(), name: e.name))
                        .toList()),
                SelectLocationWidget(onChanged: (value) {
                  setState(() {
                    location = value;
                  });
                }),
                ButtonCustom(
                    label: "Publier",
                    onPressed: () {
                      inspect(formKey.currentState!.value);
                      if (formKey.currentState!.saveAndValidate()) {
                        final dataValues = [
                          ...formKey.currentState!.value.entries.where(
                              (element) =>
                                  element.value != null &&
                                  element.value.isNotEmpty)
                        ];
                        dataValues
                            .add(MapEntry("unit_of_measure", unitOfMeasures));
                        final PublishProductModel data = PublishProductModel(
                          userId: clientId,
                          agentId:
                              context.read<AuthBloc>().state.user?.accountId,
                          data: dataValues,
                          files: imageUploadController.images
                              .map((e) => e.path)
                              .toList(),
                          localisation: LocationPublishProduct(
                              departmentId: location!.departement!.id,
                              localityId: location!.locality?.id,
                              regionId: location!.region?.id,
                              subPrefectureId: location!.sousPrefecture?.id),
                          productId: widget.product.id,
                          payments: paymentMethodIds
                              .map((e) => PaymentPublishProduct(paymentId: e))
                              .toList(),
                        );
                        inspect(data);
                        context.read<ProductCubit>().publishProduct(data);
                      } else {
                        SnackBarCustom.show(
                            context: context,
                            message: "Veuillez remplir tous les champs");
                      }
                    },
                    isLoading: state.status == Status.loading),
              ],
            ),
          );
        },
      ),
    );
  }
}
