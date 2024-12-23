import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/router/routes.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/bloc/theme_state.dart';

class PushToRegisterButton extends StatelessWidget {
  const PushToRegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return TextButton(
          onPressed: () {
            context.push(Routes.register.path);
          },
          child: Text.rich(
            TextSpan(
              text: LocaleKeys.dont_have_an_account.tr(),
              children: [
                TextSpan(
                  text: LocaleKeys.sign_up.tr(),
                  style: TextStyle(color: ColorConstants.blueColor),
                ),
              ],
            ),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: themeState.isDark
                      ? ColorConstants.lightBackground
                      : ColorConstants.darkSecondaryIcon,
                ),
          ),
        );

        // CupertinoButton(
        //   padding: EdgeInsets.zero,
        //   onPressed: () {
        //     context.go(Routes.register.path);
        //   },
        //   child: Text(
        //     LocaleKeys.register,
        //     style: TextStyle(
        //       color: themeState.isDark
        //           ? ColorConstants.darkPrimaryIcon
        //           : ColorConstants.lightPrimaryIcon,
        //     ),
        //   ).tr(),
        // );
      },
    );
  }
}
