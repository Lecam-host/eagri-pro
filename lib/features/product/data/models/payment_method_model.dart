class PaymentMethod {
  int id;
  String code;
  String nom;

  PaymentMethod({
    required this.id,
    required this.code,
    required this.nom,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        code: json["code"],
        nom: json["nom"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "nom": nom,
      };
}

class Product {
  int id;
  String name;
  int code;
  String numberIdentification;
  String unit;
  String productImage;

  Product({
    required this.id,
    required this.name,
    required this.code,
    required this.numberIdentification,
    required this.unit,
    required this.productImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        numberIdentification: json["numberIdentification"],
        unit: json["unit"],
        productImage: json["productImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "numberIdentification": numberIdentification,
        "unit": unit,
        "productImage": productImage,
      };
}
