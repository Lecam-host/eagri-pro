import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../packages/widgets/dropdown_custom.dart';

class MultiSelectDropdownCustom extends StatelessWidget {
  final String label;
  final String hintText;
  final List<DropdownItem> items;
  final List<String>? selectedValues;
  final String? name;
  final Function(List<String>)? onChanged;
  final Function(dynamic)? valueTransformer;
  final Function(Object?)? validators;
  final bool? requiredField;
  final bool? withBorder;

  const MultiSelectDropdownCustom({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    this.selectedValues,
    this.name = "multiSelect",
    this.onChanged,
    this.valueTransformer,
    this.validators,
    this.requiredField = false,
    this.withBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<String>>(
      name: name!,
      initialValue: selectedValues,
      valueTransformer: valueTransformer,
      validator: (value) {
        if (validators != null) {
          return validators!(value);
        }
        if (requiredField! && (value == null || value.isEmpty)) {
          return 'Ce champ est obligatoire';
        }
        return null;
      },
      builder: (FormFieldState<List<String>> state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MultiSelectDialogField<String>(
                items: items
                    .map((e) => MultiSelectItem<String>(e.value, e.name))
                    .toList(),
                initialValue: state.value ?? [],
                title: Text(label),
                searchable: true,
                selectedColor: ColorConstants.primaryColor,
                buttonIcon: const Icon(Icons.arrow_drop_down),
                buttonText: Text(
                  hintText,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorConstants.grayScale800,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                decoration: BoxDecoration(
                  border: withBorder!
                      ? Border.all(color: Colors.grey, width: 1.5)
                      : Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                chipDisplay: MultiSelectChipDisplay(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorConstants.grayScale800,
                        fontWeight: FontWeight.w500,
                      ),
                  chipColor: Colors.white,
                  onTap: (value) {
                    final newList = List<String>.from(state.value ?? [])
                      ..remove(value);
                    state.didChange(newList);
                    if (onChanged != null) onChanged!(newList);
                  },
                ),
                onConfirm: (values) {
                  state.didChange(values);
                  if (onChanged != null) onChanged!(values);
                },
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    state.errorText ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.red),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
