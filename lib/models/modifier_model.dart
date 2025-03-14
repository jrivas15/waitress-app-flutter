// To parse this JSON data, do
//
//     final modifierModel = modifierModelFromJson(jsonString);

import 'dart:convert';

List<ModifierModel> modifierModelFromJson(String str) =>
    List<ModifierModel>.from(
      json.decode(str).map((x) => ModifierModel.fromJson(x)),
    );

String modifierModelToJson(List<ModifierModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModifierModel {
  int id;
  String name;
  double price;
  int product;

  ModifierModel({
    required this.id,
    required this.name,
    required this.price,
    required this.product,
  });

  factory ModifierModel.fromJson(Map<String, dynamic> json) => ModifierModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "product": product,
  };
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModifierModel && other.id == id && other.name == name;
    // Compara otros campos si es necesario...
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
