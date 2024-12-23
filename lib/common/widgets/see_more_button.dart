import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/color_constants.dart';
import '../../features/theme/bloc/theme_bloc.dart';
import '../../features/theme/bloc/theme_state.dart';
import '../../generated/locale_keys.g.dart';

Color darkColor = ColorConstants.lightBackground;
Color lightColor = ColorConstants.darkTextField;

class SeeMoreButtonWidget extends StatelessWidget {
  const SeeMoreButtonWidget(
      {super.key, required this.title, this.buttonTitle, this.onPressed});
  final String title;
  final String? buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeState.isDark ? darkColor : lightColor,
                ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: onPressed,
            label: Text(
              buttonTitle ?? LocaleKeys.see_all.tr(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: themeState.isDark ? darkColor : lightColor,
                  ),
            ),
            iconAlignment: IconAlignment.end,
            icon: Icon(
              CupertinoIcons.forward,
              size: 16,
              color: themeState.isDark ? darkColor : lightColor,
            ),
          )
        ],
      );
    });
  }
}
