// To parse this JSON data, do
//
//     final orderItemModel = orderItemModelFromJson(jsonString);

import 'dart:convert';

import 'package:meseros_app/models/product_model.dart';

List<OrderItemModel> orderItemModelFromJson(String str) =>
    List<OrderItemModel>.from(
      json.decode(str).map((x) => OrderItemModel.fromJson(x)),
    );

String orderItemModelToJson(List<OrderItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderItemModel {
  int? id;
  int quantity;
  int? order;
  dynamic note;
  ProductModel product;
  double subtotal;

  OrderItemModel({
    this.id,
    required this.quantity,
    this.order,
    required this.note,
    required this.product,
    required this.subtotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
    id: json["id"],
    quantity: json["quantity"],
    order: json["order"],
    note: json["note"],
    product: ProductModel.fromJson(json["product"]),
    subtotal: json["subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "order": order,
    "note": note,
    "product": product.toJson(),
    "subtotal": subtotal,
  };
}
