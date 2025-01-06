import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/generated/locale_keys.g.dart';
import 'package:eagri_pro/features/home/view/home_view.dart';
import 'package:eagri_pro/features/settings/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/router/routes.dart';

class NavigationView extends StatefulWidget {
  final Widget child;

  const NavigationView({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  late CupertinoTabController _tabController;

  int _getCurrentIndex(BuildContext context) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    if (location.startsWith(Routes.home.path)) return 0;
    if (location.startsWith(Routes.orders.path)) return 1;
    if (location.startsWith(Routes.settings.path)) return 2;
    return 0;
  }

  @override
  void initState() {
    super.initState();
    _tabController = CupertinoTabController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);

    return CupertinoTabScaffold(
      controller: _tabController..index = currentIndex,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/navigations/home.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 0
                    ? ColorConstants.primaryColor
                    : ColorConstants.darkBackground,
                BlendMode.srcIn,
              ),
            ),
            label: LocaleKeys.home.tr(),
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == 1
                    ? ColorConstants.primaryColor.withOpacity(0.1)
                    : Colors.transparent,
              ),
              child: SvgPicture.asset(
                'assets/icons/navigations/order.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? ColorConstants.primaryColor
                      : ColorConstants.darkBackground,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: LocaleKeys.my_orders.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/navigations/account.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 2
                    ? ColorConstants.primaryColor
                    : ColorConstants.darkBackground,
                BlendMode.srcIn,
              ),
            ),
            label: LocaleKeys.settings.tr(),
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(Routes.notifications.path);
              break;
            case 1:
              context.go(Routes.orders.path);
              break;
            case 2:
              context.go(Routes.settings.path);
              break;
          }
        },
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => widget.child,
        );
      },
    );
  }
}
