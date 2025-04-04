import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/color_constants.dart';
import '../../features/theme/bloc/theme_bloc.dart';
import '../../features/theme/bloc/theme_state.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool enabled;
  final Widget? suffix;
  final String? placeholder;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final void Function(String)? onSubmitted;
  const CustomTextField({
    super.key,
    this.controller,
    this.enabled = true,
    this.suffix,
    this.placeholder,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscureText = false;
  @override
  void initState() {
    isObscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return CupertinoTextField(
            controller: widget.controller,
            onSubmitted: (value) {
              widget.onSubmitted != null ? widget.onSubmitted!(value) : null;
            },
            
            obscureText: isObscureText,
            suffix: suffixWidget(),
            placeholder: widget.placeholder,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            padding: const EdgeInsets.all(10),
            style: const TextStyle(
              color: CupertinoDynamicColor.withBrightness(
                color: CupertinoColors.black,
                darkColor: CupertinoColors.white,
              ),
            ),
            enabled: widget.enabled,
            prefix: widget.prefixIcon != null
                ? CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: null,
                    child: Icon(
                      widget.prefixIcon,
                      color: themeState.isDark
                          ? ColorConstants.darkPrimaryIcon
                          : ColorConstants.lightPrimaryIcon,
                    ),
                  )
                : null,
            decoration: BoxDecoration(
              color: CupertinoDynamicColor.withBrightness(
                color: ColorConstants.lightTextField,
                darkColor: ColorConstants.darkTextField,
              ),
              border: Border.all(
                color: CupertinoDynamicColor.withBrightness(
                  color: ColorConstants.lightBackgroundColorActivated,
                  darkColor: ColorConstants.darkBackgroundColorActivated,
                ),
                width: 0.5,
              ),
              borderRadius: const BorderRadius.all(
                  Radius.circular(AppConstants.borderRadius)),
            ),
            cursorColor: themeState.isDark
                ? ColorConstants.darkPrimaryIcon
                : ColorConstants.lightPrimaryIcon,
            onChanged: (value) {
              widget.onChanged != null ? widget.onChanged!(value) : null;
            });
      },
    );
  }

  Widget suffixWidget() {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.suffix ?? const SizedBox(),
            widget.obscureText
                ? CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      isObscureText
                          ? CupertinoIcons.eye_solid
                          : CupertinoIcons.eye_slash_fill,
                      color: themeState.isDark
                          ? ColorConstants.darkSecondaryIcon
                          : ColorConstants.lightSecondaryIcon,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}

class TextFieldCustom extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final bool readOnly;
  final String? name;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool? withBorder;
  final TextInputType? keyboardType;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final bool? requiredField;
  final int? maxLines;
  final Color? textColor;
  final Function(Object?)? validators;

  const TextFieldCustom({
    super.key,
    required this.label,
    this.keyboardType,
    required this.hintText,
    this.obscureText = false,
    this.readOnly = false,
    this.name = "name",
    this.onChanged,
    this.prefixIcon,
    this.onTap,
    this.suffixIcon,
    this.maxLines = 1,
    this.controller,
    this.inputFormatters,
    this.withBorder = true,
    this.requiredField = false,
    this.validators,
    this.textColor,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FormBuilderField(
        name: name!,
        validator: (value) {
          if (validators != null) {
            return validators!(value.toString());
          }
          if (requiredField! && value == null) {
            return "Ce champ est obligatoire";
          }
          return null;
        },
        builder: (FormFieldState<dynamic> state) {
          return TextFormField(
            readOnly: readOnly,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              label: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w300),
              // prefixIcon: prefixIcon,
              // suffixIcon: suffixIcon,
              border: withBorder!
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  : InputBorder.none,
              contentPadding: const EdgeInsets.only(
                left: 20.0,
                right: 15.0,
                top: 18.0,
                bottom: 18.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 1.5, color: ColorConstants.lightTextField),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(width: 1.5, color: ColorConstants.primaryColor),
              ),
            ),
            onTap: onTap,
            onSaved: (value) {
              state.didChange(value);
              if (onChanged != null) {
                onChanged!(value!);
              }
            },
            onChanged: (value) {
              state.didChange(value);
              if (onChanged != null) {
                onChanged!(value);
              }
            },
            onFieldSubmitted: (value) {
              state.didChange(value);
              if (onSubmitted != null) {
                onSubmitted!(value);
              }
            },
            inputFormatters: inputFormatters,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor ?? Colors.black,
                  fontWeight: FontWeight.w600,
                ),
            validator: (value) {
              state.save();
              if (validators != null) {
                return validators!(value.toString());
              }
              if (requiredField! && (value == null || value.isEmpty)) {
                return "Ce champ est obligatoire";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          );
        },
      ),
    );
  }
}
