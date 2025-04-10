import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../common/form-builder-validators.dart';
import '../models/formulaire_model.dart';
import 'date_picker_custom.dart';
import 'dropdown_custom.dart';
import 'text_field_custom.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({
    super.key,
    required this.form,
  });
  final List<DataFormulaireModel>? form;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  var isVerifyHidden = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var j = 0; j < widget.form!.length; j++) ...[
              if (widget.form![j].type == "input") ...[
                // Text(widget.form![j].label),
                TextFieldCustom(
                  onChanged: (value) {},
                  name: widget.form![j].name,
                  label: "Entrer ${widget.form![j].label}",
                  hintText: "Entrer ${widget.form![j].label}",
                  withBorder: true,
                  maxLines: int.parse(widget.form![j].maxLines!),
                  keyboardType:
                      getKeyBoardTypeBytype(widget.form![j].subtype ?? "text"),
                  validators: FormBuilderValidators.compose(
                      generateRuleFonction(widget.form![j].rules)),
                )
              ],
              if (widget.form![j].type == "date") ...[
                //  Text(widget.form![j].label),
                DatePickerCustom(
                  name: widget.form![j].name,
                  label: widget.form![j].label,
                  controller: TextEditingController(),
                  dateFormat: DateFormat.yMMMd(),
                  onChanged: (p0) {},
                  valueTransformer: (value) {
                    if (value != null) {
                      return value.toString();
                    }
                  },
                  validators: FormBuilderValidators.compose(
                      generateRuleFonction(widget.form![j].rules)),
                )
              ],
              if (widget.form![j].type == "select") ...[
                //  Text(widget.form![j].label),
                DropdownCustom(
                    onChanged: (value) {},
                    name: widget.form![j].name,
                    hintText: widget.form![j].placeholder,
                    label: widget.form![j].label,
                    items: widget.form![j].options!.map((option) {
                      return DropdownItem(
                        value: option.value,
                        name: option.label,
                      );
                    }).toList())
              ],
              const SizedBox(height: 10),
              if (widget.form![j].type == "file") ...[
                FormBuilderFilePicker(
                  onChanged: (value) {},
                  name: widget.form![j].name,
                  decoration: InputDecoration(labelText: widget.form![j].label),
                  maxFiles: null,
                  withData: false,
                  previewImages: true,
                  validator: FormBuilderValidators.compose(
                      generateRuleFonction(widget.form![j].rules)),
                  typeSelectors: [
                    TypeSelector(
                      type: widget.form![j].subtype == "video"
                          ? FileType.image
                          : FileType.media,
                      selector: Row(
                        children: <Widget>[
                          const Icon(Icons.add_circle),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(widget.form![j].placeholder),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onFileLoading: (val) {
                    print(val);
                  },
                )
              ],
              if (widget.form![j].type == "checkbox") ...[
                FormBuilderCheckboxGroup(
                  name: widget.form![j].name,
                  decoration: InputDecoration(
                    labelText: widget.form![j].label,
                  ),
                  onChanged: (value) {},
                  options: widget.form![j].options!.map((option) {
                    return FormBuilderFieldOption(
                      value: option.toJson(),
                      child: Text(option.label),
                    );
                  }).toList(),
                )
              ],
              const SizedBox(height: 10),
              if (widget.form![j].type == "radio") ...[
                FormBuilderRadioGroup(
                  name: widget.form![j].name,
                  decoration: InputDecoration(
                    labelText: widget.form![j].label,
                  ),
                  onChanged: (value) {},
                  options: widget.form![j].options!.map((option) {
                    return FormBuilderFieldOption(
                      value: option.toJson(),
                      child: Text(option.label),
                    );
                  }).toList(),
                )
              ],
              if (widget.form![j].type == "multiselect") ...[
                FormBuilderChoiceChip(
                    name: widget.form![j].name,
                    validator: FormBuilderValidators.compose([
                      if (widget.form![j].rules[0].required == true) ...[
                        FormBuilderValidators.required(
                            errorText: widget.form![j].rules[0].message)
                      ]
                    ]),
                    spacing: 10,
                    options: widget.form![j].options!.map((option) {
                      return FormBuilderChipOption(
                        value: option.toJson(),
                        child: Text(option.label),
                      );
                    }).toList()),
              ],
            ],
          ],
        ),
        // Obx(() => controller.load.value
        //     ? const CircularProgressIndicator()
        //     : MaterialButton(
        //         color: Theme.of(context).colorScheme.secondary,
        //         onPressed: () async {
        //           // Validate and save the form values
        //           // controller.formKey.value.currentState?.saveAndValidate();
        //           //  debugPrint(controller.formKey.currentState?.value.toString());
        //           // On another side, can access all field values without saving form with instantValues
        //           controller.formKey.value.currentState?.validate();
        //           await controller.getData();
        //           // print(controller.formKey.value.currentState?.instantValue
        //           //     .toString());

        //           // debugPrint(controller.formKey.currentState?.instantValue.toString());
        //         },
        //         child: const Text('Login'),
        //       ))
      ],
    );
  }

  // isShow(Item item, int index) {
  //   if (item.conditions != null && item.conditions!.condition.isNotEmpty) {
  //     for (var i = 0; i < item.conditions!.condition.length; i++) {
  //       widget.listInputItem[index].vArticle.formData.forEach((element) {
  //         if (element.conditionBy == item.name) {
  //           controller.isVerifyHidden.addAll({item.condition![i].target: true});
  //           inspect(controller.isVerifyHidden);
  //         } else {
  //           controller.isVerifyHidden
  //               .addAll({item.condition![i].target: false});
  //           inspect(controller.isVerifyHidden);
  //         }
  //       });
  //       //  controller.isVerifyHidden.add(item.condition![i].target);
  //     }
  //   } else {
  //     inspect(controller.isVerifyHidden);
  //   }
  // }
}

List<FormFieldValidator<dynamic>> generateRuleFonction(List<Rule> rules) {
  List<FormFieldValidator<dynamic>> listRules = [];
  for (var index = 0; index < rules.length; index++) {
    var rule = rules[index];
    if (rule.max != null) {
      listRules
          .add(FormBuilderValidators.max(rule.max!, errorText: rule.message));
    }
    if (rule.required == true) {
      listRules.add(FormBuilderValidators.required(errorText: rule.message));
    }
    if (rule.type != null) {
      listRules.add((value) {
        return FormValidator.validateInputType(rule.type!, rule.message)(value);
      });
    }
    if (rule.min != null) {
      listRules
          .add(FormBuilderValidators.min(rule.min!, errorText: rule.message));
    }
  }
  return listRules;
}

getKeyBoardTypeBytype(String type) {
  switch (type) {
    case "number":
      return TextInputType.number;
    case "email":
      return TextInputType.emailAddress;
    case "date":
      return TextInputType.datetime;
    case "password":
      return TextInputType.visiblePassword;
    case "phone":
      return TextInputType.phone;
    case "text":
      return TextInputType.text;
    case "url":
      return TextInputType.url;
    case "textarea":
      return TextInputType.multiline;
    default:
      return TextInputType.text;
  }
}
