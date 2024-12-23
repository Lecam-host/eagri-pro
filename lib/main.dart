import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:eagri_pro/firebase_options.dart';

import 'common/helpers/ui_helper.dart';
import 'core/services/shared_preferences_service.dart';
import 'core/services/theme_service.dart';
import 'core/utils/bloc/custom_multi_bloc_provider.dart';
import 'core/utils/localization/localization_manager.dart';
import 'core/utils/router/router_manager.dart';
import 'features/theme/bloc/theme_bloc.dart';
import 'features/theme/bloc/theme_state.dart';
import 'injection_container.dart';

void main() async {
  await configureDependencies();

  await dotenv.load();
  await SharedPreferencesService.instance.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ThemeService.getTheme();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    CustomMultiBlocProvider(
      child: LocalizationManager(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    ThemeService.initialize(context);
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    ThemeService.autoChangeTheme(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    UIHelper.initialize(context);
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Template App',
        theme: ThemeService.buildTheme(themeState),
        debugShowCheckedModeBanner: false,
        routerConfig: RouterManager.router,
      );
    });
  }
}
