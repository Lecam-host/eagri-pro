import 'dart:async';
import 'package:eagri_pro/core/utils/router/keys.dart';
import 'package:eagri_pro/features/home/view/scan_view.dart';
import 'package:eagri_pro/features/home/view/service_view.dart';
import 'package:eagri_pro/features/notification/presentation/views/notification_view.dart';
import 'package:eagri_pro/features/order/views/details_order_view.dart';
import 'package:eagri_pro/features/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/bloc/login/auth_bloc.dart';
import '../../../features/auth/presentation/auth_page.dart';
import '../../../features/home/view/home_view.dart';
import '../../../features/onboarding/onboarding_screen.dart';
import '../../../features/order/views/delivery_failure_view.dart';
import '../../../features/order/views/delivery_success_view.dart';
import '../../../features/splash/view/splash_view.dart';
import '../../../features/order/views/order_view.dart';
import 'router_observer.dart';
import 'routes.dart';

class RouterManager extends GoRouter {
  // Configuration du router avec StatefulShellBranch
  RouterManager()
      : super.routingConfig(
          initialLocation: Routes.splash.path,
          observers: <NavigatorObserver>[
            RouterObserver(),
          ],
          routingConfig: ValueNotifier<RoutingConfig>(RoutingConfig(
              redirect: (context, state) {
                final isAuth = context.read<AuthBloc>().state.status ==
                    AuthenticationStatus.authenticated;
                if (!isAuth) {
                  return Routes.login.path;
                }
                return null;
              },
              routes: <RouteBase>[
                StatefulShellRoute.indexedStack(
                  pageBuilder: (context, state, navigationShell) {
                    return getPage(
                        child: ScaffoldWithNavigation(
                            navigationShell: navigationShell),
                        state: state);
                  },
                  redirect: (context, state) {
                    // Example of auth logic
                    // if (state.location == '/protected' && !isUserLoggedIn) {
                    //   return Routes.login.path;
                    // }
                    return null;
                  },
                  branches: [
                    // Home Branch
                    StatefulShellBranch(
                      navigatorKey: PageKey.homeNavigatorKey,
                      routes: [
                        GoRoute(
                            path: Routes.home.path,
                            name: Routes.home.name,
                            pageBuilder: (context, state) =>
                                getPage(child: const HomeView(), state: state),
                            routes: [
                              GoRoute(
                                  path: Routes.notifications.path,
                                  name: Routes.notifications.name,
                                  pageBuilder: (context, state) => getPage(
                                      child: const NotificationView(),
                                      state: state)),
                              GoRoute(
                                  path: Routes.orders.path,
                                  name: Routes.orders.name,
                                  pageBuilder: (context, state) => getPage(
                                      child: const OrderView(), state: state),
                                  routes: [
                                    // Example market sub-route
                                    GoRoute(
                                        path: Routes.detailsOrders.path,
                                        name: Routes.detailsOrders.name,
                                        builder: (context, state) {
                                          final orderId = state.extra as String;
                                          return DetailsOrderView(id: orderId);
                                        }),
                                    GoRoute(
                                        path: Routes.deliverySuccess.path,
                                        name: Routes.deliverySuccess.name,
                                        builder: (context, state) {
                                          final orderId = state.extra as String;
                                          return DeliverySuccessView(
                                              orderId: orderId);
                                        }),
                                    GoRoute(
                                        path: Routes.deliveryFailure.path,
                                        name: Routes.deliveryFailure.name,
                                        builder: (context, state) {
                                          final Map<String, dynamic> args =
                                              state.extra
                                                  as Map<String, dynamic>;
                                          return DeliveryFailureView(
                                            orderId: args['orderId'],
                                            errorMessage: args['errorMessage'],
                                          );
                                        }),
                                  ])
                            ]),
                      ],
                    ),
                    // Profile Branch
                    StatefulShellBranch(
                      navigatorKey: PageKey.profileNavigatorKey,
                      routes: [
                        GoRoute(
                            path: Routes.profile.path,
                            name: Routes.profile.name,
                            pageBuilder: (context, state) =>
                                getPage(child: ProfileView(), state: state),
                            routes: [
                              GoRoute(
                                path: 'settings',
                                pageBuilder: (context, state) => getPage(
                                    child: const Scaffold(
                                      body: Center(
                                        child: Text('Profile Settings'),
                                      ),
                                    ),
                                    state: state),
                              ),
                            ]),
                      ],
                    ),
                  ],
                ),
                GoRoute(
                    path: Routes.login.path,
                    name: Routes.login.name,
                    pageBuilder: (context, state) =>
                        getPage(child: const AuthPage(), state: state)),
                GoRoute(
                    path: Routes.scanQrCode.path,
                    name: Routes.scanQrCode.name,
                    pageBuilder: (context, state) =>
                        getPage(child: const ScanView(), state: state)),
                GoRoute(
                    path: Routes.services.path,
                    name: Routes.services.name,
                    pageBuilder: (context, state) =>
                        getPage(child: const ServiceView(), state: state)),
                GoRoute(
                    path: Routes.splash.path,
                    name: Routes.splash.name,
                    pageBuilder: (context, state) =>
                        getPage(child: const SplashView(), state: state)),
                GoRoute(
                    path: Routes.onBoarding.path,
                    name: Routes.onBoarding.name,
                    pageBuilder: (context, state) =>
                        getPage(child: const OnboardingScreen(), state: state)),
              ])),
        );
}

Page getPage({
  required Widget child,
  required GoRouterState state,
}) {
  return MaterialPage(
    key: state.pageKey,
    child: child,
  );
}

// Navigation Shell Widget

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({required this.navigationShell, Key? key})
      : super(key: key ?? const ValueKey<String>('ScaffoldWithNavigation'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        backgroundColor: Colors.white,
        elevation: 0,
        onDestinationSelected: (index) {
          navigationShell.goBranch(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
            selectedIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}

// Stream for router refresh
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
