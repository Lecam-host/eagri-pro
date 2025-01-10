import 'dart:async';
import 'package:eagri_pro/features/auth/bloc/login/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/enum.dart';
import '../../../core/utils/router/routes.dart';
part "splash_view_mixin.dart";

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SplashViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        Timer(
          const Duration(seconds: 2),
          () {
            if (mounted) {
              if (state.stateStatus == Status.success) {
                context.go(Routes.home.path);
              }
            }
          },
        );
      },
      builder: (context, state) {
        return const CupertinoPageScaffold(
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      },
    );
  }
}
