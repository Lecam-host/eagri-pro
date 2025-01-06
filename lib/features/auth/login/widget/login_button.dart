import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/helpers/ui_helper.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/bloc/theme_state.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final void Function()? onPressed;
  const LoginButton(
      {super.key, this.isLoading = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return SizedBox(
          width: UIHelper.deviceWidth,
          child: CupertinoButton(
            color: ColorConstants.primaryColor,
            onPressed: isLoading ? null : onPressed,
            borderRadius: const BorderRadius.all(
                Radius.circular(AppConstants.borderRadius)),
            padding: const EdgeInsets.all(10),
            disabledColor: themeState.isDark
                ? ColorConstants.darkPrimaryIcon
                : ColorConstants.lightPrimaryIcon,
            pressedOpacity: 0.5,
            child: isLoading
                ? const CupertinoActivityIndicator(
                    color: CupertinoColors.white,
                  )
                : Text(LocaleKeys.login,
                    style: TextStyle(
                      color: !themeState.isDark
                          ? ColorConstants.lightBackground
                          : ColorConstants.darkSecondaryIcon,
                    )).tr(),
          ),
        );
      },
    );
  }
}
