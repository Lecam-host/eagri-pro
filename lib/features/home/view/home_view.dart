import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/core/utils/router/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eagri_pro/generated/locale_keys.g.dart';
import 'package:go_router/go_router.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/bloc/theme_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Map<String, dynamic>> services = [
    {
      'title': 'Scanner',
      'subtitle': 'Scanner un QR code',
      'icon': Icons.qr_code_scanner,
      'type': 'scan',
      'route': Routes.scanQrCode.name,
    },
    {
      'title': 'Livraisons',
      'subtitle': 'Mes livraisons',
      'icon': Icons.local_shipping_outlined,
      'type': 'delivery',
      'route': Routes.orders.name,
    },
    {
      'title': 'Produits',
      'subtitle': 'Publier un produit',
      'icon': Icons.production_quantity_limits,
      'type': 'products',
      'route': Routes.selectClient.name,
    },
    // {
    //   'title': 'Commandes',
    //   'subtitle': 'Mes commandes',
    //   'icon': Icons.shopping_cart_outlined,
    //   'type': 'orders',
    //   'route': Routes.orders.name,
    // },
    // {
    //   'title': 'Stock',
    //   'subtitle': 'Gérer le stock',
    //   'icon': Icons.inventory_2_outlined,
    //   'type': 'inventory',
    //   'route': Routes.orders.name,
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstants.primaryColor,
              title: Text(LocaleKeys.home.tr(),
                  style: const TextStyle(color: Colors.white)),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                  onPressed: () => context.pushNamed(Routes.notifications.name),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('Statistiques',
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .titleLarge!
                        //         .copyWith(fontWeight: FontWeight.bold)),
                        // const SizedBox(height: 10),
                        // _buildStatisticsSection(context),
                        const SizedBox(height: 30),
                        Text('Services',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            final service = services[index];
                            return _buildServiceItem(
                              context,
                              service['title'],
                              service['subtitle'],
                              service['icon'],
                              service['type'],
                              () => context.pushNamed(service['route']),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        // const LastOrderSection(),
                      ],
                    ),
                  )
                ],
              ),
            )
            // CustomScrollView(
            //   slivers: [
            //     SliverAppBar(
            //       expandedHeight: 50,
            //       pinned: true,
            //       flexibleSpace: FlexibleSpaceBar(
            //         background: Container(
            //           decoration: BoxDecoration(
            //             gradient: LinearGradient(
            //               begin: Alignment.topCenter,
            //               end: Alignment.bottomCenter,
            //               colors: [
            //                 ColorConstants.primaryColor,
            //                 ColorConstants.primaryColor.withValues(alpha: 0.8),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       title: Text(
            //         LocaleKeys.home.tr(),
            //         style: const TextStyle(color: Colors.white),
            //       ),
            //       actions: [
            //         IconButton(
            //           icon: const Icon(
            //             Icons.notifications_none,
            //             color: Colors.white,
            //           ),
            //           onPressed: () =>
            //               context.pushNamed(Routes.notifications.name),
            //         ),
            //       ],
            //     ),
            //     SliverToBoxAdapter(
            //       child: ,
            //     ),
            //   ],
            // ),
            );
      },
    );
  }

  Widget _buildStatisticsSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            'Commandes',
            '28',
            Icons.shopping_cart_outlined,
            'orders',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            'Livraisons',
            '12',
            Icons.local_shipping_outlined,
            'delivery',
          ),
        ),
      ],
    );
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'scan':
        return Colors.blue;
      case 'orders':
        return ColorConstants.primaryColor;
      case 'delivery':
        return ColorConstants.blueColor;
      case 'inventory':
        return Colors.orange;
      case 'products':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    String type,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 90,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getColorForType(type).withValues(alpha: 0.15),
            _getColorForType(type).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getColorForType(type).withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _getColorForType(type).withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: _getColorForType(type), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getColorForType(type).withValues(alpha: 0.8),
                      ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: _getColorForType(type).withValues(alpha: 0.6),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    String type,
    VoidCallback onTap,
  ) {
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
                    color: _getColorForType(type).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: _getColorForType(type),
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
                color: _getColorForType(type),
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
}
