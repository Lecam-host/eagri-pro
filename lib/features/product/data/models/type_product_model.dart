class TypeProductModel {
  final int id;
  final String name;
  final String? description;
  final int code;

  TypeProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.code,
  });

  factory TypeProductModel.fromJson(Map<String, dynamic> json) {
    return TypeProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      code: json['code'],
    );
  }
}
