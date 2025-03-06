// To parse this JSON data, do
//
//     final zonesModel = zonesModelFromJson(jsonString);

import 'dart:convert';

List<ZonesModel> zonesModelFromJson(String str) =>
    List<ZonesModel>.from(json.decode(str).map((x) => ZonesModel.fromJson(x)));

String zonesModelToJson(List<ZonesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZonesModel {
  int id;
  String name;

  ZonesModel({
    required this.id,
    required this.name,
  });

  factory ZonesModel.fromJson(Map<String, dynamic> json) => ZonesModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
