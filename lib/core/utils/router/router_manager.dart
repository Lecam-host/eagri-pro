import 'dart:async';
import 'package:eagri_pro/features/order/views/order_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/login/view/login_view.dart';
import '../../../features/auth/password/view/forgot_password_view.dart';
import '../../../features/auth/register/view/register_view.dart';
import '../../../features/home/view/home_view.dart';
import '../../../features/onboarding/onboarding_screen.dart';
import '../../../features/profile/view/profile_view.dart';
import '../../../features/splash/view/splash_view.dart';
import 'router_observer.dart';
import 'routes.dart';

class RouterManager {
  RouterManager._();

  // Navigation keys
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorMarketKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorProfileKey = GlobalKey<NavigatorState>();

  // Router configuration
  static GoRouter get router => GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: Routes.initial.path,
        observers: <NavigatorObserver>[RouterObserver()],
        debugLogDiagnostics: true,
        // Global redirect for auth
        redirect: (context, state) {
          // Add your auth logic here
          return null;
        },
        routes: [
          // Main Shell Route with Bottom Navigation
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return ScaffoldWithNavigation(navigationShell: navigationShell);
            },
            branches: [
              // Home Branch
              StatefulShellBranch(
                navigatorKey: _shellNavigatorHomeKey,
                routes: [
                  GoRoute(
                      path: Routes.home.path,
                      name: Routes.home.name,
                      builder: (context, state) => const HomeView(),
                      routes: [
                        // Add sub-routes for home here
                      ]),
                ],
              ),

              // Market Branch
              StatefulShellBranch(
                navigatorKey: _shellNavigatorMarketKey,
                routes: [
                  GoRoute(
                      path: Routes.market.path,
                      name: Routes.market.name,
                      builder: (context, state) => const OrderView(),
                      routes: [
                        // Add market sub-routes here
                      ]),
                ],
              ),

              // Profile Branch
              StatefulShellBranch(
                navigatorKey: _shellNavigatorProfileKey,
                routes: [
                  GoRoute(
                      path: Routes.profile.path,
                      name: Routes.profile.name,
                      builder: (context, state) => const ProfileView(),
                      routes: [
                        // Add profile sub-routes here
                      ]),
                ],
              ),
            ],
          ),

          // Auth Routes (outside shell)
          GoRoute(
            path: Routes.login.path,
            name: Routes.login.name,
            builder: (context, state) => const LoginView(),
            routes: [
              // GoRoute(
              //   path: Routes.forgotPassword.path,
              //   name: Routes.forgotPassword.name,
              //   builder: (context, state) =>  ForgotPasswordView(),
              // ),
              GoRoute(
                path: Routes.register.path,
                name: Routes.register.name,
                builder: (context, state) => const RegisterView(),
              ),
            ],
          ),

          // Splash and Onboarding
          GoRoute(
            path: Routes.initial.path,
            builder: (context, state) => const SplashView(),
          ),
          GoRoute(
            path: Routes.onBoarding.path,
            name: Routes.onBoarding.name,
            builder: (context, state) => const OnboardingScreen(),
          ),
        ],
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
            icon: Icon(Icons.shopping_cart),
            label: 'Market',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Stream for router refresh
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
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
