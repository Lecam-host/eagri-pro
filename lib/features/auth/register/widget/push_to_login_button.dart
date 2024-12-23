import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:eagri_pro/core/utils/router/routes.dart';
import 'package:eagri_pro/features/theme/bloc/theme_bloc.dart';
import 'package:eagri_pro/features/theme/bloc/theme_state.dart';
import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/generated/locale_keys.g.dart';

class PushToLoginButton extends StatelessWidget {
  const PushToLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return TextButton(
          onPressed: () {
            context.go(Routes.login.path);
          },
          child: Text.rich(
            TextSpan(
              text: LocaleKeys.already_have_an_account.tr(),
              children: [
                TextSpan(
                  text: LocaleKeys.login.tr(),
                  style: TextStyle(
                    color: ColorConstants.blueColor,
                  ),
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
        //  CupertinoButton(
        //   padding: EdgeInsets.zero,
        //   onPressed: () {
        //     context.go(Routes.login.path);
        //   },
        //   child: Text(
        //     LocaleKeys.already_have_an_account.tr(),
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
