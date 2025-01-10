part of "splash_view.dart";

mixin SplashViewMixin on State<SplashView> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<AuthBloc>().add(const CheckAuthentification());
    }
  }
}
