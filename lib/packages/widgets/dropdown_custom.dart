import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropdownItem {
  final String value;
  final String name;
  final Function()? onTap;

  DropdownItem({required this.value, required this.name, this.onTap});
}

class DropdownCustom extends StatelessWidget {
  final String label;
  final String hintText;
  final List<DropdownItem> items;
  final String? selectedValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? name;
  final Function(String?)? onChanged;
  final Function(dynamic)? valueTransformer;
  final Function(Object?)? validators;
  final bool? withBorder;
  final bool? requiredField;

  const DropdownCustom({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    this.selectedValue,
    this.name = "name",
    this.validators,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.valueTransformer,
    this.withBorder = true,
    this.requiredField = false,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name!,
      valueTransformer: valueTransformer,
      initialValue: selectedValue,
      validator: (value) {
        if (validators != null) {
          return validators!(value.toString());
        }
        if (requiredField! && value == null) {
          return 'Ce champ est obligatoire';
        }
        return null;
      },
      builder: (FormFieldState<dynamic> state) {
        return DropdownButtonFormField(
          hint: Text(
            hintText,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorConstants.grayScale800,
                  // fontFamily: ConstantString.inter,
                  fontWeight: FontWeight.w500,
                ),
          ),
          value: state.value,
          icon: const Icon(Icons.arrow_drop_down),
          validator: (value) {
            state.save();
            if (validators != null) {
              return validators!(value.toString());
            }
            if (requiredField! && value == null) {
              return 'Ce champ est obligatoire';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              label: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              // add border
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.only(
                  left: 22, right: 22, top: 12, bottom: 12)),
          isExpanded: true,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              onTap: item.onTap,
              value: item.value,
              child: Text(
                item.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorConstants.grayScale800,
                      // fontFamily: ConstantString.inter,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            );
          }).toList(),
          onChanged: (dynamic newValue) {
            state.didChange(newValue);
            // Assure-toi que l'onChanged n'est pas null
            if (onChanged != null) {
              onChanged!(newValue);
            }
          },
        );
      },
    );
  }
}
