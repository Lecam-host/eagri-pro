import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String label;
  final bool? isLoading;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Function() onPressed;

  const ButtonCustom(
      {super.key,
      required this.label,
      required this.onPressed,
      this.icon,
      this.textColor,
      this.backgroundColor,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading != null && isLoading! ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: backgroundColor ?? ColorConstants.secondaryColor,
        ),
        child: isLoading != null && isLoading!
            ? const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null)
                    Row(children: [icon!, const SizedBox(width: 10)]),
                  Text(label,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontFamily: 'Inter',
                          color: textColor ?? Colors.white,
                          fontSize: 17))
                ],
              ),
      ),
    );
  }
}
