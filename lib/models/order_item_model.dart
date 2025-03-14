// To parse this JSON data, do
//
//     final orderItemModel = orderItemModelFromJson(jsonString);

import 'dart:convert';

import 'package:meseros_app/models/modifier_model.dart';
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
  dynamic state;
  ProductModel product;
  List<ModifierModel> modifiers;
  double subtotal;

  OrderItemModel({
    this.id,
    required this.quantity,
    this.order,
    required this.note,
    required this.state,
    required this.product,
    required this.subtotal,
    required this.modifiers,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
    id: json["id"],
    quantity: json["quantity"],
    order: json["order"],
    state: json["state"],
    note: json["note"],
    product: ProductModel.fromJson(json["product"]),
    subtotal: json["subtotal"],
    modifiers: List<ModifierModel>.from(
      json["modifiers"].map((x) => ModifierModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "order": order,
    "state": state,
    "note": note,
    "modifiers": List<dynamic>.from(modifiers.map((x) => x.toJson())),
    "product": product.toJson(),
    "subtotal": subtotal,
  };
}
