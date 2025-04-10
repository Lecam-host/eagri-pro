import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'text_field_custom.dart';

class DatePickerCustom extends StatelessWidget {
  final String label;
  final String? name;
  final TextEditingController controller;
  final DateFormat? dateFormat;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? valueTransformer;
  final Function(Object?)? validators;
  const DatePickerCustom(
      {super.key,
      required this.label,
      required this.controller,
      this.valueTransformer,
      this.onChanged,
      this.validators,
      this.firstDate,
      this.lastDate,
      this.dateFormat,
      this.name = "name"});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name ?? "name",
      validator: (value) {
        return validators!(value);
      },
      valueTransformer: valueTransformer,
      builder: (FormFieldState<dynamic> state) {
        return TextFieldCustom(
          label: label,
          hintText: label,
          readOnly: true,
          controller: controller,
          onTap: () async {
            print('datepicker---d-dddd');
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: firstDate ?? DateTime(1900),
              lastDate: lastDate ?? DateTime(2100),
            );
            if (date != null) {
              state.didChange(date);
              if (onChanged != null) {
                onChanged!(date);
              }

              controller.text = DateFormat.yMMMd().format(date);
            }
          },
        );
      },
    );
  }
}
