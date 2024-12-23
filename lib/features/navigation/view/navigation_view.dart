import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/generated/locale_keys.g.dart';
import 'package:eagri_pro/features/home/view/home_view.dart';
import 'package:eagri_pro/features/settings/view/settings_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  late CupertinoTabController tabController;

  @override
  void initState() {
    tabController = CupertinoTabController();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: tabController,
      tabBar: CupertinoTabBar(
        border: const Border(),
        currentIndex: 0,
        backgroundColor: Colors.transparent,
        activeColor: CupertinoDynamicColor.withBrightness(
          color: ColorConstants.lightPrimaryIcon,
          darkColor: ColorConstants.darkPrimaryIcon,
        ),
        inactiveColor: CupertinoDynamicColor.withBrightness(
          color: ColorConstants.lightInactive,
          darkColor: ColorConstants.darkInactive,
        ),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag_outlined),
            label: LocaleKeys.home.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.receipt_long),
            label: LocaleKeys.payments.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            label: LocaleKeys.settings.tr(),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return const HomeView();
              },
            );

          case 1:
            return CupertinoTabView(
              builder: (context) {
                return const SettingsView();
              },
            );

          default:
            tabController.index = 0;
            return const HomeView();
        }
      },
    );
  }
}
