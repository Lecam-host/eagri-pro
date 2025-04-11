class SearchProductArticleParams {
  final String name;
  final int parentId;

  SearchProductArticleParams({required this.name, required this.parentId});

  Map<String, dynamic> toJson() => {
        "name": name,
        "parentId": parentId,
      };
}
