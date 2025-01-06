part of "splash_view.dart";

mixin SplashViewMixin on State<SplashView> {
  final UserService _userService = UserService(di(), di());

  Future<bool> _future(BuildContext context) async {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    String? authToken = await _userService.getAuthTokenFromSP();

    if (authToken == null && !loginBloc.state.isAuthenticated) {
      loginBloc.add(const LogoutButtonPressed());
      if (context.mounted) {
        context.go(Routes.login.path);
      }
    } else if (loginBloc.state.isAuthenticated) {
      context.go(Routes.home.path);
    }
    return true;
  }

  bool _checkValues(UserModel userModel) {
    if (userModel.firstName.isEmpty) return false;
    if (userModel.lastName.isEmpty) return false;
    if (userModel.dateOfBirth.toUtc() == AppConstants.nullDate) return false;
    if (userModel.gender == 0) return false;
    return true;
  }

  void _listener(LoginState state,
      {required LoginBloc loginBloc,
      required RegisterBloc registerBloc,
      required ProfileBloc profileBloc}) {
    if (state is ValidateSuccess) {
      profileBloc.add(SetUser(user: state.user));
      registerBloc.add(const ClearRegisterData());
      context.go(Routes.login.path);
      _checkValues(state.user)
          ? context.go(Routes.home.path)
          : context.go(Routes.profile.path);
    } else if (state is ValidateFailed) {
      loginBloc.add(const LogoutButtonPressed());
      registerBloc.add(const ClearRegisterData());
      context.go(Routes.onBoarding.path);
      AppHelper.showErrorMessage(
          context: context, content: LocaleKeys.session_terminated.tr());
    }
  }
}
