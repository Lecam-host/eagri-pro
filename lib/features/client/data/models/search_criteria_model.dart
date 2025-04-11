class SearchCriteria {
  final String? filterKey;
  final String? value;
  final String? operation; // eq (equal) , cn (contains)
  final String? dataOption;

  SearchCriteria({
    this.filterKey,
    this.value,
    this.operation,
    this.dataOption,
  });

  factory SearchCriteria.fromJson(Map<String, dynamic> json) => SearchCriteria(
        filterKey: json["filterKey"],
        value: json["value"],
        operation: json["operation"],
        dataOption: json["dataOption"],
      );

  Map<String, dynamic> toJson() => {
        "filterKey": filterKey,
        "value": value,
        "operation": operation,
        "dataOption": dataOption,
      };
}

