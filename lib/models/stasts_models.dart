// To parse this JSON data, do
//
//     final statsModel = statsModelFromJson(jsonString);

import 'dart:convert';

List<StatsModel> statsModelFromJson(String str) =>
    List<StatsModel>.from(json.decode(str).map((x) => StatsModel.fromJson(x)));

String statsModelToJson(List<StatsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatsModel {
  String name;
  dynamic value;

  StatsModel({required this.name, required this.value});

  factory StatsModel.fromJson(Map<String, dynamic> json) =>
      StatsModel(name: json["name"], value: json["value"]);

  Map<String, dynamic> toJson() => {"name": name, "value": value};
}
