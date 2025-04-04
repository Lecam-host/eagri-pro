import 'package:eagri_pro/core/utils/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/widgets/app_bar_custom.dart';
import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/enum.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class ChooseTypePublicationPage extends StatefulWidget {
  const ChooseTypePublicationPage({super.key});

  @override
  State<ChooseTypePublicationPage> createState() =>
      _ChooseTypePublicationPageState();
}

class _ChooseTypePublicationPageState extends State<ChooseTypePublicationPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getTypePublication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCustom(title: "Choix du type de produit"),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == Status.error) {
              return Center(child: Text(state.errorMessage!));
            }
            return ListView.builder(
                itemCount: state.listTypePublication.length,
                itemBuilder: (context, index) {
                  final item = state.listTypePublication[index];
                  return ListTile(
                    onTap: () => context.pushNamed(
                        Routes.selectedProductPage.name,
                        extra: {"type": item}),
                    leading:
                        SvgPicture.asset(ConstantIcons.serviceBusinessIcon),
                    title: Text(item.name.toUpperCase(),
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                )),
                    subtitle: Text(
                      item.description ?? "Le produit est disponible",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  );
                });
          }),
        ));
  }
}
