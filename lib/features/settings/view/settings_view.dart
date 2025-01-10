import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/supported_locales.dart';
import '../../../core/utils/router/routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/bloc/theme_event.dart';
import '../../theme/bloc/theme_state.dart';
part "settings_view_mixin.dart";

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SettingsViewMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
    // final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    // return BlocBuilder<LoginBloc, LoginState>(
    //   builder: (context, loginState) {
    //     return BlocBuilder<ProfileBloc, ProfileState>(
    //       builder: (context, profileState) {
    //         return BlocBuilder<ThemeBloc, ThemeState>(
    //           builder: (context, themeState) {
    //             return Scaffold(
    //               body: SafeArea(
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Text("settings".tr()),
    //                 ),
    //               ),
    //             );
    //           },
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
