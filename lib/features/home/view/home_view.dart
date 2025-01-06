import 'package:eagri_pro/common/components/basic_card_custom.dart';
import 'package:eagri_pro/features/order/views/last_order_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eagri_pro/generated/locale_keys.g.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/bloc/theme_event.dart';
import '../../theme/bloc/theme_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.home).tr(),
          actions: [
            IconButton(
              icon: Icon(
                themeState.isDark ? Icons.wb_sunny : Icons.nightlight_round,
              ),
              onPressed: () {
                context
                    .read<ThemeBloc>()
                    .add(ChangeTheme(isDark: true, useDeviceTheme: false));
              },
            )
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 10,
                children: [
                  Expanded(
                      child:
                          BasicCardCustom(title: "VALIDER", subtitle: "100")),
                  Expanded(
                      child: BasicCardCustom(
                          title: "EN ATTENTE", subtitle: "1 200"))
                ],
              ),
              SizedBox(height: 30),
              LastOrderSection(),
            ],
          ),
        ),
      );
    });
  }
}
