// To parse this JSON data, do
//
//     final tableModel = tableModelFromJson(jsonString);

import 'dart:convert';

List<TableModel> tableModelFromJson(String str) =>
    List<TableModel>.from(json.decode(str).map((x) => TableModel.fromJson(x)));

String tableModelToJson(List<TableModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableModel {
  int id;
  int tableNumber;
  int capacity;
  int zone;
  String state;
  int? waitress;
  int? order;

  TableModel({
    required this.id,
    required this.tableNumber,
    required this.capacity,
    required this.zone,
    required this.state,
    this.waitress,
    this.order,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
    id: json["id"],
    tableNumber: json["table_number"],
    capacity: json["capacity"],
    zone: json["zone"],
    state: json["state"],
    waitress: json["waitress"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "table_number": tableNumber,
    "capacity": capacity,
    "zone": zone,
    "state": state,
    "waitress": waitress,
    "order": order,
  };
}
