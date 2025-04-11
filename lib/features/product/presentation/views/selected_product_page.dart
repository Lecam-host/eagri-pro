import 'package:eagri_pro/common/components/custom_text_field.dart';
import 'package:eagri_pro/common/widgets/message_banner.dart';
import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/core/utils/router/routes.dart';
import 'package:eagri_pro/features/product/data/models/type_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/components/tag_custom.dart';
import '../../../../common/widgets/app_bar_custom.dart';
import '../../../../core/utils/enum.dart';
import '../../data/models/params/search_product_article_params.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class SelectedProductPage extends StatefulWidget {
  final TypeProductModel typePublication;
  const SelectedProductPage({super.key, required this.typePublication});

  @override
  State<SelectedProductPage> createState() => _SelectedProductPageState();
}

class _SelectedProductPageState extends State<SelectedProductPage> {
  // final ConfigProductController configController =
  //     Get.put(ConfigProductController());

  // final PaymentController paymentController = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().resetListProduct();
    // paymentController.getListPaymentMethod(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
            child: Column(
          children: [
            Text("Quel produit cherchez-vous ?",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.white)),
            TagCustom(data: widget.typePublication.name, color: Colors.white)
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CustomTextField(
                placeholder: "Rechercher un produit",
                onChanged: (value) {
                  if (value.length > 1) {
                    context
                        .read<ProductCubit>()
                        .searchArticleProduct(SearchProductArticleParams(
                          name: value,
                          parentId: widget.typePublication.id,
                        ));
                  }
                  if (value.isEmpty) {
                    context.read<ProductCubit>().resetListProduct();
                  }
                },
              ),
              const SizedBox(height: 10),
              Expanded(child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == Status.error) {
                  return Center(child: Text(state.errorMessage!));
                }
                if (state.listProduct.isEmpty) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MessageBanner(
                          message: "Veuillez faire une recherche",
                          type: MessageType.info)
                    ],
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final item = state.listProduct[index];
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () {
                          context.pushNamed(Routes.publishFormProduct.name,
                              extra: {"product": item});
                        },
                        // leading: const CircleAvatar(
                        //   backgroundImage: NetworkImage(""),
                        // ),
                        title: Text(
                          state.listProduct[index].name ?? "",
                        ),
                        subtitle: const Row(
                          spacing: 5,
                          children: [
                            TagCustom(data: "Agricole"),
                            TagCustom(data: "Tubercule")
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.listProduct.length,
                );
              }))
            ],
          ),
        ));
  }
}
