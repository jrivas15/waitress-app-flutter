// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
  json.decode(str).map((x) => ProductModel.fromJson(x)),
);

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  int id;
  String name;
  dynamic description;
  double price;
  int category;
  int stock;
  int available;
  String? image;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
    required this.available,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    category: json["category"],
    stock: json["stock"],
    available: json["available"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "category": category,
    "stock": stock,
    "available": available,
    "image": image,
  };
}
