import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // style: TextStyle(
      //   color: isLoading
      //       ? themeState.isDark
      //           ? ColorConstants.darkInactive
      //           : ColorConstants.lightInactive
      //       : themeState.isDark
      //           ? ColorConstants.darkPrimaryIcon
      //           : ColorConstants.lightPrimaryIcon,
      // ),
    );
  }
}
