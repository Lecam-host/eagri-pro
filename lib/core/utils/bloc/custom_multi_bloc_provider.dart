import 'package:eagri_pro/features/auth/bloc/login/auth_bloc.dart';
import 'package:eagri_pro/features/client/presentation/cubit/client_cubit.dart';
import 'package:eagri_pro/features/order/cubit/order_cubit.dart';
import 'package:eagri_pro/injection_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/product/presentation/cubit/product_cubit.dart';
import '../../../features/theme/bloc/theme_bloc.dart';

class CustomMultiBlocProvider extends StatelessWidget {
  final Widget child;
  const CustomMultiBlocProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => di<AuthBloc>()),
        BlocProvider(create: (context) => di<OrderCubit>()),
        BlocProvider(create: (context) => di<ClientCubit>()),
        BlocProvider(create: (context) => di<ProductCubit>()),
      ],
      child: child,
    );
  }
}
