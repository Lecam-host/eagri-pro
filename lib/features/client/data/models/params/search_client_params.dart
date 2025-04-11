import 'package:eagri_pro/features/client/data/models/search_criteria_model.dart';

class SearchCriteriaListParams {
  final List<SearchCriteria>? searchCriteriaList;
  final String? dataOption;

  SearchCriteriaListParams({
    this.searchCriteriaList,
    this.dataOption,
  });

  factory SearchCriteriaListParams.fromJson(Map<String, dynamic> json) =>
      SearchCriteriaListParams(
        searchCriteriaList: json["searchCriteriaList"] == null
            ? []
            : List<SearchCriteria>.from(json["searchCriteriaList"]!
                .map((x) => SearchCriteria.fromJson(x))),
        dataOption: json["dataOption"],
      );

  Map<String, dynamic> toJson() => {
        "searchCriteriaList": searchCriteriaList == null
            ? []
            : List<dynamic>.from(searchCriteriaList!.map((x) => x.toJson())),
        "dataOption": dataOption,
      };
}
