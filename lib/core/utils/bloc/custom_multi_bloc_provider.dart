import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/auth/login/bloc/login_bloc.dart';
import '../../../features/auth/register/bloc/register_bloc.dart';
import '../../../features/profile/bloc/profile_bloc.dart';
import '../../../features/profile/service/user_service.dart';
import '../../../features/theme/bloc/theme_bloc.dart';
import '../../../injection_container.dart';

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
        BlocProvider(
            create: (context) =>
                LoginBloc(userService: UserService(di(), di()), loginUsecase: di())),
        BlocProvider(
            create: (context) =>
                RegisterBloc(userService: UserService(di(), di()))),
        BlocProvider(
            create: (context) =>
                ProfileBloc(userService: UserService(di(), di()))),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: child,
    );
  }
}
