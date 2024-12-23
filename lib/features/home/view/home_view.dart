import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eagri_pro/generated/locale_keys.g.dart';

import '../../../common/helpers/ui_helper.dart';
import '../../../common/widgets/see_more_button.dart';
import '../../theme/bloc/theme_bloc.dart';
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
        // appBar: AppBar(
        //   title: const Text(LocaleKeys.home),
        // ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: UIHelper.deviceHeight * 0.01,
                      ),
                      SeeMoreButtonWidget(
                        title: LocaleKeys.store_in_vogue.tr(),
                      ),
                      SizedBox(
                        height: UIHelper.deviceHeight * 0.01,
                      ),
                      SeeMoreButtonWidget(
                        title: LocaleKeys.upcoming.tr(),
                      ),
                    ],
                  )),

              // ...List.generate(
              //   7,
              //   (index) => Container(
              //     margin: const EdgeInsets.only(bottom: 10),
              //     width: UIHelper.deviceWidth,
              //     height: 150,
              //     decoration: BoxDecoration(
              //       color: Theme.of(context).colorScheme.primaryContainer,
              //       borderRadius: const BorderRadius.all(Radius.circular(10)),
              //     ),
              //     child: Center(child: Text(index.toString())),
              //   ),
              // )
            ],
          ),
        ),
      );
    });
  }
}
