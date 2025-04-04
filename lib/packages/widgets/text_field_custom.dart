import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
  final Function(String?)? validators;

  const TextFieldCustom(
      {super.key,
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
      this.onSubmitted});

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
              suffixIcon: suffixIcon,
              label:
                  Text(label, style: Theme.of(context).textTheme.labelMedium),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.only(
                  left: 20.0, right: 15.0, top: 15.0, bottom: 15.0),
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
                  color: textColor ?? ColorConstants.grayScale800,
                  // fontFamily: ConstantString.inter,
                  fontWeight: FontWeight.w600,
                ),
            validator: (value) {
              state.save();
              if (validators != null) {
                return validators!(value.toString());
              }
              if (requiredField! && value!.isEmpty) {
                return "Ce champ est obligatoire";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          );
          // Container(
          //   height: 56,
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     border: withBorder!
          //         ? Border.all(color: ConstantColors.lightGray)
          //         : null,
          //   ),
          //   child: Row(
          //     children: [
          //       if (prefixIcon != null) prefixIcon!.marginOnly(right: 10),
          //       Expanded(
          //         child:
          //         TextField(
          //           controller: controller,
          //           obscureText: obscureText,
          //           readOnly: readOnly,
          //           onTap: onTap,
          //           maxLines: maxLines ?? 1,
          //           inputFormatters: inputFormatters,
          //           onSubmitted: onSubmitted,
          //           keyboardType: keyboardType,
          //           decoration: InputDecoration(
          //             label: Text(label,
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .bodySmall!
          //                     .copyWith(
          //                       color: textColor ?? ConstantColors.grayScale800,
          //                     )),
          //             hintText: hintText,
          //             errorText: state.errorText,
          //             hintStyle:
          //                 Theme.of(context).textTheme.bodySmall!.copyWith(
          //                       color: textColor ?? ConstantColors.grayScale800,
          //                       fontFamily: ConstantString.inter,
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //             border: InputBorder.none,
          //             //  prefixIcon: prefixIcon,
          //           ),
          //           onChanged: (value) {
          //             state.didChange(value);
          //             if (onChanged != null) {
          //               onChanged!(state.value);
          //             }
          //           },
          //         ),
          //       ),
          //       const SizedBox(width: 10),
          //       if (suffixIcon != null) suffixIcon!.marginOnly(left: 10),
          //       //const Icon(Icons.abc_outlined)
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}

class TextFormFieldCustom extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool? withBorder;
  final TextInputType? keyboardType;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Color? textColor;

  const TextFormFieldCustom(
      {super.key,
      required this.label,
      this.keyboardType,
      required this.hintText,
      this.obscureText = false,
      this.readOnly = false,
      this.maxLines,
      this.textColor,
      this.onChanged,
      this.prefixIcon,
      this.onTap,
      this.maxLength,
      this.suffixIcon,
      this.controller,
      this.inputFormatters,
      this.validator,
      this.withBorder = true,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (prefixIcon != null) prefixIcon!.marginOnly(right: 10),
          Expanded(
            child: TextFormField(
              validator: validator,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              obscureText: obscureText,
              readOnly: readOnly,
              onTap: onTap,
              maxLength: maxLength,
              maxLines: maxLines ?? 1,
              controller: controller,
              decoration: InputDecoration(
                label:
                    Text(label, style: Theme.of(context).textTheme.labelMedium),
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.only(
                    left: 20.0, right: 15.0, top: 15.0, bottom: 15.0),
              ),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: textColor ?? ColorConstants.grayScale800,
                    // fontFamily: ConstantString.inter,
                    fontWeight: FontWeight.w600,
                  ),
              //  InputDecoration(
              //   hintText: hintText,
              //   hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              //         color: ConstantColors.grayScale800,
              //         fontFamily: ConstantString.inter,
              //         fontWeight: FontWeight.w500,
              //       ),
              //   border: InputBorder.none,
              //   //  prefixIcon: prefixIcon,
              // ),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 10),
          if (suffixIcon != null) suffixIcon!.marginOnly(left: 10),
          //const Icon(Icons.abc_outlined)
        ],
      ),
    );
  }
}
