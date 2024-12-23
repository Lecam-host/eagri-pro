import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/helpers/ui_helper.dart';
import '../../../core/constants/color_constants.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/bloc/theme_state.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      this.onPressed,
      this.showBackButton = true});
  final String title;
  final String subtitle;
  final Function()? onPressed;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Container(
        height: UIHelper.deviceHeight * 0.3,
        width: UIHelper.deviceWidth,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: themeState.isDark
              ? ColorConstants.darkPrimaryIcon
              : ColorConstants.lightPrimaryIcon,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showBackButton)
              GestureDetector(
                onTap: onPressed ??
                    () {
                      context.pop();
                    },
                child: Icon(CupertinoIcons.back,
                    color: !themeState.isDark
                        ? ColorConstants.darkPrimaryIcon
                        : ColorConstants.lightPrimaryIcon),
              ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 40,
                color: !themeState.isDark
                    ? ColorConstants.darkPrimaryIcon
                    : ColorConstants.lightPrimaryIcon,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: !themeState.isDark
                    ? ColorConstants.darkPrimaryIcon
                    : ColorConstants.lightPrimaryIcon,
              ),
            )
          ],
        ),
      );
    });
  }
}
