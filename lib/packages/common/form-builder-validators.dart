import 'package:form_builder_validators/form_builder_validators.dart';

class FormValidator {
  static validateInputType(String type, String errorText) {
    switch (type) {
      case "number":
        return FormBuilderValidators.numeric(errorText: errorText);
      case "email":
        return FormBuilderValidators.email(errorText: errorText);
    } 
  }
}

