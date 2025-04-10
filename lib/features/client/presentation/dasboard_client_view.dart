import 'package:eagri_pro/common/components/button_custom.dart';
import 'package:eagri_pro/common/components/custom_text_field.dart';
import 'package:eagri_pro/common/widgets/app_bar_custom.dart';
import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/features/client/data/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/components/basic_card_custom.dart';
import '../../../core/utils/router/routes.dart';

class DasboardClientView extends StatelessWidget {
  final ClientModel client;
  const DasboardClientView({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Dashboard"),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50),
            const SizedBox(height: 10),
            Text("${client.user!.firstName!} ${client.user!.lastName!}",
                style: Theme.of(context).textTheme.titleLarge),
            Text(client.user!.phone!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey[600])),
            const SizedBox(height: 10),
            const Row(
              spacing: 10,
              children: [
                Expanded(
                    child: BasicCardCustom(
                  title: "Products",
                  subtitle: "15",
                  icon: Icons.production_quantity_limits,
                )),
                Expanded(
                    child: BasicCardCustom(
                  title: "Orders",
                  subtitle: "12",
                  icon: Icons.production_quantity_limits,
                ))
              ],
            ),
            // Do action (Publish products, Make a request)
            const SizedBox(height: 10),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              children: [
                _buildServiceItem(
                  context: context,
                  title: "Products",
                  subtitle: "Publish products",
                  icon: Icons.production_quantity_limits,
                  onTap: () =>
                      context.pushNamed(Routes.chooseTypePublication.name),
                ),
                _buildServiceItem(
                  context: context,
                  title: "Buy products",
                  subtitle: "Make a request",
                  icon: Icons.request_page_outlined,
                  onTap: () => showDialogChooseMethodScan(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

showDialogChooseMethodScan(BuildContext context) {
  final controller = TextEditingController();
  final selectedMethod = ValueNotifier<String>("");

  final choice = [
    {
      "title": "Scan",
      "value": "scan",
    },
    {
      "title": "By ID",
      "value": "id",
    }
  ];
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Choose method"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: StatefulBuilder(builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...choice.map((e) {
                  return Expanded(
                    child: InkWell(
                      onTap: () => setState(() {
                        selectedMethod.value = e["value"]!;
                      }),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: selectedMethod.value == e["value"]
                              ? ColorConstants.primaryColor
                                  .withValues(alpha: .1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: .1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(e["title"]!, textAlign: TextAlign.center),
                      ),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 10),
            if (selectedMethod.value == "id")
              Column(
                children: [
                  const CustomTextField(),
                  const SizedBox(height: 10),
                  ButtonCustom(label: "Valider", onPressed: () {})
                ],
              ),
          ],
        );
      }),
    ),
  );
}

Widget _buildServiceItem(
    {required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: Colors.grey[600],
                  size: 28,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
