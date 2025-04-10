// To parse this JSON data, do
//
//     final formulaireModel = formulaireModelFromJson(jsonString);

import 'dart:convert';

FormulaireModel formulaireModelFromJson(String str) =>
    FormulaireModel.fromJson(json.decode(str));

String formulaireModelToJson(FormulaireModel data) =>
    json.encode(data.toJson());

class FormulaireModel {
  List<DataFormulaireModel>? data;

  FormulaireModel({
    this.data,
  });

  factory FormulaireModel.fromJson(Map<String, dynamic> json) =>
      FormulaireModel(
        data: json["data"] != null
            ? List<DataFormulaireModel>.from(
                json["data"].map((x) => DataFormulaireModel.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : null,
      };
}

class DataFormulaireModel {
  String name;
  String type;
  String label;
  List<Rule> rules;
  String? maxLines;
  String? subtype;
  dynamic position;
  String placeholder;
  List<Option>? options;
  List<Condition>? condition;

  DataFormulaireModel({
    required this.name,
    required this.type,
    required this.label,
    required this.rules,
    required this.subtype,
    required this.position,
    required this.placeholder,
    this.condition,
    this.options,
    this.maxLines = "1",
  });

  factory DataFormulaireModel.fromJson(Map<String, dynamic> json) =>
      DataFormulaireModel(
        name: json["name"],
        type: json["type"],
        label: json["label"],
        rules: List<Rule>.from(json["rules"].map((x) => Rule.fromJson(x))),
        subtype: json["subtype"],
        position: json["position"],
        placeholder: json["placeholder"],
        maxLines: json["maxLines"] == null ? "1" : json["maxLines"].toString(),
        condition: json["conditions"] == null
            ? []
            : List<Condition>.from(
                json["conditions"]!.map((x) => Condition.fromJson(x)),
            ),
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "label": label,
        "rules": List<dynamic>.from(rules.map((x) => x.toJson())),
        "subtype": subtype,
        "position": position,
        "maxLines": maxLines,
        "placeholder": placeholder,
        "conditions": condition == null
            ? []
            : List<dynamic>.from(condition!.map((x) => x.toJson())),
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  String label;
  String value;

  Option({
    required this.label,
    required this.value,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}

class Rule {
  String message;
  bool? required;
  int? maxLines;
  int? max;
  int? min;
  String? trigger;
  String? type;

  Rule({
    required this.message,
    this.required,
    this.trigger,
    this.max,
    this.min,
    this.maxLines,
    this.type,
  });

  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
        message: json["message"],
        required: json["required"] ?? false,
        max: json["max"],
        min: json["min"],
        maxLines: json["maxLines"],
        type: json["type"],
        trigger: json["trigger"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "required": required,
        "trigger": trigger,
        "max": max,
        "min": min,
        "maxLines": maxLines,
        "type": type,
      };
}

class Condition {
    final String? action;
    final String? target;
    final String? condition;

    Condition({
        this.action,
        this.target,
        this.condition,
    });

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        action: json["action"],
        target: json["target"],
        condition: json["condition"],
    );

    Map<String, dynamic> toJson() => {
        "action": action,
        "target": target,
        "condition": condition,
    };
}
